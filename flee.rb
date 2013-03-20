require 'nokogiri' # helps parse xml
require 'kramdown' # markdown implementation

class Blog
  attr_accessor :pages
  def initialize (filename)
    @filename = filename
    document = Nokogiri::XML File.open(filename).read
    @pages = Array.new
    items = document.xpath("//item")
    items.each_with_index do |item, index|
      @pages.push Page.new(item)
      # break if index == 4
    end
  end
  def print_blog
    foldername = @filename.gsub(/\.xml$/, '')
    @foldername = foldername
    i = 1
    until Dir.exists?(@foldername) == false
      @foldername = "#{i}-#{foldername}"
      i += 1
    end
    `mkdir #{@foldername}`
    @pages.each do |page|
      str = "---\ntitle: #{page.title}\n---\n\n#{page.markdown}"
      page_filename = page.title.downcase.gsub(/\s+/, '-').gsub(/[^\w\d]/, '') + ".md"
      File.open("#{@foldername}/#{page_filename}", 'w') { |file| file.write(str) }
    end
  end
end

class Page
  attr_accessor :title, :permalink, :link, :pubDate, :html, :markdown, :type, :post_id, :status, :tags, :categories, :link
  def initialize (item)
    @title = item.xpath("title").children.to_s
    @permalink = item.xpath("link").children.to_s
    @pubDate = item.xpath("pubDate").children.to_s
    @html = item.xpath("content:encoded").children.to_s.slice(9..-4)
    @markdown = Kramdown::Document.new(@html, :input => 'html').to_kramdown
    @type = item.xpath("wp:post_type").children.to_s
    @post_id = item.xpath("wp:post_id").children.to_s
    @status = item.xpath("wp:status").children.to_s
    link = item.xpath("wp:postmeta/wp:meta_value").children.to_s
    if link != ""
      @type = "linkpost"
      @link = link
    end
    @categories = []
    @tags = []
    metas = item.xpath("category")
    metas.each do |meta|
      kind = meta.attributes["domain"].children.to_s # "category" or "post_tag"
      nickname = meta.attributes["nicename"].to_s # tag or category name
      proper_name = meta.children.to_s.slice(9..-4)
      if kind == "category"
        @categories.push({:nickname => nickname, :proper_name => proper_name})
      elsif kind == "post_tag"
        @tags.push({:nickname => nickname, :proper_name => proper_name})
      else
        puts "#{kind} is neither a 'post_tag' nor a 'category'"
      end
    end
  end
end

blog = Blog.new ARGV[0]
blog.print_blog
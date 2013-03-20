require 'nokogiri' # helps parse xml
require 'kramdown' # markdown implementation
require 'progressbar' # for nice output

class Blog
  attr_accessor :pages
  def initialize (xml, filename)
    @filename = filename
    document = Nokogiri::XML xml
    @pages = Array.new
    items = document.xpath("//item")
    pbar = ProgressBar.new("Reading", items.length)
    items.each_with_index do |item, index|
      @pages.push Page.new(item)
      # break if index == 4
      pbar.inc
    end
    pbar.finish
  end
  def write
    foldername = @filename.gsub(/\.xml$/, '')
    @foldername = foldername
    i = 1
    until Dir.exists?(@foldername) == false
      @foldername = "#{i}-#{foldername}"
      i += 1
    end
    pbar = ProgressBar.new("Writing", @pages.length)
    `mkdir #{@foldername}`
    @pages.each do |page|
      str = "---\n"
      str << "title: #{page.title}\n" if page.title.nil? == false
      str << "date: #{page.date.strftime "%Y-%m-%d %H:%M:%S %z"}\n"
      if page.categories.length > 0
        str << "categories: [#{page.categories.join(", ")}]\n"
      end
      if page.tags.length > 0
        str << "tags: [#{page.tags.join(", ")}]\n"
      end
      if page.type == "linkpost"
        str << "link: #{page.link}\n"
      end
      str << "---\n\n"
      str << page.markdown
      page_filename = "#{page.date.strftime('%Y-%m-%d')}-#{page.title.downcase.gsub(/\s+/, '-').gsub(/[^-\w\d]/,'')}.md"
      File.open("#{@foldername}/#{page_filename}", 'w') { |file| file.write(str) }
      pbar.inc
    end
    pbar.finish
    puts "Written to #{@foldername}/"
  end
end

class Page
  attr_accessor :title, :permalink, :link, :date, :html, :markdown,
    :type, :post_id, :status, :tags, :categories, :link
  def initialize (item)
    @title = item.xpath("title").children.to_s
    @permalink = item.xpath("link").children.to_s
    date = item.xpath("pubDate").children.to_s
    @date = pubdate_to_ruby_time(date)
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
      # nickname = meta.attributes["nicename"].to_s # tag or category name
      proper_name = meta.children.to_s.slice(9..-4)
      if kind == "category"
        @categories.push proper_name
        # @categories.push({:nickname => nickname, :proper_name => proper_name})
      elsif kind == "post_tag"
        @tags.push proper_name
        # @tags.push({:nickname => nickname, :proper_name => proper_name})
      end
    end
  end
  def pubdate_to_ruby_time (str)
    pattern = /\w{3}, (\d{2}) (\w{3}) (\d{4}) (\d{2}):(\d{2}):(\d{2}) (\+\d{4})/
    match = str.match(pattern)
    day = match[1]
    month = match[2]
    year = match[3]
    hour = match[4]
    # weird error: many posts have publish times at 24 oclock.
    # was causing errors when trying to construct a ruby time object. out of range
    # what the hell? I'm assuming that means midnight
    hour = "0" if hour == "24"
    minute = match[5]
    second = match[6].to_i
    offset = match[7].sub(/(\d{2})(\d{2})/,'\1:\2')
    return Time.new year, month, day, hour, minute, second, offset
  end
end





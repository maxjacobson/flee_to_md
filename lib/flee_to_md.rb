require 'rubygems'
require 'nokogiri' # helps parse xml
require 'kramdown' # markdown implementation
require 'ruby-progressbar' # for nice output
require 'open-uri'

module Flee_to_md
  VERSION = "0.1.0"
  LAST_UPDATED = "2013-04-10"
  class Blog
    attr_accessor :pages
    def initialize (xml, filename)
      @filename = filename
      document = Nokogiri::XML normalize(xml)
      @pages = Array.new
      items = document.xpath("//item")
      prog = ProgressBar.create(:title => "Reading", :total => items.length)
      items.each_with_index do |item, index|
        @pages.push Page.new(item)
        # break if index == 4
        prog.increment
      end
    end
    def normalize(xml)
      # iron out some kinks that are causing errors
      xml.gsub(/data-image/, 'src')
    end
    def write
      foldername = @filename.gsub(/\.xml$/, '')
      @foldername = foldername
      i = 1
      until File.exists?(@foldername) == false
        @foldername = "#{i}-#{foldername}"
        i += 1
      end
      prog = ProgressBar.create(:title => "Writing", :total => @pages.length)
      Dir.mkdir @foldername
      Dir.mkdir "#{@foldername}/attachments"
      @pages.each do |page|
        if page.attachment_url != "" # is an attachment
          extension = /(\.[\w\d]+)$/
          if page.attachment_url =~ extension
            filename = "#{page.title}#{page.attachment_url.match(extension)[1]}"
          else
            filename = page.title
          end
          open(page.attachment_url) do |f|
            File.open("#{@foldername}/attachments/#{filename}","wb") do |file|
              file.puts f.read
            end
          end
        else # is not an attachment
          str = "---\n"
          str << "title: '#{page.title}'\n"
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
          str << page.markdown.gsub(/\\("|'|\[|\]|\:)/,'\1')
          page_filename = "#{page.date.strftime('%Y-%m-%d')}-#{page.title.downcase.gsub(/\s+/, '-').gsub(/[^-\w\d]/,'')}.md".gsub(/[^\w\d](.md)$/, '.md')
          File.open("#{@foldername}/#{page_filename}", 'w') { |file| file.write(str) }
        end
        prog.increment
      end
      puts "Written to #{@foldername}/"
      return @foldername
    end
  end

  class Page
    attr_accessor :title, :permalink, :link, :date, :html, :markdown,
      :type, :post_id, :status, :tags, :categories, :link,
      :attachment_url, :attachment_filename
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
      @attachment_url = item.xpath("wp:attachment_url").children.to_s
      if @attachment_url != ""
        @attachment_filename = item.xpath("wp:post_name").children.to_s
        @type = "file"
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
      if RUBY_VERSION.to_f >= 1.9
        return Time.new year, month, day, hour, minute, second, offset
      else
        return Time.local(year, month, day, hour, minute, second)
      end
    end
  end
end

require_relative "lib"

filename = ARGV[0]
xml = File.open(filename).read
Blog.new(xml, filename).write
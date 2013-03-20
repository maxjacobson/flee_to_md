# v0.0.3

require File.expand_path('../flee_lib', __FILE__)

filename = ARGV[0]
xml = File.open(filename).read
folder = Blog.new(xml, filename).write

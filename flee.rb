# v0.0.5

require File.expand_path('../lib', __FILE__)

filename = ARGV[0]
xml = File.open(filename).read
folder = Blog.new(xml, filename).write

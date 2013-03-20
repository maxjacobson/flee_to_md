# v0.0.2
require_relative 'flee_lib'

filename = ARGV[0]
xml = File.open(filename).read
folder = Blog.new(xml, filename).write

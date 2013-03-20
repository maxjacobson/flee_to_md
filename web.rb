require 'sinatra'
require 'haml'
require_relative 'flee_lib'

get '/' do
  haml :home
end
post '/' do
  xml = params[:xml]
  folder = Blog.new(xml, "output").write
  `zip -r #{folder}.zip #{folder} -x ".*"`
  send_file "#{folder}.zip", :filename => "#{folder}.zip"
end
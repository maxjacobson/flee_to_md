require 'sinatra'
require_relative 'flee_lib'

get '/' do
  haml :home
end
post '/' do
  xml = params[:xml]
  folder = Blog.new(xml, "output").write
  `zip -r #{folder}.zip #{folder} -x ".*"`
  send_file "#{folder}.zip", :filename => "#{folder}.zip"#, :buffer_size => 3145728 # 3mb
end
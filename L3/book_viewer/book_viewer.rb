require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @title = "This is a test title!"
  @toc_txt = File.readlines('./data/toc.txt')
  
  erb :home
end

get "/chapters/1" do
  @title   = 'Chapter 1'
  @toc_txt = File.readlines('./data/toc.txt')
  @chapter = File.read('./data/chp1.txt')
  
  erb :chapter
end

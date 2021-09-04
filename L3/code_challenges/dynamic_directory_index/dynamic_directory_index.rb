require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

get "/" do
  @file_names = Dir.children('public')
  
  case params[:sort_order]
  when "Sort ascending"  then @sort_order = "ascending"
  when "Sort descending" then @sort_order = "descending"
  end
  
  erb :home
end
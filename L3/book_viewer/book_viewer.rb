require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

helpers do
  def in_paragraphs(text)
    raw_paragraphs(text).join
  end
  
  def raw_paragraphs(text)
    unique_id = 0
    text.split("\n\n").map do |paragraph|
      unique_id += 1
      "<p id=#{unique_id}>#{paragraph}</p>"
    end
  end
  
  def find_relevant_paragraphs(input, number)
    selected_paragraphs = []
    text                = File.read("./data/chp#{number}.txt")
    paragraph_array     = raw_paragraphs(text)
    
    paragraph_array.each do |paragraph|
      selected_paragraphs << paragraph if paragraph.include?(input)
    end
    selected_paragraphs
  end
  
  def find_relevant_chapters(input)
    result_hash = {}
    (1..@contents.size).each do |number|
      result_hash[number] = find_relevant_paragraphs(input, number)
    end
    result_hash.select { |chapter, paragraph_array| paragraph_array != [] }
  end
end

before do
  @contents = File.readlines('./data/toc.txt')
end

not_found do
  redirect "/"
end
  
get "/" do
  @title = "This is a test title!"
  
  erb :home
end

get "/chapters/:number" do
  number       = params[:number].to_i
  chapter_name = @contents[number - 1]
  
  redirect "/" unless (1..@contents.size).cover?(number)

  @title    = "Chapter #{number}: #{chapter_name}"
  @chapter  = File.read("./data/chp#{number}.txt")
  
  erb :chapter
end

get "/search" do
  @results = find_relevant_chapters(params[:query]) if params[:query]
  
  erb :search
end

get "/show/:name" do
  puts params[:name]
end

require 'erb'

template_file = File.read('example.erb')
erb_object = ERB.new(template_file)
p erb_object.result
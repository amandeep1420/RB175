require "socket"

def parse_request(request_line)
  http_method, path_and_params, http = request_line.split(' ')
  path, params = path_and_params.split("?")
  params = (params || "").split("&").each_with_object({}) do |pair, hash|
             key, value = pair.split('=')
             hash[key] = value
           end
  [http_method, path, params]
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept
  
  request_line = client.gets
  puts request_line
  
  next unless request_line
  
  http_method, path, params = parse_request(request_line)

  
  client.puts "HTTP/1.0 200 OK"
  client.puts "Content-Type: text/html"
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  client.puts "<pre>"
  client.puts http_method
  client.puts path
  client.puts params
  client.puts "</pre>"  
  
  client.puts "<h1>Counter</h1>"
  
  numbers = params["number"].to_i
  
  client.puts "<p>The current number is #{number}.</p>"
  
  # client.puts "<h1>Rolls!</h1>"
  
  # rolls = params["rolls"].to_i
  # sides = params["sides"].to_i
  # rolls.times do
  #   roll = (rand(sides) + 1)
  #   client.puts "<p>", roll, "</p>"
  # end
  
  client.puts "<a href='?number=#{number + 1}'>Add one</a>"
  client.puts "<a href='?number=#{number - 1}'>Subtract one</a>"
  client.puts "</body>"
  client.puts "</html>"
  
  client.close
end



# my solution:
# components = "GET /?rolls=2&sides=6 HTTP/1.1".split(' ')

# http_method = components[0]

# second_component = components[1]

# path, raw_params = second_component.split("?")

# raw_params_array = raw_params.split("&")

# paramss = raw_params_array.each_with_object({}) do |string, hash|
#           key_value_array = string.split('=')
#           hash[key_value_array[0]] = key_value_array[1]
#         end

# p components     
# p http_method
# p paramss
# p path


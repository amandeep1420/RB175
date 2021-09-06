text = File.read('./test_text.txt')

p "<p>" + text.gsub(/\n\n/, "\n</p>\n").gsub(/\n"/, "\n<p>\"")
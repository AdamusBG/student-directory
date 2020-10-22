File.open(__FILE__, "r") do |file|
  # a quine is a program that can read its own source code
  file.readlines.each do |line|
    puts line
  end
end
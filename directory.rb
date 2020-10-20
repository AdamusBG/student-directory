# creating methods to print information
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  #return array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(people)
  people.each_with_index do |person, index|
    puts "#{index + 1}. #{person[:name]} (#{person[:cohort]} cohort)"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

# nothing happens until the methods are called
students = input_students
print_header
print(students)
print_footer(students)

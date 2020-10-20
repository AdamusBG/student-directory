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
    students << {name: name.capitalize, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  #return array of students
  students
end

def print_specific_students
  puts "Would you like to print all students or only those beginning with a specific letter?"
  puts "Enter 'all' for all students or a letter for only students beginning with that letter"
  letter = gets.chomp.upcase
  letter
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(people, letter)
  if letter == "ALL"
    person_number = 1
    people.each do |person|
      if person[:name].length < 12
        puts "#{person_number}. #{person[:name]} (#{person[:cohort]} cohort)"
        person_number += 1
      end
    end
  else
    person_number = 1
    people.each do |person|
      if person[:name][0] == letter && person[:name].length < 12
        puts "#{person_number}. #{person[:name]} (#{person[:cohort]} cohort)"
        person_number += 1
      end
    end
  end 
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

# nothing happens until the methods are called
students = input_students
letter_to_print = print_specific_students
print_header
print(students, letter_to_print)
print_footer(students)

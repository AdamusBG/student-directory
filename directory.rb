# creating methods to print information
def input_students
  puts "Please enter the names of the first student".center(200)
  puts "To finish, don't enter a name and press return".center(200)
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do #hobby, country of birth, height
    # ask for hobby
    puts "Please enter this student's favourite hobby".center(200)
    hobby = gets.chomp
    hobby = "not provided" if hobby.empty?
    # ask for country of birth
    puts "Please enter this student's country of birth".center(200)
    country_of_birth = gets.chomp
    country_of_birth = "not provided" if country_of_birth.empty?
    # ask for height
    puts "Please enter this student's height in cm".center(200)
    height = gets.chomp
    height = "not provided" if height.empty?
    # add the student hash to the array
    students << {name: name.capitalize, cohort: :november, hobby: hobby.capitalize,
                 country_of_birth: country_of_birth.capitalize, height: height.capitalize}
    puts "Now we have #{students.count} students".center(200)
    # get another name from the user
    puts "Please enter the name of the next student, or press return to cancel".center(200)
    name = gets.chomp
  end
  # return array of students
  students
end

def print_specific_students
  puts "Would you like to print all students or only those beginning with a specific letter?".center(200)
  puts "Enter 'all' for all students or a letter for only students beginning with that letter".center(200)
  letter = gets.chomp.upcase
  letter = "ALL" if letter.empty?
  letter
end

def print_header
  puts "The students of Villains Academy".center(200)
  puts "-------------".center(200)
end

def print(people, letter)
  if letter == "ALL"
    person_number = 1
    people.each do |person|
      if person[:name].length < 12
        puts "#{person_number}. #{person[:name]} (#{person[:cohort]} cohort)".center(200)
        puts "   #{person[:name]} was born in #{person[:country_of_birth]}, is #{person[:height]} cm tall and enjoys #{person[:hobby]}.".center(200)
        person_number += 1
      end
    end
  else
    person_number = 1
    people.each do |person|
      if person[:name][0] == letter && person[:name].length < 12
        puts "#{person_number}. #{person[:name]} (#{person[:cohort]} cohort)".center(200)
        puts "   #{person[:name]} was born in #{person[:country_of_birth]}, is #{person[:height]} cm tall and enjoys #{person[:hobby]}.".center(200)
        person_number += 1
      end
    end
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(200)
end

# nothing happens until the methods are called
students = input_students
letter_to_print = print_specific_students
print_header
print(students, letter_to_print)
print_footer(students)

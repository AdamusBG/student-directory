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

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(people)
  # create a copy of the array which we can mutate without affecting student number count in print_footer method
  copy_of_people = people.map(&:clone)
  person_number = 1
  # use of the while loop, deleting the 0th index in the copied array each time 
  while !copy_of_people.empty?
    if copy_of_people[0][:name].length < 12 # only those people with names under 12 chars. get printed
      puts "#{person_number}. #{copy_of_people[0][:name]} (#{copy_of_people[0][:cohort]} cohort)"
      person_number += 1
      copy_of_people.delete_at(0)
    else # people with names over 12 chars. still need to be removed from the array to exit the loop
      copy_of_people.delete_at(0)
    end
  end
end # the use of the while loop to control the flow of this method is clunky and forced

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

# nothing happens until the methods are called
students = input_students
print_header
print(students)
print_footer(students)

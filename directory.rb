# creating methods to print information
def input_students
  puts "Please enter the names of the first student"
  puts "To finish, don't enter a name and press return"
  # create an empty array
  students = []
  # get the first name
  name = gets.strip
  # while the name is not empty, repeat this code
  while !name.empty? do
    # taking the cohort and handling
    puts "Is this student in the february, may, august or november cohort?"
    legal_cohorts = ["february", "may", "august", "november"]
    cohort = gets.strip
    until legal_cohorts.include?(cohort)
      puts "You entered an invalid cohort, please try again."
      cohort = gets.strip
    end
    # ask for hobby
    puts "Please enter this student's favourite hobby"
    hobby = gets.strip
    hobby = "not provided" if hobby.empty?
    # ask for country of birth
    puts "Please enter this student's country of birth"
    country_of_birth = gets.strip
    country_of_birth = "not provided" if country_of_birth.empty?
    # ask for height
    puts "Please enter this student's height in cm"
    height = gets.strip
    height = "not provided" if height.empty?
    # add the student hash to the array
    students << {name: name.capitalize, cohort: cohort.to_sym, hobby: hobby.capitalize,
                 country_of_birth: country_of_birth.capitalize, height: height.capitalize}
    puts "Now we have #{students.count} students" if students.count > 1
    puts "Now we have #{students.count} student" if students.count == 1
    # get another name from the user
    puts "Please enter the name of the next student, or press return to cancel"
    name = gets.strip
  end
  # return array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(people)
  cohort_hash = {february: [], may: [], august: [], november: []}
  people.each do |person|
    cohort_hash[person[:cohort]].push(person)
  end
  cohort_hash.each_pair do |cohort, people|
    if !people.empty?
      person_number = 1
      puts "Students in #{cohort.to_s.capitalize} cohort:"
      people.each do |person|
        puts "#{person_number}. #{person[:name]}"
        puts "   #{person[:name]} was born in #{person[:country_of_birth]}, is #{person[:height]} cm tall and enjoys #{person[:hobby]}."
        person_number += 1
      end
      puts ""
    end
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students" if names.count > 1
  puts "Overall, we have #{names.count} great student" if names.count == 1
end

def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" #we'll be adding more later
    # 2. read and saveuser input
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      students = input_students # if 1 is entered twice, the already entered students will be overwritten
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit # terminates program
    else
      puts "Invalid selection, please try again"
    end
  end
end

# nothing happens until the methods are called
interactive_menu

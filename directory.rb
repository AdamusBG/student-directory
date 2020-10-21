# creating methods to print information
def input_students
  puts "Please enter the names of the first student".center(200)
  puts "To finish, don't enter a name and press return".center(200)
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # taking the cohort and handling
    puts "Is this student in the february, may, august or november cohort?".center(200)
    legal_cohorts = ["february", "may", "august", "november"]
    cohort = gets.chomp
    until legal_cohorts.include?(cohort)
      puts "You entered an invalid cohort, please try again.".center(200)
      cohort = gets.chomp
    end
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
    students << {name: name.capitalize, cohort: cohort.to_sym, hobby: hobby.capitalize,
                 country_of_birth: country_of_birth.capitalize, height: height.capitalize}
    puts "Now we have #{students.count} students".center(200) if students.count > 1
    puts "Now we have #{students.count} student".center(200) if students.count == 1
    # get another name from the user
    puts "Please enter the name of the next student, or press return to cancel".center(200)
    name = gets.chomp
  end
  # return array of students
  students
end

def print_header
  puts "The students of Villains Academy".center(200)
  puts "-------------".center(200)
end

def print(people)
  cohort_hash = {february: [], may: [], august: [], november: []}
  people.each do |person|
    cohort_hash[person[:cohort]].push(person)
    # puts "#{person_number}. #{person[:name]} (#{person[:cohort]} cohort)".center(200)
    # puts "   #{person[:name]} was born in #{person[:country_of_birth]}, is #{person[:height]} cm tall and enjoys #{person[:hobby]}.".center(200)
    # person_number += 1
  end
  cohort_hash.each_pair do |cohort, people|
    if !people.empty?
      person_number = 1
      puts "Students in #{cohort.to_s.capitalize} cohort:".center(200)
      people.each do |person|
        puts "#{person_number}. #{person[:name]}".center(200)
        puts "#{person[:name]} was born in #{person[:country_of_birth]}, is #{person[:height]} cm tall and enjoys #{person[:hobby]}.".center(200)
        person_number += 1
      end
      puts ""
    end
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(200) if names.count > 1
  puts "Overall, we have #{names.count} great student".center(200) if names.count == 1
end

# nothing happens until the methods are called
students = input_students
print_header
print(students)
print_footer(students)

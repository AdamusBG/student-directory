@students = [] #empty

# methods for inputting students
def input_students
  puts "Please enter the names of the first student"
  puts "To finish, don't enter a name and press return"
  # get the first name
  name = STDIN.gets.strip
  # while the name is not empty, repeat this code
  while !name.empty? do
    # taking the cohort and handling
    puts "Is this student in the february, may, august or november cohort?"
    legal_cohorts = ["february", "may", "august", "november"]
    cohort = STDIN.gets.strip
    until legal_cohorts.include?(cohort)
      puts "You entered an invalid cohort, please try again."
      cohort = STDIN.gets.strip
    end
    # ask for hobby
    puts "Please enter this student's favourite hobby"
    hobby = STDIN.gets.strip
    hobby = "not provided" if hobby.empty?
    # ask for country of birth
    puts "Please enter this student's country of birth"
    country_of_birth = STDIN.gets.strip
    country_of_birth = "not provided" if country_of_birth.empty?
    # ask for height
    puts "Please enter this student's height in cm"
    height = STDIN.gets.strip
    height = "not provided" if height.empty?
    # add the student hash to the array
    @students << {name: name.capitalize, cohort: cohort.to_sym, hobby: hobby.capitalize,
                 country_of_birth: country_of_birth.capitalize, height: height.capitalize}
    puts "Now we have #{@students.count} students" if @students.count > 1
    puts "Now we have #{@students.count} student" if @students.count == 1
    # get another name from the user
    puts "Please enter the name of the next student, or press return to cancel"
    name = STDIN.gets.strip
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

# methods for printing

def print_students_list
  cohort_hash = {february: [], may: [], august: [], november: []}
  @students.each do |person|
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

def print_footer
  puts "Overall, we have #{@students.count} great students" if @students.count > 1
  puts "Overall, we have #{@students.count} great student" if @students.count == 1
end

# methods for controlling the menu

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" #we'll be adding more later
end

def process(selection)
  case selection
  when "1"
    input_students # if 1 is entered twice, the already entered students will be overwritten
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit # terminates program
  else
    puts "Invalid selection, please try again"
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

# methods for reading and writing to file

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:country_of_birth], student[:height], student[:hobby]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, country_of_birth, height, hobby = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym, hobby: hobby,
                  country_of_birth: country_of_birth, height: height}
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

# nothing happens until the methods are called
try_load_students
interactive_menu

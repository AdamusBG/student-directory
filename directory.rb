@students = [] #empty

# methods for inputting students
def input_students
  puts "Please enter the names of the first student"
  puts "To finish, don't enter a name and press return"
  # get the first name
  name = STDIN.gets.strip
  # while the name is not empty, repeat this code
  while !name.empty? do
    # call method for cohort
    cohort = input_student_cohort
    # call method for hobby
    hobby = input_student_hobby
    # call method for country of birth
    country_of_birth = input_student_country
    # call method for for height
    height = input_student_height
    # add the student hash to the array
    add_students_to_array(name, cohort, hobby, country_of_birth, height)
    current_student_count_message
    # get another name from the user
    puts "Please enter the name of the next student, or press return to cancel"
    name = STDIN.gets.strip
  end
end

# gets the student's cohort, from list of legal cohorts
def input_student_cohort
  puts "Is this student in the february, may, august or november cohort?"
  legal_cohorts = ["february", "may", "august", "november"]
  cohort = STDIN.gets.strip
  until legal_cohorts.include?(cohort)
    puts "You entered an invalid cohort, please try again."
    cohort = STDIN.gets.strip
  end
  cohort
end

# gets student's hobby
def input_student_hobby
  puts "Please enter this student's favourite hobby"
  hobby = STDIN.gets.strip
  hobby = "not provided" if hobby.empty?
  hobby
end

# gets student's country of birth
def input_student_country
  puts "Please enter this student's country of birth"
  country_of_birth = STDIN.gets.strip
  country_of_birth = "not provided" if country_of_birth.empty?
  country_of_birth
end

# gets student's height
def input_student_height
  puts "Please enter this student's height in cm"
  height = STDIN.gets.strip
  height = "not provided" if height.empty?
  height
end

# prints correct "now we have x number of students message"
def current_student_count_message
  puts "Now we have #{@students.count} students\n" if @students.count > 1
  puts "Now we have #{@students.count} student\n" if @students.count == 1
end

# methods for printing -----------------------------------------------------------------------------------------------

def print_header
  puts "\nThe students of Villains Academy"
  puts "-------------"
end

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

# methods for controlling the menu ------------------------------------------------------------------------------------

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
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    puts "Now exiting program."
    exit # terminates program
  else
    puts "Invalid selection, please try again"
  end
end

def show_students
  if @students.empty?
    puts "There are no students to display, please enter some first."
  else
    print_header
    print_students_list
    print_footer
  end
end

# methods for reading and writing to file ------------------------------------------------------------------------------

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:country_of_birth], student[:height], student[:hobby]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  puts "Successfully saved students to #{File.basename(file)}."
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, country_of_birth, height, hobby = line.chomp.split(",")
    add_students_to_array(name, cohort, hobby, country_of_birth, height)
  end
  @students.uniq! # this will simply remove any duplicates, e.g. if saving and loading multiple times in one session
  puts "Successfully loaded students from #{File.basename(file)}."
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  filename = "students.csv" if filename.nil? # load students.csv by default
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist, try inputting some here." # removed the exit statement, no need to end the program here
  end
end

# method to add students to array called by input_students and load_students -------------------------------------------

def add_students_to_array(name, cohort, hobby, country_of_birth, height)
  @students << {name: name.capitalize, cohort: cohort.to_sym, hobby: hobby.capitalize,
                country_of_birth: country_of_birth.capitalize, height: height.capitalize}
end



# nothing happens until the methods are called
try_load_students
interactive_menu

@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  puts "Hit return straight away to use a default set of students"

  # get the first name
  name = gets.gsub(/\n/, "") # uses gsub instead of chomp to remove newline

  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    @students << {name: name, cohort: :november}
    # set up the singular display string then make it plural if needed
    display_string = "Now we have #{@students.count} student"
    display_string.gsub!("student", "students") if @students.count > 1
    puts display_string
    # get another name from the user
    name = gets.strip # uses strip instead of chomp
  end

  # return default list if no students have been input
  @students = default_students if @students == []
end

def default_students
  [
    {name: "Dr. Hannibal Lecter", cohort: :november},
    {name: "Darth Vader", cohort: :november},
    {name: "Nurse Ratched", cohort: :november},
    {name: "Michael Corleone", cohort: :november},
    {name: "Alex DeLarge", cohort: :november},
    {name: "The Wicked Witch of the West", cohort: :november},
    {name: "Terminator", cohort: :november},
    {name: "Freddy Krueger", cohort: :november},
    {name: "The Joker", cohort: :november},
    {name: "Joffrey Baratheon", cohort: :november},
    {name: "Norman Bates", cohort: :november}
  ]
end

def print_header
  puts "The students of Villains Academy".center(80)
  puts "-------------".center(80)
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)".center(80)
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(80)
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
end

def show_students
  print_header
  print_students_list
  print_footer
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
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    @students << { name: name, cohort: cohort.to_sym }
  end
  file.close
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

interactive_menu

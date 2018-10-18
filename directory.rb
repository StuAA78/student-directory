def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  puts "Hit return straight away to use a default set of students"

  # create an empty array
  students = []

  # get the first name
  name = gets.gsub(/\n/, "") # uses gsub instead of chomp to remove newline

  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    # set up the singular display string then make it plural if needed
    display_string = "Now we have #{students.count} student"
    display_string.gsub!("student", "students") if students.count > 1
    puts display_string
    # get another name from the user
    name = gets.strip # uses strip instead of chomp
  end

  # return the array of students
  students
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

def print(students, length)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)".center(80) if student[:name].size >= length
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(80)
end

def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      students = input_students
    when "2"
      students = default_students if students == [] # use default list if nothing entered
      print_header
      print(students, 0) #length set to 0 so all students are printed
      print_footer(students)
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
end

interactive_menu

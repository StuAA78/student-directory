require "csv"

@students = []

@menu_options =
  [
    {option: 1, text: "Input the students", action: "input_students"},
    {option: 2, text: "Show the students", action: "show_students"},
    {option: 3, text: "Save the list to a file", action: "save_from_menu"},
    {option: 4, text: "Load the list from a file", action: "load_from_menu"},
    {option: 9, text: "Exit", action: "exit"}
  ]

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  puts "Hit return straight away to add a default set of students"

  # get the first name
  name = STDIN.gets.gsub(/\n/, "") # uses gsub instead of chomp to remove newline

  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    add_student(name, :november)
    # set up the singular display string then make it plural if needed
    display_string = "Now we have #{@students.count} student"
    display_string.gsub!("student", "students") if @students.count > 1
    puts display_string
    # get another name from the user
    name = STDIN.gets.strip # uses strip instead of chomp
  end

  # return default list if no students have been input
  @students = default_students if @students == []
end

def add_student(name,cohort)
  @students << {name: name, cohort: cohort}
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
    process_menu(STDIN.gets.chomp)
  end
end

def print_menu
  @menu_options.each do |opt|
    puts "#{opt[:option]}. #{opt[:text]}"
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process_menu(selection)
  option = @menu_options.find {|x| x[:option] == selection.to_i}
  option == nil ? puts("I don't know what you meant, try again") : send(option[:action])
end

def load_from_command_line
  filename = ARGV.first # first argument from the command line
  filename = "students.csv" if filename.nil? # get out of the method if it isn't given
  # quit if try_load_students returns an error, but only if a filename was specified
  exit if try_load_students(filename) == false && !ARGV.first.nil?
end

def try_load_students(filename)
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    false # return false to indicate an error
  end
end

def load_students(filename)
  CSV.foreach(filename) do |row|
    add_student(row[0], row[1].to_sym)
  end
end

def save_students(filename)
  CSV.open(filename, "w") do |csv_file|
    @students.each do |student|
      csv_file << [student[:name], student[:cohort]]
    end
  end
end

def load_from_menu
  try_load_students(get_filename)
end

def save_from_menu
  save_students(get_filename)
end

def get_filename
  puts "Enter filename (hit return for default of 'students.csv')"
  filename = gets.chomp
  filename.empty? ? "students.csv" : filename # default to students.csv if no filename given
end

load_from_command_line
interactive_menu

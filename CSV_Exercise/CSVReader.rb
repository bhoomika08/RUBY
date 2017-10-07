require 'csv'

# Class to display designation, name and id of employee
class Employee
  attr_reader :name, :emp_id, :designation

  def initialize(name, emp_id)
    @name = name
    @emp_id = emp_id
  end

  def to_s
    "#{@name} (Employee Id: #{@emp_id})"
  end
end

# Class to read the csv and write to other file.
class CSVReadWrite
  def initialize
    @employees = Hash.new { |hash, key| hash[key] = [] }
  end

  def csv_read
    csvfile = File.join(File.dirname(__FILE__), 'Employee.csv')
    CSV.foreach(csvfile, headers: true) do |row|
      @employees[row['Designation'].to_sym] << Employee.new(row['Name'], row['EmpId'])
    end
  end

  def write_to(file_name)
    File.open(file_name, 'w') do |file|
      @employees.sort.each do |designation, value|
        @employees[designation].length <= 1 ? (file.puts "#{designation}") : (file.puts "#{designation}s")
        values = value.sort_by { |emp| emp.emp_id }
        file.puts values
        file.puts
      end
    end
  end
end

puts 'Enter file name to be created'
filename = gets.chomp
csv_reader = CSVReadWrite.new
csv_reader.csv_read
if filename.empty?
  csv_reader.write_to('output.txt')
else
  csv_reader.write_to(filename)
end

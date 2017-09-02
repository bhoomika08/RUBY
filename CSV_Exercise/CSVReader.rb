require 'csv'

class Employee
  attr_reader :name, :emp_id, :designation

  def initialize(name, emp_id)
    @name = name
    @emp_id = emp_id
  end

  def to_s
    "#{ @name } (Employee Id: #{ @emp_id })"
  end 
end

class CSVReader < Employee
  def initialize
    @employees = Hash.new { |hash, key| hash[key] = [] }
  end

  def csv_read
    CSV.foreach('Employee.csv', headers: true) do |row|
      @employees[row['Designation'].to_sym] << Employee.new(row['Name'], row['EmpId'])
    end 
  end
  
  def write_to(file_name)     
    File.open(file_name, 'w') do |file|
      @employees.each do |designation, value|   
        @employees[designation].length <= 1 ? (file.puts "#{designation}") : (file.puts "#{designation}s")
        file.puts value
        file.puts
      end
    end
  end
end

puts 'Enter file name to be created'
filename = gets.chomp
csv_reader = CSVReader.new
csv_reader.csv_read
csv_reader.write_to(filename)
 
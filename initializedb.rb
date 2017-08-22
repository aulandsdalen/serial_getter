require 'sequel'

DB = Sequel.connect('sqlite://computers.db')

DB.create_table :computers do 
	primary_key :id
	String :serial
	DateTime :added_at
end
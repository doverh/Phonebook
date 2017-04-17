require 'sinatra'
require 'pg'
load './local_env.rb' if File.exist?('./local_env.rb')

db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['db_name'],
	user: ENV['user'],
	password: ENV['password']
}
db = PG::Connection.new(db_params)

get "/"  do
phonebook = db.exec("SELECT first_name, last_name, address, city,state,zip, phone, email FROM phonebook");	
erb :index, :locals=>{:phonebook => phonebook}
end

post "/phonebook" do
	first_name = [:first_name]
	last_name = [:last_name]
	address = [:address]
	city = [:city]
	state = [:state]
	zip = [:zip]
	phone = [:phone]
	email = [:email]

	db.exec("INSERT INTO phonebook(first_name, last_name, address, city,state,zip, phone,email) values('#{first_name}', '#{last_name}','#{address}','#{city}','#{state}','#{zip}','#{phone}','#{email}')");

end
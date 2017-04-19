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
erb :index
end

post "/confirmation" do
	first_name = params['first_name']
	last_name = params['last_name']
	address = params['address']
	city = params['city']
	state = params['state']
	zip = params['zip']
	phone = params['phone']
	email = params['email']

	db.exec("INSERT INTO phonebook(first_name, last_name, address, city,state,zip, phone,email) values('#{first_name}', '#{last_name}','#{address}','#{city}','#{state}','#{zip}','#{phone}','#{email}')");
	erb :confirm
end

get "/show_all"  do
phonebook = db.exec("SELECT first_name, last_name, address, city,state,zip, phone, email FROM phonebook");	
erb :show_all, :locals=>{:phonebook => phonebook}
end
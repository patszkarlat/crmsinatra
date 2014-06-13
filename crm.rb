require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite")

class Contact
	include DataMapper::Resource

	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :note, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

# @@rolodex = Rolodex.new
# @@rolodex.add_contact(Contact.new("Pat", "Szkarlat", "punkgeek@mac.com", "Creative, Apple Inc."))
# @@rolodex.add_contact(Contact.new("Will", "Richman", "will@bitmakerlabs.com", "Co-founder and Nice Guy"))
# @@rolodex.add_contact(Contact.new("Julie", "Hache", "julie@bitmakerlabs.com", "Lead Instructor of Awesomeness"))
# @@rolodex.add_contact(Contact.new("Erik", "Dohnberg", "erik@bitmakerlabs.com", "Admissions Officer and Commiserator of Apple Employees"))


get '/' do 
	@crm_app_name = "My CRM"
	erb :index
end

get '/contacts' do
	erb :contacts
end

get '/contacts/new' do
	erb :new_contact
end

post '/contacts' do
	new_contact = Contact.new(params[:first_name],params[:last_name], params[:email], params[:note])
	@@rolodex.add_contact(new_contact)
	redirect to('/contacts')
end


put "/contacts/:id" do
	@contact = @@rolodex.find_contact(params[:id].to_i)
	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]
		@contact.note = params[:note]

		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end

get '/contacts/:id' do
	# "#{params[:id]}"
	@contact = @@rolodex.find_contact(params[:id].to_i)

	# puts "***** ATTENTION ATTENTION"
	# puts "@contact is currently: #{@contact}"

	if @contact
		erb :show_contact
	else
		raise Sinatra::NotFound

		# "@contact was nil. Here are the contents of @@rolodex.contacts: #{ @@rolodex.contacts.each {|c| c.to_s} }"
	end
end

get '/contacts/:id/edit' do
	@contact = @@rolodex.find_contact(params[:id].to_i)
	if @contact 
		erb :edit_contact
		else
		raise Sinatra::NotFound	# this is the only space where I can set instance variables for
	# edit_contact


	# erb :edit_contact
	end
end


get "/contacts/1000" do
	@contact = @@rolodex.find_contact(1000)
	erb :show_contact
end

delete "/contacts/:id" do
	@contact = @@rolodex.find_contact(params[:id].to_i)

	if @contact
		@@rolodex.remove_contact(@contact)
		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end

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
	@contacts = Contact.all
	erb :contacts
end

get '/contacts/new' do
	erb :new_contact
end

post '/contacts' do
	contact = Contact.create(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:note => params[:note]
		)
	redirect to('/contacts')
	# new_contact = Contact.new(params[:first_name],params[:last_name], params[:email], params[:note])
	# @@rolodex.add_contact(new_contact)
	# redirect to('/contacts')
end


put "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)
	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]
		@contact.note = params[:note]
		@contact.save
		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end

delete "/contacts/:id" do
	Contact.get(params[:id].to_i).destroy	
	redirect to("/contacts")
end

	# @contact = @@rolodex.find_contact(params[:id].to_i)
	# if @contact
	# 	@contact.first_name = params[:first_name]
	# 	@contact.last_name = params[:last_name]
	# 	@contact.email = params[:email]
	# 	@contact.note = params[:note]

	# 	redirect to("/contacts")
	# else
	# 	raise Sinatra::NotFound
	# end


get '/contacts/:id' do
	# "#{params[:id]}"
	@contact = Contact.get(params[:id].to_i)

	# puts "***** ATTENTION ATTENTION"
	# puts "@contact is currently: #{@contact}"

	if @contact
		erb :show_contact
	else
		raise Sinatra::NotFound

		# "@contact was nil. Here are the contents of @@rolodex.contacts: #{ @@rolodex.contacts.each {|c| c.to_s} }"
	end
end

require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

@@rolodex = Rolodex.new 

get '/' do 
	@crm_app_name = "My CRM"
	erb :index
end

get '/contacts' do

	@@rolodex.contacts << Contact.new("Pat", "Szkarlat", "punkgeek@mac.com", "Creative, Apple Inc.")
	@@rolodex.contacts << Contact.new("Will", "Richman", "will@bitmakerlabs.com", "Co-founder and Nice Guy")
	@@rolodex.contacts << Contact.new("Julie", "Hache", "julie@bitmakerlabs.com", "Lead Instructor of Awesomeness")
	@@rolodex.contacts << Contact.new("Erik", "Dohnberg", "erik@bitmakerlabs.com", "Admissions Officer and Commiserator of Apple Employees")

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

get '/contacts/:id' do
	@contact = @@rolodex.find(params[:id].to_i)
	erb :show_contact
end

get 'contacts/:id/edit' do
end

get "contacts/1000" do
	@contact = @@rolodex.find(1000)
	erb :show_contact
end

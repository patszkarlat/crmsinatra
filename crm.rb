require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

@@rolodex = Rolodex.new 

get '/' do 
	@crm_app_name = "My CRM"
	erb :index
end

get 'contacts' do

	@@rolodex.contacts << Contact.new("Pat", "Szkarlat", "punkgeek@mac.com", "Creative, Apple Inc.")
	@@rolodex.contacts << Contact.new("Will", "Richman", "will@bitmakerlabs.com", "Co-founder and Nice Guy")
	@@rolodex.contacts << Contact.new("Julie", "Hache", "julie@bitmakerlabs.com", "Lead Instructor of Awesomeness")
	@@rolodex.contacts << Contact.new("Erik", "Dohnberg", "erik@bitmakerlabs.com", "Admissions Officer and Commiserator of Apple Employees")

	erb :contacts
end

get 'contacts/:id' do
end

get '/contacts/new' do
end

get 'contacts/:id/edit' do
end

get '/contacts/new' do
	erb :new_contact
end

post '/contacts' do
	puts params
end

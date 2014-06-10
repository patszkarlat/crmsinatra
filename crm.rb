require_relative 'contact'
require 'sinatra'

get '/' do 
	@crm_app_name = "My CRM"
	erb :index
end

get 'contacts/:id' do
	@contacts = []
	@contacts << Contact.new("Pat", "Szkarlat", "punkgeek@mac.com", "Creative, Apple Inc.")
	@contacts << Contact.new("Will", "Richman", "will@bitmakerlabs.com", "Co-founder and Nice Guy")
	@contacts << Contact.new("Julie", "Hache", "julie@bitmakerlabs.com", "Lead Instructor of Awesomeness")
	@contacts << Contact.new("Erik", "Dohnberg", "erik@bitmakerlabs.com", "Admissions Officer and Commiserator of Apple Employees")
end

get '/contacts/new' do
end

get 'contacts/:id/edit' do
end
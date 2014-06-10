class Rolodex
	attr_accessor :contacts
	
	def initialize
		@contacts_id = 1000
		@contacts = Array.new
	end

	def contacts
		@contacts
	end

	def add_contact(contact)
		contact.id = @contacts_id
		@contacts << contact
		@contacts_id += 1

		return contact.id
	end
end
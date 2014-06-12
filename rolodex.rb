class Rolodex
	attr_accessor :contacts
	
	def initialize
		@contacts_id = 1000								#contacts_id is just an identifier
		@contacts = Array.new
	end

	def contacts
		@contacts
	end

	def find_contact(id)
		contact = nil
		# contact = @contacts[] 							#.first would also return the first item in an array. number in [] is the position starting at 0.
		@contacts.each do |c|									#c means "card" = contact
			if c.id == id 
				contact = c
			end										#.each interates over array instead of using []; runs code between do and end for the amount of elements in array.
		end
		return contact 
	end

	def find_by_email(email)
		contact = nil
		@contacts.each do |c|
			if c.email == email 
				contact = c
			end
		end
		return contact
	end

#to find correct card, we could go thru one at a time. calling [] (the same as .index) on @contacts will expose contact at that position.
# contact = @contacts[0] will bring up the first. contact = @contacts[4]


	def add_contact(contact)
		contact.id = @contacts_id
		@contacts << contact
		@contacts_id += 1

		return contact.id
	end
end
# -*- encoding : utf-8 -*-

require 'digest/sha1'

class EntryFile
	include ActiveModel::Validations

	attr_accessor :file, :entries, :image_token

	def initialize(params={})
		if params && params[:file]
			@file = params[:file].read.split(/\n/) 
			@file.shift
			@image_token = Digest::SHA1.hexdigest Time.now.to_s
		end

		@entries = []
	end

	def valid?
		unless self.file && self.file.present?
			errors.add(:file, 'inválido')
			return false
		end
		
		true
	end

	def parse_and_create(user)
		self.file.each do |line|
			purchaser_name, description, price, 
			count, address, name = line.split(/\t/)
			entry = Entry.create!(purchaser_name: purchaser_name,
							item_description: description,
							item_price: price,
							purchase_count: count,
							merchant_address: address,
							merchant_name: name,
							image_token: self.image_token)
			entry.update_attribute(:user, user)			
			self.entries << entry
		end
	end
end
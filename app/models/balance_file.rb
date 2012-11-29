class BalanceFile
	include ActiveModel::Validations

	attr_accessor :file, :entries

	def initialize(params={})
		if params && params[:file]
			@file = params[:file].read.split(/\n/) 
			@file.shift
		end

		@entries = []
	end

	def valid?
		self.file.each do |line|
			purchaser_name, description, price, 
			count, address, name = line.split(/\t/)
			self.entries << Balance.create!(purchaser_name: purchaser_name,
												item_description: description,
												item_price: price,
												purchase_count: count,
												merchant_address: address,
												merchant_name: name)
		end
	end
end
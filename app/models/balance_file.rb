class BalanceFile
	include ActiveModel::Validations

	attr_accessor :file

	def initialize(params={})
		@file = params[:file].tempfile if params && params[:file]
	end
end
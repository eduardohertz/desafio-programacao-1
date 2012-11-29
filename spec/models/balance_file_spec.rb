# -*- encoding : utf-8 -*-
require 'spec_helper'

describe BalanceFile do
	context '#valid?' do
		it 'is valid' do
			balance_file = BalanceFile.new(file: File.open("#{Rails.root}/spec/fixtures/data.tab"))
			balance_file.valid?.should be_true
		end

		it 'is not valid' do
			balance_file = BalanceFile.new(file: nil)
			balance_file.valid?.should be_false
			balance_file.errors[:file].should == ['inválido']
		end
	end

	it '#parse should separate entries' do
		balance_file = BalanceFile.new(file: File.open("#{Rails.root}/spec/fixtures/data.tab"))
		balance_file.parse
		balance_file.entries.size.should == 4
		Balance.all.size.should == 4
	end
end
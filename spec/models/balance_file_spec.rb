require 'spec_helper'

describe BalanceFile do
	it '#valid? should separate entries' do
		balance_file = BalanceFile.new(file: File.open("#{Rails.root}/spec/fixtures/data.tab"))
		balance_file.valid?
		balance_file.entries.size.should == 4
		(0..3).each { |i| balance_file.entries[i].should be_a(Balance) }
	end
end
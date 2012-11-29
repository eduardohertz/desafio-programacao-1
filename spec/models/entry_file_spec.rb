# -*- encoding : utf-8 -*-
require 'spec_helper'

describe EntryFile do
	context '#valid?' do
		it 'is valid' do
			entry_file = EntryFile.new(file: File.open("#{Rails.root}/spec/fixtures/data.tab"))
			entry_file.valid?.should be_true
		end

		it 'is not valid' do
			entry_file = EntryFile.new(file: nil)
			entry_file.valid?.should be_false
			entry_file.errors[:file].should == ['inválido']
		end
	end

	it '#parse should separate entries' do
		entry_file = EntryFile.new(file: File.open("#{Rails.root}/spec/fixtures/data.tab"))
		entry_file.parse_and_create
		entry_file.entries.size.should == 4
		Entry.all.size.should == 4
	end
end
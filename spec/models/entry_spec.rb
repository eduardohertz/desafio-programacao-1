require 'spec_helper'

describe Entry do
  context 'calculate revenue' do
  	before do
	  	FactoryGirl.create :entry, item_price: 20.0, purchase_count: 2
	  	FactoryGirl.create :entry, item_price: 30.0, purchase_count: 4
	  	FactoryGirl.create :entry, item_price: 90.0, purchase_count: 1
	  end

	  it 'when token is not provided' do
  		Entry.revenue.should == 250.0

	  	FactoryGirl.create :entry, item_price: 100.0, purchase_count: 5
	  	Entry.revenue.should == 750.0
	  end

	  it 'when token is provided' do
	  	FactoryGirl.create :entry, item_price: 100.0, 
	  															purchase_count: 5, 
	  															image_token: 'MY_TOKEN'
	  	FactoryGirl.create :entry, item_price: 100.0,
	  															purchase_count: 5,
	  															image_token: 'MY_TOKEN'

  		Entry.revenue('MY_TOKEN').should == 1000.0
	  end
  end
end

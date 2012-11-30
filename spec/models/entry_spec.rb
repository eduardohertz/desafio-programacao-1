require 'spec_helper'

describe Entry do
  context 'calculate revenue' do
  	before do
	  	@user = FactoryGirl.create :user
	  	FactoryGirl.create :entry, item_price: 20.0, purchase_count: 2, user: @user
	  	FactoryGirl.create :entry, item_price: 30.0, purchase_count: 4, user: @user
	  	FactoryGirl.create :entry, item_price: 90.0, purchase_count: 1, user: @user
	  	FactoryGirl.create :entry, item_price: 90.0, purchase_count: 1
	  end

	  it 'when token is not provided' do
  		Entry.revenue(user_id: @user.id).should == 250.0

	  	FactoryGirl.create :entry, item_price: 100.0, purchase_count: 5, user: @user
	  	Entry.revenue(user_id: @user.id).should == 750.0
	  end

	  it 'when token is provided' do
	  	FactoryGirl.create :entry, item_price: 100.0, 
	  															purchase_count: 5, 
	  															image_token: 'MY_TOKEN',
	  															user: @user
	  	FactoryGirl.create :entry, item_price: 100.0,
	  															purchase_count: 5,
	  															image_token: 'MY_TOKEN',
	  															user: @user
			FactoryGirl.create :entry, item_price: 100.0,
	  															purchase_count: 5,
	  															image_token: 'MY_TOKEN'

  		Entry.revenue(token: 'MY_TOKEN', user_id: @user.id).should == 1000.0
	  end
  end

  context 'relations' do
  	it { should belong_to(:user) }
  end
end

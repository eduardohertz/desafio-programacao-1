# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :entry do
  	purchaser_name 'João Silva'
  	item_description 'R$10 off R$20 of food'
  	item_price 10.0
  	purchase_count 2
  	merchant_address '987 Fake St'
  	merchant_name "Bob's Pizza"
  end
end

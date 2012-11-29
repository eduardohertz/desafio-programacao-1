# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'Balance' do
	context 'when there any entry' do
		it 'show entries' do
			entry_1 = FactoryGirl.create :entry, item_price: 10, purchase_count: 3
			entry_2 = FactoryGirl.create :entry, item_price: 40, purchase_count: 1
			visit root_path
			click_link 'Receita bruta total'
			within('table tr[2]') do
				within('td[1]') { page.should have_content entry_1.purchaser_name }
				within('td[2]') { page.should have_content entry_1.item_description }
				within('td[3]') { page.should have_content "R$ 10,00" }
				within('td[4]') { page.should have_content entry_1.purchase_count }
				within('td[5]') { page.should have_content entry_1.merchant_address }
				within('td[6]') { page.should have_content entry_1.merchant_name }
			end

			within('table tr[3]') do
				within('td[1]') { page.should have_content entry_2.purchaser_name }
				within('td[2]') { page.should have_content entry_2.item_description }
				within('td[3]') { page.should have_content "R$ 40,00" }
				within('td[4]') { page.should have_content entry_2.purchase_count }
				within('td[5]') { page.should have_content entry_2.merchant_address }
				within('td[6]') { page.should have_content entry_2.merchant_name }
			end
		end

		it 'show balance' do
			FactoryGirl.create :entry, item_price: 10, purchase_count: 3
			visit root_path
			click_link 'Receita bruta total'
			page.should have_content 'Receita bruta total: R$ 30,00'
		end
	end
end
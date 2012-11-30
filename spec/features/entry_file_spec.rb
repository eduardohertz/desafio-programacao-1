# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'Send balance file' do
	background do
		@user = FactoryGirl.create :user
		login(@user.email, '123456')
	end

	context 'when receive a valid file' do
		it 'receive a file' do
			visit root_path
			click_link 'Enviar arquivo'
			attach_file 'Arquivo', "#{Rails.root}/spec/fixtures/data.tab"
			click_button 'Enviar'
			page.should have_content 'Arquivo enviado com sucesso.'
		end

		it 'create entries to current_user' do
			visit root_path
			click_link 'Enviar arquivo'
			attach_file 'Arquivo', "#{Rails.root}/spec/fixtures/data.tab"
			click_button 'Enviar'
			entries = Entry.where('image_token = ?', Entry.last.image_token)
			entries.each { |entry| entry.user.should == @user }
		end

		it 'show only entries of the user' do
			FactoryGirl.create :entry
			visit root_path
			click_link 'Enviar arquivo'
			attach_file 'Arquivo', "#{Rails.root}/spec/fixtures/data.tab"
			click_button 'Enviar'
			page.should have_content 'Receita bruta total: R$ 95,00'
			entries = Entry.where('image_token = ?', Entry.last.image_token)
			entries.each_with_index do |entry, index|
				within("table tr[#{index+2}]") do
					page.should have_content entry.purchaser_name
					page.should have_content entry.item_description
					page.should have_content entry.purchase_count
				end
			end
			lambda { find('table tr[7]') }.should raise_error Capybara::ElementNotFound
		end

		it 'create an entry for each line' do
			Entry.all.size.should == 0
			visit root_path
			click_link 'Enviar arquivo'
			attach_file 'Arquivo', "#{Rails.root}/spec/fixtures/data.tab"
			click_button 'Enviar'
			page.should have_content 'Arquivo enviado com sucesso.'
			Entry.all.size.should == 4
		end
	end

	context 'when receive an invalid file' do
		it 'show error message' do
			visit new_entry_path
			attach_file 'Arquivo', "#{Rails.root}/spec/fixtures/empty.tab"
			click_button 'Enviar'
			page.should have_content 'inválido'
		end
	end
end
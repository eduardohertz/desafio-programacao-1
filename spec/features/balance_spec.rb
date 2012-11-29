# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'Send balance file' do
	context 'when receive a valid file' do
		it 'redirects to balances_path' do
			visit root_path
			click_link 'Enviar arquivo'
			attach_file 'Arquivo', "#{Rails.root}/spec/fixtures/data.tab"
			click_button 'Enviar'
			page.should have_content 'Arquivo enviado com sucesso.'
			current_path.should == balances_path
		end

		it 'create an entry for each line' do
			Balance.all.size.should == 0
			visit root_path
			click_link 'Enviar arquivo'
			attach_file 'Arquivo', "#{Rails.root}/spec/fixtures/data.tab"
			click_button 'Enviar'
			page.should have_content 'Arquivo enviado com sucesso.'
			Balance.all.size.should == 4
		end
	end

	context 'when receive an invalid file' do
		it 'show error message' do
			visit new_balance_path
			attach_file 'Arquivo', "#{Rails.root}/spec/fixtures/empty.tab"
			click_button 'Enviar'
			page.should have_content 'inválido'
		end
	end
end
# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'manage entries' do
	background do
		@user = FactoryGirl.create :user
		login(@user.email, '123456')
	end

	context 'edit an entry' do
		background do
			FactoryGirl.create :entry, user: @user
			visit entries_path
			click_link 'Editar'
		end

		it 'successfully' do
			fill_in 'Nome do comprador', with: 'Seu madruga'
			fill_in 'Descrição', with: 'Any description'
			fill_in 'Preço', with: '25.0'
			fill_in 'Quantidade', with: '3'
			fill_in 'Endereço do comerciante', with: 'Avenida Presidente Vargas'
			fill_in 'Nome do comerciante', with: ''
			click_button 'Salvar'
			page.should have_content 'Entrada atualizada com sucesso.'
			current_path.should == entries_path
		end

		context 'with errors' do
			it 'item_price blank' do
				fill_in 'Preço'	, with: ''
				click_button 'Salvar'
				page.should have_content 'Preçonão pode ficar em branco'
			end

			it 'purchase_count blank' do
				fill_in 'Quantidade'	, with: ''
				click_button 'Salvar'
				page.should have_content 'Quantidadenão pode ficar em branco'
			end
		end
	end
end
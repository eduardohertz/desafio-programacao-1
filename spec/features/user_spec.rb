# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'User rules' do
	context 'when not logged in' do
		it 'do not show links in menu' do
			visit root_path
			page.should_not have_content 'Enviar arquivo'
			page.should_not have_content 'Receita bruta total'
			page.should_not have_content 'Sair'
		end
	end
end

feature 'Login' do
	background do
		@user = FactoryGirl.create :user
	end

	it 'through conventional way' do
		visit login_path
		fill_in 'E-mail', with: @user.email
		fill_in 'Senha', with: '123456'
		click_button 'Entrar'
		page.should have_content 'Autenticado com sucesso.'
		current_path.should == new_entry_path
	end
end

feature 'Logout' do
	background do
		@user = FactoryGirl.create :user
		login(@user.email, '123456')
	end

	it 'through link in menu' do
		click_link 'Sair'
		page.should have_content 'Você precisa registrar-se ou fazer login para continuar.'
	end
end
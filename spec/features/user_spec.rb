require 'spec_helper'

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
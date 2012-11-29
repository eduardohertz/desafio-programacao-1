require 'spec_helper'

feature 'Send balance file' do
	context 'when receive a valid file' do
		it 'redirects to balances_path' do
			visit root_path
			click_link 'Enviar arquivo'
			attach_file 'Arquivo', "#{Rails.root}/spec/data/data.tab"
			click_button 'Enviar'
			page.should have_content 'Arquivo enviado com sucesso.'
			current_path.should == balances_path
		end
	end
end
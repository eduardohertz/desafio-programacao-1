require 'spec_helper'

describe User do
  context 'relations' do
  	it { should have_many(:entries) }
  end
end

require 'rails_helper'

describe 'interviews/new' do
  subject { rendered }

  it 'has category options' do
    assign(:company, FactoryGirl.create(:company))
    assign(:interview, Interview.new)
    render
    is_expected.to have_selector "option[value='カジュアル面談']"
    is_expected.to have_selector "option[value='懇親会']"
    is_expected.to have_selector "option[value='面接']"
  end
end

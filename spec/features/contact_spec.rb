require 'rails_helper'

RSpec.feature 'Contact' do
  let(:name) { 'John Smith' }
  let(:email) { 'john@example.com' }
  let(:text) { 'Hello world' }

  before do
    visit '/contact'
    fill_in 'contact[name]', with: name
    fill_in 'contact[email]', with: email
    fill_in 'contact[text]', with: text
    click_button '送信'
  end

  specify '送信後にページ遷移すること' do
    expect(page).to have_content 'お問い合わせ頂きありがとうございます'
  end

  specify 'Contactが保存されていること' do
    expect(Contact.last).not_to be_nil
    expect(Contact.last.name).to eq name
    expect(Contact.last.email).to eq email
    expect(Contact.last.text).to eq text
  end
end

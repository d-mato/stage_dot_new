require 'rails_helper'

describe Company do
  let(:user) { User.create(email: "#{SecureRandom.hex}@example.com") }
  let(:company) { Company.new }

  it 'is invalid when name is blank' do
    company.attributes = { name: '', user: user }
    expect(company).not_to be_valid
    expect(company.errors[:name]).to be_present
  end

  it 'is valid when name and user_id are present' do
    company.attributes = { name: 'John', user: user }
    expect(company).to be_valid
    expect(company.errors.size).to eq 0
  end
end

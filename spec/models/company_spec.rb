require 'rails_helper'

describe Company do
  it 'is invalid when name is blank' do
    company = Company.new(name: '')
    expect(company).not_to be_valid
    expect(company.errors[:name]).to be_present
  end
end

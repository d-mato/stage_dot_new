require 'rails_helper'

describe Resume do
  it 'is invalid with duplicated user_id' do
    user = FactoryGirl.create(:user)
    resume0 = Resume.create!(user_id: user.id)
    resume1 = Resume.new(user_id: user.id)

    expect(resume1).not_to be_valid
    expect(resume1.errors[:user_id]).to be_present
  end
end

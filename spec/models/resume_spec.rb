require 'rails_helper'

describe Resume do
  it 'is invalid with duplicated user_id' do
    user = FactoryGirl.create(:user)
    resume1 = Resume.new(user_id: user.id)

    expect(resume1).not_to be_valid
    expect(resume1.errors[:user_id]).to be_present
  end

  it 'is created after user is created' do
    user = FactoryGirl.create(:user)
    expect(user.resume).to be_present
  end
end

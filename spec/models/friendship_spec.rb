require 'rails_helper'

describe Friendship do
  let(:alice) { FactoryGirl.create :user }
  let(:bob) { FactoryGirl.create :user }

  describe 'Validations' do
    let(:friendship) { Friendship.new }
    it 'user_idとfriend_idが共に空でないならvalid' do
      expect(friendship).not_to be_valid

      friendship.user = alice
      expect(friendship).not_to be_valid

      friendship.friend = bob
      expect(friendship).to be_valid
    end
  end
end

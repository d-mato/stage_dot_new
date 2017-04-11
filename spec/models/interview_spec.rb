require 'rails_helper'

describe Interview do
  it 'is invalid when start_at is blank' do
    interview = Interview.new(start_at: nil)
    expect(interview).not_to be_valid
    expect(interview.errors[:start_at]).to be_present
  end

  describe '#copy_location' do
    it '同じ企業の直近の面談の住所をコピー' do
      interview1 = FactoryGirl.create :interview, location: Gimei.address.to_s
      interview2 = Interview.new(company_id: interview1.company.id)
      interview2.copy_location
      expect(interview2.location).to eq interview1.location
    end

    it 'company_idが空でもエラーを起こさないこと' do
      interview = Interview.new
      expect { interview.copy_location }.not_to raise_error
    end

    it '直近の面談が無くてもエラーを起こさないこと' do
      interview = Interview.new(company_id: FactoryGirl.create(:company).id)
      expect { interview.copy_location }.not_to raise_error
    end
  end
end

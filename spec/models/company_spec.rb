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

  describe 'Methods' do
    let(:company) { Company.create(user_id: user.id, name: 'Gooogle') }
    let(:next_time) { 4.hours.since } # 4時間後

    before do
      company.interviews.create(start_at: 1.hour.ago) # 1時間前
      company.interviews.create(start_at: 2.days.since) # 2日後
      company.interviews.create(start_at: 3.minutes.ago) # 3分前
      company.interviews.create(start_at: next_time)
      company.interviews.create(start_at: 5.minutes.ago) # 5分前
    end

    specify '#visit_count is correct' do
      expect(company.interviews.count).to eq 5
      expect(company.visit_count).to eq 3
    end

    specify '#next_interview_start_at is correct' do
      expect(company.next_interview_start_at.to_s).to eq next_time.to_s
      company.interviews.destroy_all
      expect(company.next_interview_start_at).to be_nil
    end
  end

  describe 'Scopes' do
    let(:companies) { FactoryGirl.create_list(:company, 10) }

    describe :archived do
      subject { Company.archived }

      it { is_expected.to eq [] }

      it do
        companies[0].update(archived_at: Time.zone.now)
        companies[1].update(archived_at: Time.zone.now)
        companies[2].update(archived_at: Time.zone.now)
        is_expected.to eq [companies[0], companies[1], companies[2]]
      end
    end
  end
end

require 'rails_helper'

describe 'Interviews' do
  let(:user) { FactoryGirl.create :user }
  let(:company) { FactoryGirl.create(:company, user_id: user.id) }
  let(:someone) { FactoryGirl.create :user }
  let(:someones_company) { FactoryGirl.create(:company, user_id: someone.id) }

  describe 'GET /interviews.json' do
    let!(:interviews) { FactoryGirl.create_list(:interview, 10, company_id: company.id) }

    before do
      sign_in user
      get interviews_path format: :json
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns valid as json' do
      expect { JSON.parse(response.body) }.not_to raise_error
    end

    describe 'json' do
      let!(:json) { JSON.parse(response.body) }
      let!(:sorted) { user.interviews.order(start_at: :desc) }

      it 'jsonに含まれるinterviewの数とuserのinterviewの数が等しいこと' do
        expect(json.size).to eq user.interviews.size
      end

      it 'jsonがstart_at順に並び替えられていること' do
        expect(json.first['id']).to eq sorted.first.id
        expect(json.last['id']).to eq sorted.last.id
      end

      it 'jsonに企業名が含まれていること' do
        expect(json.first['company']).to eq sorted.first.company.name
      end
    end
  end
end

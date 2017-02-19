require 'rails_helper'

describe InterviewsController do
  let(:user) { FactoryGirl.create :user }
  let(:company) { FactoryGirl.create(:company, user_id: user.id) }
  let(:someone) { FactoryGirl.create :user }
  let(:someones_company) { FactoryGirl.create(:company, user_id: someone.id) }

  before { sign_in user }

  describe 'DELETE #destroy' do
    it 'deletes a interview' do
      interview = FactoryGirl.create :interview, company_id: company.id
      delete :destroy, params: { id: interview.id }
      expect(Interview.find_by(id: interview.id)).to be_nil
    end

    it 'CANNOT delete someone\'s interview' do
      interview = FactoryGirl.create :interview, company_id: someones_company.id
      req = proc { delete :destroy, params: { id: interview.id } }
      expect(req).to raise_exception(ActiveRecord::RecordNotFound)
      expect(Interview.find_by(id: interview.id)).not_to be_nil
    end
  end
end

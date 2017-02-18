require 'rails_helper'

describe CompaniesController, type: :controller do
  let(:user) { FactoryGirl.create :user }
  let(:companies) { FactoryGirl.create_list(:company, 10, user_id: user.id) }
  let(:archived_companies) { FactoryGirl.create_list(:company, 10, archived_at: Time.zone.now, user_id: user.id) }
  let(:someone) { FactoryGirl.create :user }
  let(:someones_companies) { FactoryGirl.create_list(:company, 10, user_id: someone.id) }

  before { sign_in user }

  describe 'GET #index' do
    before { get :index }

    it('returns 200') { expect(response.status).to eq 200 }

    it '@companiesにcurrent_userに属するアーカイブされていないCompanyを割り当てること' do
      expect(assigns(:companies)).to eq companies
    end
  end

  describe 'GET #show' do
    context '自分のCompany' do
      let(:company) { companies.sample }
      before { get :show, params: { id: company.id } }

      it('returns 200') { expect(response.status).to eq 200 }

      it '@companyに要求されたCompanyを割り当てること' do
        expect(assigns(:company)).to eq company
      end
    end

    it '他人のCompanyにアクセスしたらActiveRecord::RecordNotFoundを発生させること' do
      req = proc { get :show, params: { id: someones_companies.sample.id } }
      expect(req).to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'GET #new' do
    before { get :new }

    it('returns 200') { expect(response.status).to eq 200 }

    it '@companyに新しいCompanyを割り当てること' do
      expect(assigns(:company)).to be_a_new(Company)
    end
  end

  describe 'GET #edit' do
    context '自分のCompany' do
      let(:company) { companies.sample }
      before { get :edit, params: { id: company.id } }

      it('returns 200') { expect(response.status).to eq 200 }

      it '@companyに要求されたCompanyを割り当てること' do
        expect(assigns(:company)).to eq company
      end
    end

    it '他人のCompanyにアクセスしたらActiveRecord::RecordNotFoundを発生させること' do
      req = proc { get :edit, params: { id: someones_companies.sample.id } }
      expect(req).to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'POST #create' do
    let(:company_params) { FactoryGirl.attributes_for :company }
    let(:req) { proc { post :create, params: { company: company_params } } }

    it '新しいCompanyが登録されること' do
      expect(req).to change(Company, :count).by 1
    end

    it 'returns 302' do
      req.call
      expect(response.status).to eq 302
    end

    it 'redirects to #show' do
      req.call
      expect(response).to redirect_to company_path(Company.last)
    end
  end

  describe 'PATCH #update' do
    let(:company) { FactoryGirl.create :company, user_id: user.id }
    let(:company_params) { FactoryGirl.attributes_for :company, new_params }
    let(:new_params) do
      {
        name: Faker::Company.name,
        via: Faker::App.name,
        employee_count: rand(100),
        engineer_count: rand(100),
        good: Faker::Lorem.paragraph,
        bad: Faker::Lorem.paragraph,
        motivation: Faker::Lorem.paragraph
      }
    end

    before { patch :update, params: { id: company.id, company: company_params } }

    it 'returns 302' do
      expect(response.status).to eq 302
    end

    it '新しい値に更新されていること' do
      company.reload
      expect(company.name).to eq new_params[:name]
      expect(company.via).to eq new_params[:via]
      expect(company.employee_count).to eq new_params[:employee_count]
      expect(company.engineer_count).to eq new_params[:engineer_count]
      expect(company.good).to eq new_params[:good]
      expect(company.bad).to eq new_params[:bad]
      expect(company.motivation).to eq new_params[:motivation]
    end
  end

  describe 'GET #archives' do
    before { get :archives }

    it('returns 200') { expect(response.status).to eq 200 }

    it '@companiesにcurrent_userに属するアーカイブされているCompanyを割り当てること' do
      expect(assigns(:companies)).to eq archived_companies
    end
  end

  describe 'POST/DELETE #archive' do
    describe 'POST' do
      it 'makes company archived' do
        company = FactoryGirl.create :company, user_id: user.id, archived_at: nil
        post :archive, params: { company_id: company.id }
        expect(company.reload.archived_at?).to be_truthy
      end
    end

    describe 'DELETE' do
      it 'makes company not archived' do
        company = FactoryGirl.create :company, user_id: user.id, archived_at: Time.zone.now
        delete :archive, params: { company_id: company.id }
        expect(company.reload.archived_at?).to be_falsey
      end
    end
  end
end

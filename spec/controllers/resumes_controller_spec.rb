require 'rails_helper'

describe ResumesController do
  let(:user) { FactoryGirl.create :user }
  before { sign_in user }

  describe "GET #show" do
    it "assigns the requested resume as @resume" do
      get :show
      expect(assigns(:resume)).to eq user.resume
    end
  end

  describe "GET #edit" do
    it "assigns the requested resume as @resume" do
      get :edit
      expect(assigns(:resume)).to eq user.resume
    end
  end

  describe "PUT #update" do
    let(:new_attributes) { { body: Faker::Lorem.paragraph } }

    it "updates the requested resume" do
      put :update, params: { resume: new_attributes }
      expect(user.resume.body).to eq new_attributes[:body]
    end

    it "redirects to the resume" do
      put :update, params: { resume: new_attributes }
      expect(response).to redirect_to resume_path
    end
  end
end

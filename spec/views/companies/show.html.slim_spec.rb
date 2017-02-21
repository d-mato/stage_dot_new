require 'rails_helper'

describe 'companies/show' do
  let!(:company) { FactoryGirl.create :company }

  before { assign(:company, company) }

  context '完了した面談がある' do
    before do
      FactoryGirl.create :interview, company_id: company.id, start_at: 1.hour.ago
    end

    specify 'Companyの情報が未記入の場合、入力を促すメッセージを表示' do
      render
      expect(rendered).to match '面談はどうでしたか？忘れないうちに企業への印象を整理しておきましょう。'
    end

    specify 'Companyの情報が記入されている場合、入力を促すメッセージは非表示' do
      company.update!(good: Faker::Lorem.paragraph)
      assign(:company, company)
      render
      expect(rendered).not_to match '面談はどうでしたか？忘れないうちに企業への印象を整理しておきましょう。'
    end
  end
end

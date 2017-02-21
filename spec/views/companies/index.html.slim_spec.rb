require 'rails_helper'

describe 'companies/index' do
  subject { rendered }

  it 'Companyが1つも無い時、テーブルの代わりにメッセージを表示' do
    assign(:companies, [])
    render
    is_expected.to match '企業がありません。'
    is_expected.not_to have_selector 'table.companies'
  end

  it 'Companyがある時、テーブルを表示' do
    assign(:companies, FactoryGirl.create_list(:company, 10))
    render
    is_expected.to have_selector 'table.companies'
  end
end

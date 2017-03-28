require 'rails_helper'

describe VersionDecorator do
  let(:version) { Version.new.extend VersionDecorator }
  subject { version }
  it { should be_a Version }

  describe 'event_label' do
    subject { version.event_label }
    it 'createなら「作成」' do
      version.event = 'create'
      is_expected.to eq '作成'
    end

    it 'updateなら「更新」' do
      version.event = 'update'
      is_expected.to eq '更新'
    end

    it 'それ以外なら「更新」' do
      version.event = 'other'
      is_expected.to eq '更新'
    end
  end
end

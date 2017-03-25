require 'rails_helper'

describe VersionDecorator do
  let(:version) { Version.new.extend VersionDecorator }
  subject { version }
  it { should be_a Version }
end

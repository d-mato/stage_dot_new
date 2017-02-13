require 'rails_helper'

describe Interview do
  it 'is invalid when start_at is blank' do
    interview = Interview.new(start_at: nil)
    expect(interview).not_to be_valid
    expect(interview.errors[:start_at]).to be_present
  end
end

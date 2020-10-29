# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IncidentSeverity, type: :model do
  before(:each) do
    @incident_severity = create(:incident_severity)
  end

  it 'is valid with valid attributes' do
    expect(@incident_severity).to be_valid
  end

  it 'adds error for empty description' do
    @incident_severity.description = ''
    @incident_severity.save

    @incident_severity.valid?
    expect(@incident_severity.errors[:description][0])
      .to include('can\'t be blank')
  end
end

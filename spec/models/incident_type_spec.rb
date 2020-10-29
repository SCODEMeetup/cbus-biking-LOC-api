# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IncidentType, type: :model do
  before(:each) do
    @incident_type = create(:incident_type)
  end

  it 'is valid with valid attributes' do
    expect(@incident_type).to be_valid
  end

  it 'adds error for empty description' do
    @incident_type.description = ''
    @incident_type.save

    @incident_type.valid?
    expect(@incident_type.errors[:description][0]).to include('can\'t be blank')
  end
end

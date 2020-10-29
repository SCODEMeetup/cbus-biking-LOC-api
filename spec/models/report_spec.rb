# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Report, type: :model do
  before(:each) do
    incident_type = create(:incident_type)
    incident_severity = create(:incident_severity)
    @report = create(:report, incident_type_id: incident_type.id,
                             incident_severity_id: incident_severity.id)
  end

  it 'is valid with valid attributes' do
    expect(@report).to be_valid
  end

  it 'adds error for invalid lat' do
    @report.lat = '95.12'

    @report.valid?
    expect(@report.errors[:lat][0]).to include('less than or equal to 90')
  end

  it 'adds error for invalid lat' do
    @report.long = '-185.12'

    @report.valid?
    expect(@report.errors[:long][0]).to include('greater than or equal to -180')
  end

  it 'adds errors for missing lat/long' do
    @report.lat = ''
    @report.long = ''

    @report.valid?
    expect(@report.errors[:lat][0]).to include('can\'t be blank')
    expect(@report.errors[:lat][1]).to include('is not a number')
    expect(@report.errors[:long][0]).to include('can\'t be blank')
    expect(@report.errors[:long][1]).to include('is not a number')
  end

  it 'adds error for invalid incident_datetime' do
    @report.incident_datetime = ''

    @report.valid?
    expect(@report.errors[:incident_datetime][0]).to include('must be ISO 8601')
  end

  it 'adds error for missing incident_type' do
    @report.incident_type = nil

    @report.valid?
    expect(@report.errors[:incident_type][0]).to include('must exist')
  end

  it 'adds error for missing severity_type' do
    @report.incident_severity = nil

    @report.valid?
    expect(@report.errors[:incident_severity][0]).to include('must exist')
  end
end

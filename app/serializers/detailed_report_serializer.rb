# frozen_string_literal: true

# Defines Report attributes and associations to be returned in JSON
# Customized serializer for detailed report, e.g., includes narrative
class DetailedReportSerializer < ActiveModel::Serializer
  attributes :id, :lat, :long, :incident_datetime, :incident_text, :narrative,
             :created_at

  has_one :incident_type
  has_one :incident_severity
  has_one :incident_subject
end

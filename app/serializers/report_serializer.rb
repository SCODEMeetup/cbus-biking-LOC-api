# frozen_string_literal: true

# Defines Report attributes and associations to be returned in JSON
class ReportSerializer < ActiveModel::Serializer
  attributes :id, :lat, :long, :incident_datetime, :incident_text, :created_at

  has_one :incident_type
  has_one :incident_severity
end

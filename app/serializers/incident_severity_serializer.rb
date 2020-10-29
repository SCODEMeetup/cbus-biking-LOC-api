# frozen_string_literal: true

# Defines incident_severity attributes to be returned in JSON
class IncidentSeveritySerializer < ActiveModel::Serializer
  attributes :id, :description
end

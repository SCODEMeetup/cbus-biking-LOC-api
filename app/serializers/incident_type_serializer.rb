# frozen_string_literal: true

# Defines incident_type attributes to be returned in JSON
class IncidentTypeSerializer < ActiveModel::Serializer
  attributes :id, :description
end

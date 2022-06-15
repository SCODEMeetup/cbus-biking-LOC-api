# frozen_string_literal: true

# Defines incident_severity attributes to be returned in JSON
class IncidentSubjectSerializer < ActiveModel::Serializer
  attributes :id, :description
end

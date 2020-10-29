# frozen_string_literal: true

# Severity of Incidents in Reports
class IncidentSeverity < ApplicationRecord
  has_many :reports, dependent: :restrict_with_exception

  validates :description, presence: true
end

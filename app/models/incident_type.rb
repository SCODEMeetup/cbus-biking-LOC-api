# frozen_string_literal: true

# Type of Incident in Reports
class IncidentType < ApplicationRecord
  has_many :reports, dependent: :restrict_with_exception

  validates :description, presence: true
end

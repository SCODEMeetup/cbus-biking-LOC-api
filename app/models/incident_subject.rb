# frozen_string_literal: true

# Subject of Incidents in Reports, e.g., bicycle, pedestrian, etc.
class IncidentSubject < ApplicationRecord
  has_many :reports, dependent: :restrict_with_exception

  validates :description, presence: true
end

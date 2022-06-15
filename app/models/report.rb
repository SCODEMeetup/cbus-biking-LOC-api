# frozen_string_literal: true

# Incident Reports associated with location
class Report < ApplicationRecord
  belongs_to :incident_type, foreign_key: :incident_type_id
  belongs_to :incident_severity, foreign_key: :incident_severity_id
  belongs_to :incident_subject, foreign_key: :incident_subject_id

  validate :incident_datetime_must_be_iso8601
  validates :lat, presence: true,
                  numericality: { greater_than_or_equal_to: -90,
                                  less_than_or_equal_to: 90 }
  validates :long, presence: true,
                   numericality: { greater_than_or_equal_to: -180,
                                   less_than_or_equal_to: 180 }

  validates :incident_year, presence: true,
                   numericality: { greater_than_or_equal_to:
                                     Date.today.year - 5,
                                   less_than_or_equal_to: Date.today.year }

  def incident_datetime_must_be_iso8601
    return if incident_datetime.is_a?(Time)

    errors.add(:incident_datetime,
               'must be ISO 8601 UTC, e.g., 2020-09-11T21:44:42Z')
  end

  scope :by_incident_year, lambda { |year|
    where('incident_year = ?', year)
  }

  scope :by_incident_subject_id, lambda { |incident_subject_id|
    where('incident_subject_id = ?', incident_subject_id)
  }

  scope :by_incident_severity_id, lambda { |incident_severity_id|
    where('incident_severity_id = ?', incident_severity_id)
  }

  scope :by_current_and_last_incident_year, lambda {
    year = Date.today.year
    prev_year = year - 1
    where('incident_year = ? OR incident_year = ?', year, prev_year)
  }
end

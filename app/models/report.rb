# frozen_string_literal: true

# Incident Reports associated with location
class Report < ApplicationRecord
  belongs_to :incident_type, foreign_key: :incident_type_id
  belongs_to :incident_severity, foreign_key: :incident_severity_id

  validate :incident_datetime_must_be_iso8601
  validates :lat, presence: true,
                  numericality: { greater_than_or_equal_to: -90,
                                  less_than_or_equal_to: 90 }
  validates :long, presence: true,
                   numericality: { greater_than_or_equal_to: -180,
                                   less_than_or_equal_to: 180 }

  def incident_datetime_must_be_iso8601
    return if incident_datetime.is_a?(Time)

    errors.add(:incident_datetime,
               'must be ISO 8601 UTC, e.g., 2020-09-11T21:44:42Z')
  end
end

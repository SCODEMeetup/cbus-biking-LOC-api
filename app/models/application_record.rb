# frozen_string_literal: true

# all application models inherit from this
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

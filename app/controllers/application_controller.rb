# frozen_string_literal: true

# Application controllers inherit from this
class ApplicationController < ActionController::API
  # refers to lib/error/error_handler.rb
  include Error::ErrorHandler
end

# frozen_string_literal: true

module Api
  # CRUD operations on the IncidentSeverities endpoint
  class IncidentSeveritiesController < ApplicationController
    before_action :set_incident_severity, only: %i[show destroy update]
    before_action :set_headers

    # GET incident_severities/:id
    def show
      render json: @incident_severity
    end

    def index
      render json: IncidentSeverity.all
    end

    # POST /incident_severities
    def create
      @incident_severity = IncidentSeverity.new(incident_severity_params)
      if @incident_severity.save
        render json: @incident_severity, status: :created,
               location: api_report_url(@incident_severity)
      else
        render json: @incident_severity.errors, status: :unprocessable_entity
      end
    end

    # DELETE incident_severities/:id
    def destroy
      return unless @incident_severity

      @incident_severity.destroy
    end

    # PATCH/PUT incident_severities/:id
    def update
      return unless @incident_severity

      @incident_severity.update(incident_severity_params)
      return if @incident_severity.valid?

      render json: @incident_severity.errors, status: :unprocessable_entity
    end

    def set_incident_severity
      @incident_severity = IncidentSeverity.find(params[:id])
    end

    def set_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, DELETE, GET'
      headers['Access-Control-Request-Method'] = '*'
    end

    def incident_severity_params
      params.require(:incident_severity).permit(:description)
    end
  end
end

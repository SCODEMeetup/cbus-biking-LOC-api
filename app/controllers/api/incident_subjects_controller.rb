# frozen_string_literal: true

module Api
  # CRUD operations on the IncidentSeverities endpoint
  class IncidentSubjectsController < ApplicationController
    before_action :set_incident_subject, only: %i[show destroy update]
    before_action :set_headers

    # GET incident_severities/:id
    def show
      render json: @incident_subject
    end

    def index
      render json: IncidentSubject.all
    end

    # POST /incident_severities
    def create
      @incident_subject = IncidentSubject.new(incident_subject_params)
      if @incident_subject.save
        render json: @incident_subject, status: :created,
               location: api_report_url(@incident_subject)
      else
        render json: @incident_subject.errors, status: :unprocessable_entity
      end
    end

    # DELETE incident_severities/:id
    def destroy
      return unless @incident_subject

      @incident_subject.destroy
    end

    # PATCH/PUT incident_severities/:id
    def update
      return unless @incident_subject

      @incident_subject.update(incident_subject_params)
      return if @incident_subject.valid?

      render json: @incident_subject.errors, status: :unprocessable_entity
    end

    def set_incident_subject
      @incident_subject = IncidentSubject.find(params[:id])
    end

    def set_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, DELETE, GET'
      headers['Access-Control-Request-Method'] = '*'
    end

    def incident_subject_params
      params.require(:incident_subject).permit(:description)
    end
  end
end

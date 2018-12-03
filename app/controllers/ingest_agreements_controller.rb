# frozen_string_literal: true

class IngestAgreementsController < ApplicationController
  before_action :set_ingest_agreement, only: [:show, :update, :destroy]

  # GET /ingest_agreements
  def index
    @ingest_agreements = IngestAgreement.all

    render json: @ingest_agreements
  end

  # GET /ingest_agreements/1
  def show
    render json: @ingest_agreement
  end

  # POST /ingest_agreements
  def create
    @ingest_agreement = IngestAgreement.new(ingest_agreement_params)

    if @ingest_agreement.save
      render json: @ingest_agreement, status: :created, location: @ingest_agreement
    else
      render json: @ingest_agreement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ingest_agreements/1
  def update
    if @ingest_agreement.update(ingest_agreement_params)
      render json: @ingest_agreement
    else
      render json: @ingest_agreement.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ingest_agreements/1
  def destroy
    @ingest_agreement.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingest_agreement
      @ingest_agreement = IngestAgreement.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ingest_agreement_params
      params.require(:ingest_agreement).permit(:name, :collector)
    end
end

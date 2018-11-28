class StatusLogsController < ApplicationController
  before_action :set_status_log, only: [:show, :update, :destroy]

  # GET /status_logs
  def index
    @status_logs = StatusLog.all

    render json: @status_logs
  end

  # GET /status_logs/1
  def show
    render json: @status_log
  end

  # POST /status_logs
  def create
    @status_log = StatusLog.new(status_log_params)

    if @status_log.save
      render json: @status_log, status: :created, location: @status_log
    else
      render json: @status_log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /status_logs/1
  def update
    if @status_log.update(status_log_params)
      render json: @status_log
    else
      render json: @status_log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /status_logs/1
  def destroy
    @status_log.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status_log
      @status_log = StatusLog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def status_log_params
      params.require(:status_log).permit(:task, :status, :progess, :max)
    end
end

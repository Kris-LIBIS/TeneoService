# frozen_string_literal: true

class CodeTablesController < ApplicationController
  before_action :set_code_table, only: [:show, :update, :destroy]

  # GET /code_tables
  def index
    @code_tables = CodeTable.all

    render json: @code_tables
  end

  # GET /code_tables/1
  def show
    render json: @code_table
  end

  # POST /code_tables
  def create
    @code_table = CodeTable.new(code_table_params)

    if @code_table.save
      render json: @code_table, status: :created, location: @code_table
    else
      render json: @code_table.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /code_tables/1
  def update
    if @code_table.update(code_table_params)
      render json: @code_table
    else
      render json: @code_table.errors, status: :unprocessable_entity
    end
  end

  # DELETE /code_tables/1
  def destroy
    @code_table.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code_table
      @code_table = CodeTable.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def code_table_params
      params.require(:code_table).permit(:type, :inst_code, :name, :ext_id, :options)
    end
end

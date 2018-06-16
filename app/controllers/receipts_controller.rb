class ReceiptsController < ApplicationController
  def index
    render json: { shit: true }
  end

  def create
    # TODO: create items
    render json: Party.find(3).as_json
  end
end

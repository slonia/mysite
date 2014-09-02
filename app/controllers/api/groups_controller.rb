class Api::GroupsController < ApplicationController
  load_resource

  respond_to :json

  def index
    render json: @groups.to_json(except: :created_at)
  end

  def show
    render json: @group.schedule_json.to_json
  end

end

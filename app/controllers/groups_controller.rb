class GroupsController < ApplicationController
  load_and_authorize_resource
  respond_to :html
  def index
  end

  def show
    @days = @group.days
    respond_with @group
  end
end

class GroupsController < ApplicationController
  load_and_authorize_resource
  def index
    @groups = @groups.for_current_term.group_by(&:term)
  end

  def show
    @days = @group.days
    respond_to do |format|
      format.html { render layout: true}
      format.xlsx { render layout: false}
      format.pdf  { render layout: false}
    end
  end
end

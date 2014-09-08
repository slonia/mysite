module Api
  class Groups < Grape::API
    namespace :groups  do
      desc "Returns list of groups"
      get '/' do
        { groups: Group.all}
      end

      desc "Returns timetable for selected group"
      params do
        requires :id, type: Integer, desc: "Group id"
      end
      get "/:id" do
        @group = Group.find(params[:id])
        { group: @group.schedule_json}
      end
    end
  end
end

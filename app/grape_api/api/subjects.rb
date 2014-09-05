module Api
  class Subjects < Grape::API
    namespace :subjects  do
      desc "Returns list of subjects"
      get '/' do
        Subject.all
      end

      desc "Returns all subjects for selected term"
      params do
        requires :term, type: Integer, desc: "Term"
      end
      get "/for_term" do
        @subjects = Subject.where("? = ANY (terms)", params[:term])
        @subjects.as_json(except: [:created_at, :updated_at],
              include: {teachers: { except: [:created_at, :updated_at] } })
      end

      desc "Detail view of subject"
      params do
        requires :id, type: Integer, desc: 'Subject id'
      end
      get '/:id' do
        @subject = Subject.find(params[:id])
      end

      desc "List of teachers for selected subject"
      params do
        requires :id, type: Integer, desc: 'Subject id'
      end
      get '/:id/teachers' do
        @subject = Subject.find(params[:id])
        @subject.teachers.as_json(only: [:id], methods: :short_name)
      end
    end
  end

end

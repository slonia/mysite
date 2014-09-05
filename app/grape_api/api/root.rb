require 'grape-swagger'
module Api
  class Root < Grape::API
    prefix 'api'
    format :json

    mount Api::Subjects
    mount Api::Groups

    add_swagger_documentation mount_path: '/doc',
                              hide_documentation_path: '/doc/swagger_doc',
                              markdown: true
  end
end

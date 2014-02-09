namespace :dump do
  desc 'create new dump'
  task create: :environment do
    rails_env = "production"
    config = OpenStruct.new(YAML.load_file("#{Rails.root}/config/database.yml"))
    database = config[rails_env]["database"]
    db_username = config[rails_env]["username"]
    db_password = config[rails_env]["password"]
    dump_file_path = "~/dumps/"
    file_name = Date.today.to_s
    command "export PGPASSWORD=#{db_password} && pg_dump -U #{db_username} #{database} | gzip > #{dump_file_path}studentime-#{file_name}.gz"
  end
end

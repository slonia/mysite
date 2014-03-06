Errbag.configure do
  ## Errbag Information (optional)
  # domain   'app.errbag.com'
  # endpoint 'api/1/errors'
  # port     80
  # protocol 'http'

  ## in case you need to override auto-detection:
  # logger      Rails.logger
  # environment Rails.env

  ignore_environments 'development', 'test'


    # Errbag Token for IlyaKolodnik: StudenTime
  auth_token AppConfig.errbag

  ## Do you have custom error information you want to track?
  #  custom_reporter do |exception, rack_env|
  #    {
  #      what: 'uhoh'
  #    }
  #  end
end

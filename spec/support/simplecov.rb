# frozen_string_literal: true

require 'simplecov'

SimpleCov.start 'rails' do
  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Queries', 'app/queries'
  add_group 'Services', 'app/services'

  add_filter 'app/controllers/application_controller'
  add_filter 'app/models/application_record'

  track_files 'app/**/*.rb'
end

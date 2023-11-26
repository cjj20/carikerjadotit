namespace :elasticsearch do
  desc "Create Index Job Model for Elasticsearch"
  # rake elasticsearch:job_create_index RAILS_ENV=development
  task job_create_index: :environment do
    run = Job.__elasticsearch__.create_index!
    run ? (puts "Success") : (puts "Failed")
  end
end

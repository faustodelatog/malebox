namespace :deploy do
  
  desc "Deploy all"
  task :all do
    Rake::Task["bundle:install"].invoke
    Rake::Task["deploy:db"].invoke
    Rake::Task["deploy:web"].invoke
  end  	

  desc "Deploy web server"
  task web: :environment do
  	sh "rails s -b 0.0.0.0"
  end

  desc "Deploy the migrations to db"
  task db: :environment do
  	Rake::Task["db:migrate"].invoke
  end

end

task :deploy, [:site] do |task, args|
  Rake::Task["deploy:site"].invoke(args[:site])
end

namespace :deploy do
  
  desc 'replace view files for deployment'
  task :replace_views, [:site] do |task, args|
    p 'removing page directory'
    dir_removed = FileUtils.rm_rf('app/views/page')

    p 'current files'
    p Dir.entries('app/views')

    p "copying views from #{args[:site]}"
    FileUtils.cp_r("app/views/_#{args[:site]}/.", 'app/views/')

    p 'current files'
    p Dir.entries('app/views')
  end

  task :prepare, [:site] do |task, args|
    Rake::Task["deploy:replace_views"].invoke(args[:site])
  end

  task :site, [:site] do |task, args|
    Rake::Task["deploy:prepare"].invoke(args[:site])
    sh 'rails s'
  end

  # Rake::Task['assets:precompile'].enhance ['deploy:prepare']

end

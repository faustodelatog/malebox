namespace :deploy do
  
  desc 'replace view files for deployment'
  task :replace_views, [:site] do |task, args|
    p 'removing page directory'
    FileUtils.rm_rf('app/views/page')
    p "copying views from #{args[:site]}"
    FileUtils.cp_r("app/views/_#{args[:site]}/.", 'app/views/')
  end

  task :prepare do
    Rake::Task["deploy:replace_views"].invoke('ellas')
  end

  Rake::Task['assets:precompile'].enhance ['deploy:prepare']

end

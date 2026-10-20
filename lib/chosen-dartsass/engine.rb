module Chosen
  module Dartsass
    class Engine < ::Rails::Engine
      rake_tasks do
        load 'chosen-dartsass/tasks.rake'
      end
    end
  end
end

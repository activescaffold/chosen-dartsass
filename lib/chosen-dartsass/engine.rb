module Chosen
  module Dartsass
    class Engine < ::Rails::Engine
      config.assets.precompile += %w(
        chosen-sprite*.png
      )

      rake_tasks do
        load 'chosen-dartsass/tasks.rake'
      end
    end
  end
end

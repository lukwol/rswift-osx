Dir.glob(File.expand_path('osx/tasks/*.rake', File.dirname(__FILE__))).each { |r| load r}

module RSwift
  module OSX
  end
end

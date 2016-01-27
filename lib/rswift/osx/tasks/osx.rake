require 'rake'
require 'rswift'

DERIVED_DATA_PATH = 'build'
DEBUG_ENV_KEY = 'debug'

task :default => :run

desc 'Build workspace'
task :build do
  workspace = RSwift::WorkspaceProvider.workspace
  project_path = Dir.glob('*.xcodeproj').first
  project = Xcodeproj::Project.open(project_path)
  output = ""
  IO.popen("xcodebuild -workspace #{workspace} -scheme #{project.app_scheme_name} -destination 'platform=macosx' -derivedDataPath #{DERIVED_DATA_PATH} | xcpretty").each do |line|
    puts line.chomp
    output << line.chomp
  end
  success = output.include? "Build Succeeded"
  abort unless success
end

desc 'Run the application'
task :run => [:build] do
  debug = ENV[DEBUG_ENV_KEY]
  debug ||= '0'
  project_path = Dir.glob('*.xcodeproj').first
  project = Xcodeproj::Project.open(project_path)
  if debug.to_i.nonzero?
    exec "lldb #{DERIVED_DATA_PATH}/Build/Products/Debug/#{project.app_target.product_name}.app/"
  else
    system "open #{DERIVED_DATA_PATH}/Build/Products/Debug/#{project.app_target.product_name}.app/"
    exec "tail -f /private/var/log/system.log"
  end
end

desc 'Run the test/spec suite'
task :spec do
  workspace = RSwift::WorkspaceProvider.workspace
  project_path = Dir.glob('*.xcodeproj').first
  project = Xcodeproj::Project.open(project_path)
  exec "xcodebuild test -workspace #{workspace} -scheme #{project.app_scheme_name} -destination 'platform=macosx' -derivedDataPath #{DERIVED_DATA_PATH} | xcpretty -tc"
end

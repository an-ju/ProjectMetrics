Gem::Specification.new do |s|
  s.name        = 'project_metrics'
  s.version     = '0.0.0'
  s.date        = '2016-07-27'
  s.summary     = "ProjectMetrics"
  s.description = "Convenience methods for plugin architecture of gem metrics of projects"
  s.authors     = ["Sam Joseph"]
  s.email       = 'sam@agileventues.org'
  s.files       = ["lib/project_metrics.rb"]
  s.homepage    =
      'https://github.com/AgileVentures/ProjectMetrics'
  s.add_dependency('activesupport')
  s.add_development_dependency('rspec', ["3.4"])
  s.add_development_dependency('project_metric_code_climate')
  s.add_development_dependency('project_metric_github')
  s.license       = 'MIT'
end
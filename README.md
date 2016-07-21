# project_scope_proof_of_concept

A plugin architecture to allow reporting over a range of project metrics.

Configure the project metrics you want like so:

```rb
  ProjectMetric.configure do |config|
    config.add_metric :code_climate_project_metrics
    config.add_metric :github_project_metrics
  end
```

Then retrieve reports of those metrics for a number of projects like so:

```rb
  ProjectMetric.report(['github/AgileVentures/WebsiteOne',
                        'github/AgileVentures/LocalSupport'])
```  

ProjectMetric gems should follow these conventions:

1. Gem name matches name of file and name of class e.g. the code_climate_project_metrics gem contains the file `lib/code_climate_project_metrics` which includes the class CodeClimateProjectMetrics.
2. The gem class should define an initializer that takes a single value
3. The gem class should define a method `scalar` that returns a numeric value representing the metric
4. The gem class should define a method `image` that returns a visual representation of the metric in png, svg formats or similar
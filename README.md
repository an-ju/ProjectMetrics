# ProjectMetrics

A plugin architecture to allow reporting over a range of project metrics.

Configure the project metrics you want like so:

```rb
ProjectMetrics.configure do 
  add_metric :code_climate_project_metrics
  add_metric :github_project_metrics
end
```

Then retrieve a list of configured metrics like so:

```rb
ProjectMetrics.metric_names   # =>  ["github", "code_climate"]                     
```  

Get individual project class names like so:

```rb
ProjectMetrics.class_for("code_climate")  # => ProjectMetricCodeClimate
``` 

ProjectMetrics gems should follow these conventions:

1. Gem name matches name of file and name of class e.g. the project_metrics_code_climate gem contains the file `lib/project_metric_code_climate` which includes the class ProjectMetricCodeClimate.
2. The gem class should define an initializer that takes the following arguments `credentials = {}, raw_data = nil`
3. The gem class should define the following instance methods

  - `score` that returns a numeric value representing the metric
  - `image` that returns a visual representation of the metric in png, svg formats or similar
  - `raw_data=` that can be used if "client" app has cached it, eg in a table. Setting or refreshing raw data implies score and image are now invalid
  - `refresh` that sets raw data by refreshing from API endpoint


TODO

a) we need different project ids for different metrics - we can adjust CCPM to work with full github name, e.g. http://github.com/AgileVentures/WebsiteOne, but PivotalTracker will require an API key (and tracker id?) and PT will also need an API key, as will Github and Slack ... although slacks will point to a specific slack channel?

b) so we need some kind of Project class that can be defined to hold the necessary data? e.g.

```rb
class Project
  def initialise config_hash
    @config_hash = config_hash
  end

  def method_missing method_call
    return @config_hash[method_call] if @config_hash[method_call]
    super.method_missing
  endw
end 
```

I'm imagining that when we initialise the metric we pass the project class rather then the id, and then the gem can interrogate the project class for the ids it needs, e.g. the gem can call it's own name on the project object to retrieve the necessary data?

Then the report could return a list of projects with associated metrics ... metric objects even?  Actually they're project metrics already aren't they, so we could insert them into a container array in the project class ...? or even do something clever with method missing and distinguish between being able to call to ask for metric_id and for metric itself from the project ....
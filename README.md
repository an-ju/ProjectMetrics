# project_scope_proof_of_concept

A proof of concept rails app to replace project_scope using an extendable plugin architecture for agile adherence monitoring

Could something like this work?


# config.yml

```yml
sources: [ code_climate_project_metric, github_pr_metric, pivotal_tracker_project_metric, slack_project_metric ]
```

Rails controller (just showing single project in first instance)

```ruby
def index
 
  @sources = sources.map do |source|
     source.camelize.constantize.new('github/AgileVentures/Websiteone')
  end

end
```

Rails partial

```html
<% sources.each do |source| %>
   <p><%= source.scalar %></p><%= img source.img %>
<% end %>
```

Armando suggesting we look at [OAuth](https://developer.github.com/v3/oauth/)

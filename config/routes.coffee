exports.http = (app) ->

  app.get '/', (req, res) ->
    res.render 'index', title: "Sorry, I'm late"

  app.get '/user/(:session)', (req, res) ->
    res.render 'user'
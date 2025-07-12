(local http (require :http))
(local template (require :template))
(local { : route : goto } (require :route))

(fn page [...]
  (template.with (: (io.open "template.html") :read "a") [...]))

(route :get "/"
       (fn [req]
         { :body (page nil "<h1>welcome!</h1>") }))

(route :get "/blog/(%d)"
       (fn [req id]
         { :body (page nil id) }))

(goto (http.read-request))

(set _G.routes { :err { :path ".*"
                        :handler
                          (fn [req]
                            { :status 404 :body "not found" }) } })

(fn route [method path handler]
  (table.insert _G.routes { : method
                            :path (.. "^" (path:gsub ">[^/]+" "([^/]+)") "$")
                            : handler }))

(fn match-route [method path]
  (accumulate [curr nil
               _ route (ipairs _G.routes)]
    (if curr ;; skip if match found
        curr ;; TODO: add priority system?
        
        ;; if the route's method matches the request's method or has
        ;; no method, and, the route's path matches the request's path
        (and
         (or (not route.method) (= route.method method))
         (path:match route.path))
        route
        
        ;; 404
        _G.routes.err)))

(fn goto [req]
  (let [{ : response } (require :http)
        { : method : path } req
        route (match-route method path)
        res (route.handler (path:match route.path))]
    (response res)))
{ : route : goto }

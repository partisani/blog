(local fennel (require :fennel))

(fn with [template vals]
  (template:gsub "%%%%(.-)%%%%"
                 #(fennel.eval $1 nil (table.unpack vals))))

{ : with }

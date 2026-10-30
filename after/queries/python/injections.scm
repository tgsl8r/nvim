; extends

(call
  function: (attribute attribute: (identifier) @_method)
  arguments: (argument_list
    [
      (string (string_content) @injection.content)
      (concatenated_string (string (string_content) @injection.content))
    ]
  )
  (#match? @_method "^(execute|executemany)$")
  (#set! injection.language "sql")
  (#set! injection.combined)
)

(
  (string 
    (string_content) @injection.content)
  (#match? @injection.content "(SELECT|Select|select|INSERT|Insert|insert|UPDATE|Update|update|DELETE|Delete|delete|WITH|With|with)\\s")
  (#set! injection.language "sql")
)

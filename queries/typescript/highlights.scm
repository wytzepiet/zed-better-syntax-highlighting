;; better-highlighting: TypeScript parameter overrides

;; Required parameters
(required_parameter
  (identifier) @variable.parameter)

;; Optional parameters
(optional_parameter
  (identifier) @variable.parameter)

;; Rest parameters
(rest_parameter
  (identifier) @variable.parameter)

;; Destructured parameters
(object_pattern
  (identifier) @variable.parameter)

(array_pattern
  (identifier) @variable.parameter)

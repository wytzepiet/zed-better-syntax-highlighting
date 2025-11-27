;; better-highlighting: TypeScript parameter identifiers only
;;
;; Goal:
;; - Capture ONLY binding identifiers that belong to function/method/constructor parameters
;; - Support defaults (assignment_pattern) and destructuring (object_pattern / array_pattern)
;; - Avoid overmatching object/array patterns outside of parameters
;;
;; Notes:
;; - We purposely do NOT match property keys (property_identifier) or types.
;; - We do NOT match `this` parameters since they are not variables (and are not identifiers).
;; - Rest parameters cannot have defaults, so those cases are omitted.

; -----------------------------------------------------------------------------
; Simple parameter identifiers
; -----------------------------------------------------------------------------

(required_parameter
  (identifier) @variable.parameter)

(optional_parameter
  (identifier) @variable.parameter)

(rest_parameter
  (identifier) @variable.parameter)

; -----------------------------------------------------------------------------
; Parameters with default values: foo = expr
; -----------------------------------------------------------------------------

(required_parameter
  (assignment_pattern
    left: (identifier) @variable.parameter))

(optional_parameter
  (assignment_pattern
    left: (identifier) @variable.parameter))

; -----------------------------------------------------------------------------
; Destructured parameters: object patterns
; -----------------------------------------------------------------------------
; Direct object pattern parameters
(required_parameter
  (object_pattern
    (shorthand_property_identifier_pattern) @variable.parameter))

(required_parameter
  (object_pattern
    (pair
      value: (identifier) @variable.parameter)))

(required_parameter
  (object_pattern
    (pair
      value: (assignment_pattern
        left: (identifier) @variable.parameter))))

(required_parameter
  (object_pattern
    (rest_pattern
      (identifier) @variable.parameter)))

; Object pattern inside a default: ({ a, b = 1, ...rest } = obj)
(required_parameter
  (assignment_pattern
    left: (object_pattern
      (shorthand_property_identifier_pattern) @variable.parameter)))

(required_parameter
  (assignment_pattern
    left: (object_pattern
      (pair
        value: (identifier) @variable.parameter))))

(required_parameter
  (assignment_pattern
    left: (object_pattern
      (pair
        value: (assignment_pattern
          left: (identifier) @variable.parameter)))))

(required_parameter
  (assignment_pattern
    left: (object_pattern
      (rest_pattern
        (identifier) @variable.parameter))))

; Optional parameter with object pattern
(optional_parameter
  (object_pattern
    (shorthand_property_identifier_pattern) @variable.parameter))

(optional_parameter
  (object_pattern
    (pair
      value: (identifier) @variable.parameter)))

(optional_parameter
  (object_pattern
    (pair
      value: (assignment_pattern
        left: (identifier) @variable.parameter))))

(optional_parameter
  (object_pattern
    (rest_pattern
      (identifier) @variable.parameter)))

; Optional parameter with object pattern + default
(optional_parameter
  (assignment_pattern
    left: (object_pattern
      (shorthand_property_identifier_pattern) @variable.parameter)))

(optional_parameter
  (assignment_pattern
    left: (object_pattern
      (pair
        value: (identifier) @variable.parameter))))

(optional_parameter
  (assignment_pattern
    left: (object_pattern
      (pair
        value: (assignment_pattern
          left: (identifier) @variable.parameter)))))

(optional_parameter
  (assignment_pattern
    left: (object_pattern
      (rest_pattern
        (identifier) @variable.parameter))))

; -----------------------------------------------------------------------------
; Destructured parameters: array patterns
; -----------------------------------------------------------------------------
; Direct array pattern parameters
(required_parameter
  (array_pattern
    (identifier) @variable.parameter))

(required_parameter
  (array_pattern
    (assignment_pattern
      left: (identifier) @variable.parameter)))

(required_parameter
  (array_pattern
    (rest_pattern
      (identifier) @variable.parameter)))

; Array pattern inside a default: ([a, b = 1, ...rest] = arr)
(required_parameter
  (assignment_pattern
    left: (array_pattern
      (identifier) @variable.parameter)))

(required_parameter
  (assignment_pattern
    left: (array_pattern
      (assignment_pattern
        left: (identifier) @variable.parameter))))

(required_parameter
  (assignment_pattern
    left: (array_pattern
      (rest_pattern
        (identifier) @variable.parameter))))

; Optional parameter with array pattern
(optional_parameter
  (array_pattern
    (identifier) @variable.parameter))

(optional_parameter
  (array_pattern
    (assignment_pattern
      left: (identifier) @variable.parameter)))

(optional_parameter
  (array_pattern
    (rest_pattern
      (identifier) @variable.parameter)))

; Optional parameter with array pattern + default
(optional_parameter
  (assignment_pattern
    left: (array_pattern
      (identifier) @variable.parameter)))

(optional_parameter
  (assignment_pattern
    left: (array_pattern
      (assignment_pattern
        left: (identifier) @variable.parameter))))

(optional_parameter
  (assignment_pattern
    left: (array_pattern
      (rest_pattern
        (identifier) @variable.parameter))))

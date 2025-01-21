;; Interdimensional Power Plant Management Contract

(define-data-var plant-counter uint u0)

(define-map power-plants uint {
  universe: (string-ascii 50),
  plant-type: (string-ascii 50),
  capacity: uint,
  efficiency: uint,
  operational-status: (string-ascii 20),
  last-maintenance: uint
})

(define-public (register-power-plant (universe (string-ascii 50)) (plant-type (string-ascii 50)) (capacity uint) (efficiency uint))
  (let
    ((new-id (+ (var-get plant-counter) u1)))
    (map-set power-plants new-id {
      universe: universe,
      plant-type: plant-type,
      capacity: capacity,
      efficiency: efficiency,
      operational-status: "operational",
      last-maintenance: block-height
    })
    (var-set plant-counter new-id)
    (ok new-id)
  )
)

(define-public (update-plant-status (plant-id uint) (new-status (string-ascii 20)))
  (let
    ((plant (unwrap! (map-get? power-plants plant-id) (err u404))))
    (ok (map-set power-plants plant-id
      (merge plant { operational-status: new-status })))
  )
)

(define-public (perform-maintenance (plant-id uint))
  (let
    ((plant (unwrap! (map-get? power-plants plant-id) (err u404))))
    (ok (map-set power-plants plant-id
      (merge plant { last-maintenance: block-height })))
  )
)

(define-read-only (get-power-plant (plant-id uint))
  (map-get? power-plants plant-id)
)

(define-read-only (get-plant-count)
  (var-get plant-counter)
)


;; Energy Transfer Agreement Contract

(define-data-var agreement-counter uint u0)

(define-map energy-transfer-agreements uint {
  source-universe: (string-ascii 50),
  destination-universe: (string-ascii 50),
  energy-amount: uint,
  start-time: uint,
  end-time: uint,
  price-per-unit: uint,
  status: (string-ascii 20)
})

(define-public (create-agreement (source (string-ascii 50)) (destination (string-ascii 50)) (amount uint) (start uint) (end uint) (price uint))
  (let
    ((new-id (+ (var-get agreement-counter) u1)))
    (map-set energy-transfer-agreements new-id {
      source-universe: source,
      destination-universe: destination,
      energy-amount: amount,
      start-time: start,
      end-time: end,
      price-per-unit: price,
      status: "pending"
    })
    (var-set agreement-counter new-id)
    (ok new-id)
  )
)

(define-public (update-agreement-status (agreement-id uint) (new-status (string-ascii 20)))
  (let
    ((agreement (unwrap! (map-get? energy-transfer-agreements agreement-id) (err u404))))
    (ok (map-set energy-transfer-agreements agreement-id
      (merge agreement { status: new-status })))
  )
)

(define-read-only (get-agreement (agreement-id uint))
  (map-get? energy-transfer-agreements agreement-id)
)

(define-read-only (get-agreement-count)
  (var-get agreement-counter)
)


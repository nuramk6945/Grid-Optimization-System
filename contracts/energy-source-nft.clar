;; Energy Source NFT Contract

(define-non-fungible-token energy-source uint)

(define-data-var last-token-id uint u0)

(define-map token-metadata uint {
  name: (string-ascii 100),
  description: (string-utf8 500),
  universe: (string-ascii 50),
  energy-type: (string-ascii 50),
  output-capacity: uint,
  rarity-score: uint
})

(define-public (mint-energy-source (name (string-ascii 100)) (description (string-utf8 500)) (universe (string-ascii 50)) (energy-type (string-ascii 50)) (output-capacity uint) (rarity-score uint))
  (let
    ((token-id (+ (var-get last-token-id) u1)))
    (try! (nft-mint? energy-source token-id tx-sender))
    (map-set token-metadata token-id {
      name: name,
      description: description,
      universe: universe,
      energy-type: energy-type,
      output-capacity: output-capacity,
      rarity-score: rarity-score
    })
    (var-set last-token-id token-id)
    (ok token-id)
  )
)

(define-public (transfer (token-id uint) (sender principal) (recipient principal))
  (nft-transfer? energy-source token-id sender recipient)
)

(define-read-only (get-token-metadata (token-id uint))
  (map-get? token-metadata token-id)
)

(define-read-only (get-last-token-id)
  (var-get last-token-id)
)


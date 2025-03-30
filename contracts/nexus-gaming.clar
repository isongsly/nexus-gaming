;; Title: 
;; Nexus Gaming Protocol: Bitcoin-Powered Decentralized Gaming on Stacks Layer 2
;; 
;; Summary:
;; A comprehensive gaming ecosystem enabling NFT-based assets, competitive leaderboards, 
;; and Bitcoin-denominated rewards through secure Stacks Layer 2 smart contracts
;;
;; Description:
;; The Nexus Gaming Protocol establishes a decentralized gaming infrastructure leveraging
;; Bitcoin's security and Stacks' Layer 2 capabilities. This implementation features:
;;
;; 1. NFT-Powered Game Economy:
;;    - Mintable in-game assets with upgradable metadata (rarity, power levels, attributes)
;;    - Unique player avatars with progression systems (XP/level mechanics)
;;    - Cross-world asset interoperability with access control
;;
;; 2. Competitive Play Infrastructure:
;;    - Dynamic leaderboard system with anti-sybil mechanisms
;;    - Skill-based Bitcoin reward distribution
;;    - Transparent ranking algorithms with on-chain verification
;;
;; 3. Bitcoin Integration:
;;    - STX/BTC-compliant reward distribution channels
;;    - Secure fee handling with protocol-admin controls
;;    - Hybrid asset model supporting both fungible and non-fungible rewards
;;
;; 4. Virtual World Architecture:
;;    - Customizable game worlds with entry requirements
;;    - Player capacity management
;;    - Cross-world asset compatibility system
;;
;; Built with Clarity's secure smart contract language, this protocol enables:
;; - Provably fair gameplay mechanics
;; - Transparent asset ownership tracking
;; - Bitcoin-settled tournament prizes
;; - Regulatory-compliant gaming operations
;;
;; Designed for Layer 2 scalability, the protocol supports high-frequency gaming actions
;; while maintaining atomic Bitcoin settlement finality through Stacks' proof-of-transfer.

;; Error Constants
(define-constant ERR-NOT-AUTHORIZED (err u1))
(define-constant ERR-INVALID-GAME-ASSET (err u2))
(define-constant ERR-INSUFFICIENT-FUNDS (err u3))
(define-constant ERR-TRANSFER-FAILED (err u4))
(define-constant ERR-LEADERBOARD-FULL (err u5))
(define-constant ERR-ALREADY-REGISTERED (err u6))
(define-constant ERR-INVALID-REWARD (err u7))
(define-constant ERR-INVALID-INPUT (err u8))
(define-constant ERR-INVALID-SCORE (err u9))
(define-constant ERR-INVALID-FEE (err u10))
(define-constant ERR-INVALID-ENTRIES (err u11))
(define-constant ERR-PLAYER-NOT-FOUND (err u12))
(define-constant ERR-INVALID-AVATAR (err u13))
(define-constant ERR-WORLD-NOT-FOUND (err u14))
(define-constant ERR-INVALID-NAME (err u15))
(define-constant ERR-INVALID-DESCRIPTION (err u16))
(define-constant ERR-INVALID-RARITY (err u17))
(define-constant ERR-INVALID-POWER-LEVEL (err u18))
(define-constant ERR-INVALID-ATTRIBUTES (err u19))
(define-constant ERR-INVALID-WORLD-ACCESS (err u20))
(define-constant ERR-INVALID-OWNER (err u21))
(define-constant ERR-MAX-LEVEL-REACHED (err u22))
(define-constant ERR-MAX-EXPERIENCE-REACHED (err u23))
(define-constant ERR-INVALID-LEVEL-UP (err u24))

;; Game Mechanics Constants
(define-constant MAX-LEVEL u100)
(define-constant MAX-EXPERIENCE-PER-LEVEL u1000)
(define-constant BASE-EXPERIENCE-REQUIRED u100)

;; Protocol Configuration
(define-data-var protocol-fee uint u10)
(define-data-var max-leaderboard-entries uint u50)
(define-data-var total-prize-pool uint u0)
(define-data-var total-assets uint u0)
(define-data-var total-avatars uint u0)
(define-data-var total-worlds uint u0)

;; Access Control
(define-map protocol-admin-whitelist principal bool)

;; Validation Functions
(define-private (is-valid-name (name (string-ascii 50)))
  (and 
    (>= (len name) u1)
    (<= (len name) u50)
    (not (is-eq name ""))
  )
)

(define-private (is-valid-description (description (string-ascii 200)))
  (and 
    (>= (len description) u1)
    (<= (len description) u200)
    (not (is-eq description ""))
  )
)

(define-private (is-valid-rarity (rarity (string-ascii 20)))
  (or 
    (is-eq rarity "common")
    (is-eq rarity "uncommon")
    (is-eq rarity "rare")
    (is-eq rarity "epic")
    (is-eq rarity "legendary")
  )
)

(define-private (is-valid-power-level (power uint))
  (and (>= power u1) (<= power u1000))
)

(define-private (is-valid-attributes (attributes (list 10 (string-ascii 20))))
  (and 
    (>= (len attributes) u1)
    (<= (len attributes) u10)
  )
)
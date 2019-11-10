

- A helper script to sync imagese from Gloo's distribution repo to the designated GCR Marketplace repo.
  - run with `--dry-run` to preview the repo mappings
  - update the script constants any time the source or target specs change

```bash
go run main.go --dry-run
mirroring from: quay.io/solo-io/gloo:0.0.21
to: gcr.io/solo-io-public/gloo/gloo:1.0
mirroring from: quay.io/solo-io/discovery:0.0.21
to: gcr.io/solo-io-public/gloo/gloo/discovery:1.0
mirroring from: quay.io/solo-io/gateway:0.0.21
to: gcr.io/solo-io-public/gloo/gloo/gateway:1.0
mirroring from: quay.io/solo-io/gateway-conversion:0.0.21
to: gcr.io/solo-io-public/gloo/gloo/gateway-conversion:1.0
mirroring from: quay.io/solo-io/certgen:0.0.21
to: gcr.io/solo-io-public/gloo/gloo/certgen:1.0
mirroring from: quay.io/solo-io/gloo-envoy-wrapper:0.0.21
to: gcr.io/solo-io-public/gloo/gloo/gloo-envoy-wrapper:1.0
mirroring from: quay.io/solo-io/access-logger:0.0.21
to: gcr.io/solo-io-public/gloo/gloo/access-logger:1.0
```

- note that this produces the following repo structure:
```
├── gloo:version
└── gloo
    ├── discovery:version
    ├── gateway:version
    └── etc...
```

# Cluster Autoscaler

This project implements a simple webhook to scale a tmc provisioned cluster

## How does this work?

We monitor our clusters with wavefront. If you do not have, t could be any other monitoring system that

### Requirements

- tmc cli
- tmc account
- tmc api token

## How to build

- Dev build

```
make install
```

- Docker Build

```
make package
```

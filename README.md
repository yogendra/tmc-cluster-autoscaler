# Cluster Autoscaler

This project implements a simple webhook to scale a tmc provisioned cluster

## How does this work?

We monitor our clusters with wavefront. If you do not have, t could be any other monitoring system that

### Requirements

- tmc cli
- tmc account
- tmc api token

## How to use

TBA - Working on helm chart to use in k8s. See [k8s](k8) directory

## Development Environment

- direnv
- pyenv
- docker
- tmc cli

## How to build

- Clone this repo

  ```
  git clone git@github.com:yogendra/tmc-cluster-autoscaler.git
  ```

  Or

  ```
  git clone https://github.com/yogendra/tmc-cluster-autoscaler.git
  ```

- Change to the directory

  ```
  cd tmc-cluster-autoscaler
  ```

- Allow direnv

  ```
  direnv allow
  ```

- Setup local `.envrc-local` for secrets

  ```
  cp .envrc-local.tempalte .envrc-local
  ```

  Edit `.envrc-local` and put your own API token in it. After editing file just run allow direnv again

  ```
  direnv allow
  ```

- Install dependencies

  ```
  make requirements
  ```

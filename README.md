# README

## Versions

- ruby **3.1.2**
- rails **7.0.4**
- postgres **14**

## HOW START

- clone project
  ```bash
  git clone git@github.com:kolan4ick/AssistorAPI.git
  cd AssistorAPI
  ```

- install ruby and RVM if need
  ```bash
  bundle
  cp .env-template .env
  ```

- change *.env* file if need product env
- create db and run migrates
  ```bash
  rails db:setup
  ```

- Run project

  ```bash
  rails s
  ```
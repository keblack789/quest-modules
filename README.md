# rearc-modules

This repository represents the modules used by quest-infrastructure to bring up the resources in AWS.

These modules are meant to be reusable and generic. They should be able to be used anytime resources of that service are needed. 

All environments should use the modules to bring up resouces in terraform by passing in their own custom variables.
# Next

What we're planning on doing the next time. i.e. a file we can check out at the start of every stream because we can't memorize stuff

## This

- Get rid of the Az CLI dependency by handling authn using the SDK (MSI only first to avoid complexity of app registration)
  - Instead of using "NewAuthorizerFromCLI" use one of the other flows that don't depend on the CLI
- Instead of using the CLI to get subscription and current ClientID define those in Symphony

# Next

What we're planning on doing the next time. i.e. a file we can check out at the start of every stream because we can't memorize stuff

## 27.01.22

- Get rid of the Az CLI dependency by handling authn using the SDK (MSI only first to avoid complexity of app registration)
  - Instead of using "NewAuthorizerFromCLI" use one of the other flows that don't depend on the CLI
- Instead of using the CLI to get subscription and current ClientID define those in Symphony

## Next

- Trying to list all resourcegroups after logging in using an app registration (to verifiy login worked fine)
  - Reader permissions, 8 Rgs present
  - Craps out for some reason -> Doesn't do what we want it to
  - "context.Context" is not an expression - apparently
  - No idea what's wrong

SideNote: vscode live share was acting up and adding phantom characters. Maybe force Ryan to use the proper installed version instead of the web one

https://github.com/sylr/prometheus-azure-exporter/blob/91fd456f1a05992c3a69c943b7c807ed9c5ab176/pkg/azure/resource_group.go

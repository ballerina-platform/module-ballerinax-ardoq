# Application dependency mapping

This example models an application dependency in Ardoq: it finds a workspace by name, discovers the component and reference types defined by its model, creates two application components, and links them with a reference.

## Prerequisites

- Ballerina Swan Lake 2201.x or later
- Push the connector to the local repository:
  ```bash
  cd ballerina
  bal pack && bal push --repository=local
  ```
- Create a `Config.toml` in this directory:
  ```toml
  token = "<your-ardoq-api-token>"
  serviceUrl = "https://app.ardoq.com/api/v2"
  workspaceName = "Application Portfolio"
  ```

## Run the example

```bash
bal run
```

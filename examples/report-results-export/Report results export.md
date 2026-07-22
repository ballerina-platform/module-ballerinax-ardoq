# Report results export

This example exports the results of an Ardoq report: it finds a report by name, fetches its definition to show the configured columns, then runs the report and prints the results in tabular format.

## Prerequisites

- Ballerina Swan Lake 2201.12.x or later
- Push the connector to the local repository:
  ```bash
  cd ballerina
  bal pack && bal push --repository=local
  ```
- Create a `Config.toml` in this directory:
  ```toml
  token = "<your-ardoq-api-token>"
  serviceUrl = "https://instance.ardoq.com/api/v2"
  reportName = "Application Criticality Report"
  ```

## Run the example

```bash
bal run
```

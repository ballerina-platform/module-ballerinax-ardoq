# Report Results Export

This example demonstrates how to export the results of an Ardoq report. It:

1. Finds a report by name
2. Fetches its definition to show the configured columns
3. Runs the report and prints the results in tabular format

## Prerequisites

1. Generate an Ardoq API token as described in the [Ardoq API documentation](https://developer.ardoq.com/docs/api-and-integrations/rest-api).

2. Build and push the connector to your local Ballerina repository:

    ```bash
    cd ../../ballerina
    bal pack && bal push --repository=local
    ```

3. Create a `Config.toml` in this directory with your credentials:

    ```toml
    token = "<your-ardoq-api-token>"
    serviceUrl = "https://app.ardoq.com/api/v2"
    reportName = "Application Criticality Report"
    ```

   > **Note:** Replace `"Application Criticality Report"` with the name of an existing report in your Ardoq organization.

## Running the example

Execute the following commands from this directory:

```bash
bal run
```

## Expected output

```
Found report: Application Criticality Report (2e4a7b8c9d0e1f2a3b4c5d6e)
Columns: Application Name, Criticality Level, Owner, Last Updated
Rows: 42
["Payment Gateway","High","Jane Doe","2026-07-15"]
["Customer Portal","Medium","John Smith","2026-07-10"]
...
```

The actual column names, row count, and data will differ based on your report configuration and organization's data.

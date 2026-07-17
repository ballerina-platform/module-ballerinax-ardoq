# Examples

The `ballerinax/ardoq` connector provides practical examples illustrating usage in various scenarios.

| Example | Description |
|---------|-------------|
| [`application-dependency-mapping`](./application-dependency-mapping) | Finds a workspace by name, discovers its model types, creates two application components, and links them with a dependency reference |
| [`report-results-export`](./report-results-export) | Finds a report by name, fetches its definition to show the configured columns, then runs the report and prints the results in tabular format |

## Prerequisites

1. Generate an Ardoq API token as described in the [Ardoq API documentation](https://developer.ardoq.com/docs/api-and-integrations/rest-api).

2. Build and push the connector to your local Ballerina repository:

    ```bash
    cd ballerina
    bal pack && bal push --repository=local
    ```

3. For each example, create a `Config.toml` in the example directory with the required credentials:

    ```toml
    token = "<your-ardoq-api-token>"
    serviceUrl = "https://app.ardoq.com/api/v2"
    ```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```

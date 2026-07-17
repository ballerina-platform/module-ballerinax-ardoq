## Overview

[Ardoq](https://www.ardoq.com/) is a data-driven enterprise architecture platform that helps organizations model, analyze, and visualize their business and IT landscapes as connected data.

The `ballerinax/ardoq` connector offers APIs to connect and interact with the [Ardoq Public API](https://developer.ardoq.com/), enabling operations on components, references, workspaces, reports, attachments, and transactional batch requests. The connector is built against Ardoq Public API version `2026-07-13-df7c4c4b`.

## Setup guide

To use the Ardoq connector, you must have access to an Ardoq organization and an API token.

### Step 1: Sign in to Ardoq

1. Navigate to [app.ardoq.com](https://app.ardoq.com) (or your organization's custom subdomain) and sign in.

### Step 2: Generate an API token

1. Click your profile icon in the top-right corner and select **Account settings**.
2. Open the **API and tokens** tab.
3. Click **Create token**, give it a descriptive name, and copy the generated token value.

> **Note:** The Ardoq Public API expects the token as a bearer token in the `Authorization` header of every request: `Authorization: Bearer <token>`.

## Quickstart

To use the `ardoq` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerinax/ardoq;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and configure the obtained token:

    ```toml
    token = "<your-ardoq-api-token>"
    ```

2. Create an `ardoq:Client` instance:

    ```ballerina
    configurable string token = ?;

    final ardoq:Client ardoqClient = check new ();
    ```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### List all workspaces

```ballerina
public function main() returns error? {
    ardoq:PaginatedWorkspaceResponse workspaces = check ardoqClient->listWorkspaces({"Authorization": "Bearer " + token});
    foreach ardoq:Workspace workspace in workspaces.values {
        io:println(workspace.name);
    }
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `Ardoq` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-ardoq/tree/main/examples/), covering the following use cases:

1. [Application dependency mapping](https://github.com/ballerina-platform/module-ballerinax-ardoq/tree/main/examples/application-dependency-mapping) — Find a workspace by name, discover its model types, create two application components, and link them with a dependency reference.
2. [Report results export](https://github.com/ballerina-platform/module-ballerinax-ardoq/tree/main/examples/report-results-export) — Find a report by name, fetch its definition to show the configured columns, then run the report and print the results in tabular format.

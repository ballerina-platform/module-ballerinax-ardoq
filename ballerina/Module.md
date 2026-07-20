## Overview

[Ardoq](https://www.ardoq.com/) is a data-driven enterprise architecture platform that helps organizations model, analyze, and visualize their business and IT landscapes as connected data.

The `ballerinax/ardoq` connector offers APIs to connect and interact with the [Ardoq Public API](https://developer.ardoq.com/), enabling operations on components, references, workspaces, reports, attachments, and transactional batch requests.

## Setup guide

To use the Ardoq connector, you must have access to an Ardoq organization and an API token.

### Step 1: Sign in to Ardoq

1. Navigate to [app.ardoq.com](https://app.ardoq.com) (or your organization's custom subdomain) and sign in.

### Step 2: Generate an API token

1. Click your organization name in the top-left corner and select **Admin** > **Access control**.

   <img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-ardoq/main/docs/setup/resources/access-control.png alt="Navigate to Access control" style="border:1px solid #000000; width:80%">

2. Select **Service accounts** and click **+ Create new**.

   <img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-ardoq/main/docs/setup/resources/service-accounts.png alt="Create a new service account" style="border:1px solid #000000; width:80%">

3. Give the service account a name and a token description, then confirm. Copy the generated token — it is only shown once, though you can regenerate it later if needed.

   <img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-ardoq/main/docs/setup/resources/generate-token.png alt="Copy the generated API token" style="border:1px solid #000000; width:80%">

> **Note:** Pass the token to the `ardoq:Client` via the `auth` configuration when creating it — the connector attaches it as a bearer token in the `Authorization` header of every request automatically.

## Quickstart

To use the `ardoq` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerinax/ardoq;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and configure the obtained token. If you use a dedicated Ardoq instance (e.g. `https://your-org.ardoq.com`) instead of the default `app.ardoq.com`, also set `serviceUrl`:

    ```toml
    token = "<your-ardoq-api-token>"
    serviceUrl = "https://app.ardoq.com/api/v2"
    ```

2. Create an `ardoq:Client` instance:

    ```ballerina
    configurable string token = ?;
    configurable string serviceUrl = "https://app.ardoq.com/api/v2";

    final ardoq:Client ardoqClient = check new ({auth: {token: token}}, serviceUrl = serviceUrl);
    ```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### List all workspaces

```ballerina
public function main() returns error? {
    ardoq:PaginatedWorkspaceResponse workspaces = check ardoqClient->listWorkspaces();
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

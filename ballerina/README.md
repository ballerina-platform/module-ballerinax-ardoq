## Overview

[Ardoq](https://www.ardoq.com/) is a data-driven enterprise architecture platform that helps organizations model, analyze, and visualize their business and IT landscapes as connected data.

The `ballerinax/ardoq` connector offers APIs to connect and interact with the [Ardoq Public API](https://developer.ardoq.com/), enabling operations on components, references, workspaces, reports, attachments, and transactional batch requests.

## Setup guide

To use the Ardoq connector, you must have access to an Ardoq organization and an API token.

### Step 1: Sign in to Ardoq

1. Navigate to [app.ardoq.com](https://app.ardoq.com) (or your organization's custom subdomain) and sign in.

### Step 2: Generate an API token

> Also see Ardoq's own guide on [generating an API token](https://developer.ardoq.com/getting-started/generating_an_api_token/).

1. Click your organization name in the top-left corner and select **Admin** > **Access control**.

   <img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-ardoq/main/docs/setup/resources/access-control.png alt="Navigate to Access control" style="border:1px solid #000000; width:80%">

2. Select **Service accounts** and click **+ Create new**.

   <img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-ardoq/main/docs/setup/resources/service-accounts.png alt="Create a new service account" style="border:1px solid #000000; width:80%">

3. Give the service account a name and a token description, then confirm. Copy the generated token — it is only shown once, though you can regenerate it later if needed.

   <img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-ardoq/main/docs/setup/resources/generate-token.png alt="Copy the generated API token" style="border:1px solid #000000; width:80%">

> **Note:** Pass the token to the `ardoq:Client` via the `auth` configuration when creating it — the connector attaches it as a bearer token in the `Authorization` header of every request automatically.

### Step 3: Handle the organization header (only if not using a custom domain)

If you sign in at `app.ardoq.com` (rather than a dedicated domain like `https://your-org.ardoq.com`), every request must also carry an `X-org` header set to your organization label, since `app.ardoq.com` is shared across organizations. If you're on a dedicated domain, the organization is already implied by the domain itself and no `X-org` header is needed — you can skip this step. See Ardoq's [concepts guide](https://developer.ardoq.com/getting-started/making_a_simple_request/) for more details.

The `ardoq:Client` handles this for you: if `serviceUrl` points at `app.ardoq.com` and you don't pass `orgLabel` explicitly, it resolves your organization label automatically (one extra `getMe()` call at initialization) and attaches `X-org` to every request.

```ballerina
ardoq:Client ardoqClient = check new ({auth: {token: token}});
```

To skip that extra lookup, pass the label explicitly — it's shown on the same **Access control** page used to generate the token above:

```ballerina
ardoq:Client ardoqClient = check new ({auth: {token: token}}, orgLabel = "<your-org-label>");
```

You can also set `X-org` yourself through the `headers` parameter that every remote operation accepts — it takes precedence over the resolved/auto-discovered value:

```ballerina
ardoq:PaginatedWorkspaceResponse workspaces = check ardoqClient->listWorkspaces({"X-org": "<your-org-label>"});
```

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

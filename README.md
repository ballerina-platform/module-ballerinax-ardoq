# Ballerina Ardoq connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-ardoq/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-ardoq/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-ardoq.svg)](https://github.com/ballerina-platform/module-ballerinax-ardoq/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/ardoq.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%ardoq)

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

### Step 3: Organization label (automatic handling)

If you sign in at `app.ardoq.com` (rather than a dedicated domain like `https://your-org.ardoq.com`), every request must carry an `X-org` header to identify your organization. **The connector automatically detects when you're using `app.ardoq.com` and fetches your organization label using the `/me` endpoint, then injects the `X-org` header into all requests for you.**

If you prefer to provide the organization label explicitly, you can do so in the connection configuration:

```ballerina
final ardoq:Client ardoqClient = check new ({
    auth: {token: token},
    orgLabel: "your-org-label"
}, serviceUrl = serviceUrl);
```

If you're on a dedicated domain, the organization is already implied by the domain itself and automatic handling is skipped. See Ardoq's [concepts guide](https://developer.ardoq.com/getting-started/making_a_simple_request/) for more details.

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

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`ardoq` package](https://central.ballerina.io/ballerinax/ardoq/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.

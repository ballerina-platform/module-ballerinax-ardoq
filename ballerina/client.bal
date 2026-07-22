// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

# Resources for writing custom integrations.
#
# Requests to the shared `app.ardoq.com` host must carry an `X-org` header
# identifying the organization, since that host (unlike a dedicated domain)
# is not scoped to a single organization. This client wraps the generated
# `GeneratedClient` to resolve and attach that header automatically.
public isolated client class Client {
    private final GeneratedClient genClient;
    private final string? orgLabel;

    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector`
    # + serviceUrl - URL of the target service
    # + orgLabel - The organization label. Required for the shared `app.ardoq.com` host
    #              (auto-resolves if omitted). Ignored on dedicated domains
    # + return - An error if connector initialization failed
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://app.ardoq.com/api/v2",
            string? orgLabel = ()) returns error? {
        GeneratedClient genClient = check new (config, serviceUrl);
        string? resolvedOrgLabel = orgLabel;
        if resolvedOrgLabel is () && serviceUrl.includes("://app.ardoq.com") {
            UserInfo userInfo = check genClient->getMe();
            resolvedOrgLabel = userInfo.org?.label;
        }
        self.genClient = genClient;
        self.orgLabel = resolvedOrgLabel;
    }

    // Adds the X-org header when orgLabel is set, unless the caller already supplied one.
    private isolated function addOrgLabelHeader(map<string|string[]> headers) returns map<string|string[]> {
        if !headers.hasKey("X-org") && self.orgLabel is string {
            headers["X-org"] = <string>self.orgLabel;
        }
        return headers;
    }

    # Get current user and organization info
    #
    # + headers - Headers to be sent with the request
    # + return - The current user and their organization
    remote isolated function getMe(map<string|string[]> headers = {}) returns UserInfo|error {
        return self.genClient->getMe(self.addOrgLabelHeader(headers));
    }

    # List References
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - A paginated list of references matching the given filters
    remote isolated function listReferences(map<string|string[]> headers = {}, *ListReferencesQueries queries)
            returns PaginatedReferenceResponse|error {
        return self.genClient->listReferences(self.addOrgLabelHeader(headers), queries = queries);
    }

    # Create a Reference
    #
    # + payload - The payload to be sent with the request
    # + headers - Headers to be sent with the request
    # + return - The newly created reference
    remote isolated function createReference(CreateReferenceRequest payload, map<string|string[]> headers = {})
            returns Reference|error {
        return self.genClient->createReference(payload, self.addOrgLabelHeader(headers));
    }

    # List attachments
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - A paginated list of attachments matching the given filters
    remote isolated function listAttachments(map<string|string[]> headers = {}, *ListAttachmentsQueries queries)
            returns PaginatedAttachmentResponse|error {
        return self.genClient->listAttachments(self.addOrgLabelHeader(headers), queries = queries);
    }

    # Get a component
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - The requested component
    remote isolated function getComponent(string id, map<string|string[]> headers = {}) returns Component|error {
        return self.genClient->getComponent(id, self.addOrgLabelHeader(headers));
    }

    # Delete a component
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - The component was deleted successfully
    remote isolated function deleteComponent(string id, map<string|string[]> headers = {}) returns error? {
        return self.genClient->deleteComponent(id, self.addOrgLabelHeader(headers));
    }

    # Update a component
    #
    # + id - An Ardoq identifier (OID)
    # + payload - The payload to be sent with the request
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The updated component
    remote isolated function updateComponent(string id, UpdateComponentRequest payload,
            map<string|string[]> headers = {}, *UpdateComponentQueries queries) returns Component|error {
        return self.genClient->updateComponent(id, payload, self.addOrgLabelHeader(headers), queries = queries);
    }

    # List Workspaces
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - A paginated list of workspaces matching the given filters
    remote isolated function listWorkspaces(map<string|string[]> headers = {}, *ListWorkspacesQueries queries)
            returns PaginatedWorkspaceResponse|error {
        return self.genClient->listWorkspaces(self.addOrgLabelHeader(headers), queries = queries);
    }

    # Execute a batch request
    #
    # + payload - The payload to be sent with the request
    # + headers - Headers to be sent with the request
    # + return - The results of the create, update, upsert, and delete operations executed in the batch request
    remote isolated function executeBatch(BatchRequest payload, map<string|string[]> headers = {})
            returns BatchResponse|error {
        return self.genClient->executeBatch(payload, self.addOrgLabelHeader(headers));
    }

    # Get a reference
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - The requested reference
    remote isolated function getReference(string id, map<string|string[]> headers = {}) returns Reference|error {
        return self.genClient->getReference(id, self.addOrgLabelHeader(headers));
    }

    # Delete a reference
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - The reference was deleted successfully
    remote isolated function deleteReference(string id, map<string|string[]> headers = {}) returns error? {
        return self.genClient->deleteReference(id, self.addOrgLabelHeader(headers));
    }

    # Update a Reference
    #
    # + id - An Ardoq identifier (OID)
    # + payload - The payload to be sent with the request
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - The updated reference
    remote isolated function updateReference(string id, UpdateReferenceRequest payload,
            map<string|string[]> headers = {}, *UpdateReferenceQueries queries) returns Reference|error {
        return self.genClient->updateReference(id, payload, self.addOrgLabelHeader(headers), queries = queries);
    }

    # Report definition
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - The requested report definition
    remote isolated function getReport(string id, map<string|string[]> headers = {}) returns ReportOverview|error {
        return self.genClient->getReport(id, self.addOrgLabelHeader(headers));
    }

    # Get an attachment
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - The requested attachment
    remote isolated function getAttachment(string id, map<string|string[]> headers = {}) returns Attachment|error {
        return self.genClient->getAttachment(id, self.addOrgLabelHeader(headers));
    }

    # Expand Batch
    #
    # + payload - The payload to be sent with the request
    # + headers - Headers to be sent with the request
    # + return - The fully expanded batch request, with aliases resolved to their underlying identifiers
    remote isolated function expandBatch(BatchRequest payload, map<string|string[]> headers = {})
            returns BatchRequest|error {
        return self.genClient->expandBatch(payload, self.addOrgLabelHeader(headers));
    }

    # Run Report (Objects)
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - A paginated list of report result rows, keyed by column label or key
    remote isolated function runReportObjects(string id, map<string|string[]> headers = {},
            *RunReportObjectsQueries queries) returns PaginatedReportObjectResponse|error {
        return self.genClient->runReportObjects(id, self.addOrgLabelHeader(headers), queries = queries);
    }

    # Get a workspace
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - The requested workspace
    remote isolated function getWorkspace(string id, map<string|string[]> headers = {}) returns Workspace|error {
        return self.genClient->getWorkspace(id, self.addOrgLabelHeader(headers));
    }

    # List Report definitions
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - A paginated list of report definitions matching the given filters
    remote isolated function listReports(map<string|string[]> headers = {}, *ListReportsQueries queries)
            returns PaginatedReportResponse|error {
        return self.genClient->listReports(self.addOrgLabelHeader(headers), queries = queries);
    }

    # Workspace Context
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - The component and reference types defined by the workspace's model
    remote isolated function getWorkspaceContext(string id, map<string|string[]> headers = {})
            returns WorkspaceContext|error {
        return self.genClient->getWorkspaceContext(id, self.addOrgLabelHeader(headers));
    }

    # Run Report (Tabular)
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - A paginated list of report result rows in tabular (array) format
    remote isolated function runReportTabular(string id, map<string|string[]> headers = {})
            returns PaginatedReportTabularResponse|error {
        return self.genClient->runReportTabular(id, self.addOrgLabelHeader(headers));
    }

    # List Components
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - A paginated list of components matching the given filters
    remote isolated function listComponents(map<string|string[]> headers = {}, *ListComponentsQueries queries)
            returns PaginatedComponentResponse|error {
        return self.genClient->listComponents(self.addOrgLabelHeader(headers), queries = queries);
    }

    # Create a component
    #
    # + payload - The payload to be sent with the request
    # + headers - Headers to be sent with the request
    # + return - The newly created component
    remote isolated function createComponent(CreateComponentRequest payload, map<string|string[]> headers = {})
            returns Component|error {
        return self.genClient->createComponent(payload, self.addOrgLabelHeader(headers));
    }
}

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

// Requests to the shared `app.ardoq.com` host must carry an `X-org` header
// identifying the organization, since that host is not scoped to a single
// organization the way a dedicated domain is. This wraps the generated
// `Client` to resolve and attach that header automatically, so it is not
// hand-maintained inside client.bal (which is regenerated from the OpenAPI
// spec and must stay untouched). Each remote method here is a thin
// pass-through to the matching method on the generated client and must be
// kept in sync with client.bal if the API surface changes.

# A client wrapper that automatically resolves and attaches the `X-org` header
# required when connecting to the shared `app.ardoq.com` host. On a dedicated
# domain (e.g. `https://your-org.ardoq.com`) the organization is already
# implied by the domain, so no `X-org` header is added.
public isolated client class OrgAwareClient {
    private final Client baseClient;
    private final readonly & string? orgLabel;

    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector`
    # + serviceUrl - URL of the target service
    # + orgLabel - Your organization label. Only needed when `serviceUrl` points at the
    #              shared `app.ardoq.com` host and you want to skip the automatic lookup
    #              (which calls `getMe()` once, at initialization, to resolve it)
    # + return - An error if connector initialization failed
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://app.ardoq.com/api/v2",
            string? orgLabel = ()) returns error? {
        Client baseClient = check new (config, serviceUrl);
        string? resolvedOrgLabel = orgLabel;
        if resolvedOrgLabel is () && requiresOrgLabel(serviceUrl) {
            UserInfo userInfo = check baseClient->getMe();
            string? label = userInfo.org?.label;
            if label is () {
                return error("Unable to automatically resolve the organization label from /me. " +
                    "Please provide the 'orgLabel' parameter explicitly.");
            }
            resolvedOrgLabel = label;
        }
        self.baseClient = baseClient;
        self.orgLabel = resolvedOrgLabel.cloneReadOnly();
    }

    private isolated function withOrgHeader(map<string|string[]> headers) returns map<string|string[]> {
        string? label = self.orgLabel;
        if label is string {
            map<string|string[]> merged = headers.clone();
            merged["X-org"] = label;
            return merged;
        }
        return headers;
    }

    # Get current user and organization info
    #
    # + headers - Headers to be sent with the request
    # + return - The current user and their organization
    remote isolated function getMe(map<string|string[]> headers = {}) returns UserInfo|error {
        return self.baseClient->getMe(self.withOrgHeader(headers));
    }

    # List References
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - A paginated list of references matching the given filters
    remote isolated function listReferences(map<string|string[]> headers = {}, *ListReferencesQueries queries)
            returns PaginatedReferenceResponse|error {
        return self.baseClient->listReferences(self.withOrgHeader(headers), queries = queries);
    }

    # Create a Reference
    #
    # + payload - The payload to be sent with the request
    # + headers - Headers to be sent with the request
    # + return - The newly created reference
    remote isolated function createReference(CreateReferenceRequest payload, map<string|string[]> headers = {})
            returns Reference|error {
        return self.baseClient->createReference(payload, self.withOrgHeader(headers));
    }

    # List attachments
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - A paginated list of attachments matching the given filters
    remote isolated function listAttachments(map<string|string[]> headers = {}, *ListAttachmentsQueries queries)
            returns PaginatedAttachmentResponse|error {
        return self.baseClient->listAttachments(self.withOrgHeader(headers), queries = queries);
    }

    # Get a component
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - The requested component
    remote isolated function getComponent(string id, map<string|string[]> headers = {}) returns Component|error {
        return self.baseClient->getComponent(id, self.withOrgHeader(headers));
    }

    # Delete a component
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - The component was deleted successfully
    remote isolated function deleteComponent(string id, map<string|string[]> headers = {}) returns error? {
        return self.baseClient->deleteComponent(id, self.withOrgHeader(headers));
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
        return self.baseClient->updateComponent(id, payload, self.withOrgHeader(headers), queries = queries);
    }

    # List Workspaces
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - A paginated list of workspaces matching the given filters
    remote isolated function listWorkspaces(map<string|string[]> headers = {}, *ListWorkspacesQueries queries)
            returns PaginatedWorkspaceResponse|error {
        return self.baseClient->listWorkspaces(self.withOrgHeader(headers), queries = queries);
    }

    # Execute a batch request
    #
    # + payload - The payload to be sent with the request
    # + headers - Headers to be sent with the request
    # + return - The results of the create, update, upsert, and delete operations executed in the batch request
    remote isolated function executeBatch(BatchRequest payload, map<string|string[]> headers = {})
            returns BatchResponse|error {
        return self.baseClient->executeBatch(payload, self.withOrgHeader(headers));
    }

    # Get a reference
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - The requested reference
    remote isolated function getReference(string id, map<string|string[]> headers = {}) returns Reference|error {
        return self.baseClient->getReference(id, self.withOrgHeader(headers));
    }

    # Delete a reference
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - The reference was deleted successfully
    remote isolated function deleteReference(string id, map<string|string[]> headers = {}) returns error? {
        return self.baseClient->deleteReference(id, self.withOrgHeader(headers));
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
        return self.baseClient->updateReference(id, payload, self.withOrgHeader(headers), queries = queries);
    }

    # Report definition
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - The requested report definition
    remote isolated function getReport(string id, map<string|string[]> headers = {}) returns ReportOverview|error {
        return self.baseClient->getReport(id, self.withOrgHeader(headers));
    }

    # Get an attachment
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - The requested attachment
    remote isolated function getAttachment(string id, map<string|string[]> headers = {}) returns Attachment|error {
        return self.baseClient->getAttachment(id, self.withOrgHeader(headers));
    }

    # Expand Batch
    #
    # + payload - The payload to be sent with the request
    # + headers - Headers to be sent with the request
    # + return - The fully expanded batch request, with aliases resolved to their underlying identifiers
    remote isolated function expandBatch(BatchRequest payload, map<string|string[]> headers = {})
            returns BatchRequest|error {
        return self.baseClient->expandBatch(payload, self.withOrgHeader(headers));
    }

    # Run Report (Objects)
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - A paginated list of report result rows, keyed by column label or key
    remote isolated function runReportObjects(string id, map<string|string[]> headers = {},
            *RunReportObjectsQueries queries) returns PaginatedReportObjectResponse|error {
        return self.baseClient->runReportObjects(id, self.withOrgHeader(headers), queries = queries);
    }

    # Get a workspace
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - The requested workspace
    remote isolated function getWorkspace(string id, map<string|string[]> headers = {}) returns Workspace|error {
        return self.baseClient->getWorkspace(id, self.withOrgHeader(headers));
    }

    # List Report definitions
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - A paginated list of report definitions matching the given filters
    remote isolated function listReports(map<string|string[]> headers = {}, *ListReportsQueries queries)
            returns PaginatedReportResponse|error {
        return self.baseClient->listReports(self.withOrgHeader(headers), queries = queries);
    }

    # Workspace Context
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - The component and reference types defined by the workspace's model
    remote isolated function getWorkspaceContext(string id, map<string|string[]> headers = {})
            returns WorkspaceContext|error {
        return self.baseClient->getWorkspaceContext(id, self.withOrgHeader(headers));
    }

    # Run Report (Tabular)
    #
    # + id - An Ardoq identifier (OID)
    # + headers - Headers to be sent with the request
    # + return - A paginated list of report result rows in tabular (array) format
    remote isolated function runReportTabular(string id, map<string|string[]> headers = {})
            returns PaginatedReportTabularResponse|error {
        return self.baseClient->runReportTabular(id, self.withOrgHeader(headers));
    }

    # List Components
    #
    # + headers - Headers to be sent with the request
    # + queries - Queries to be sent with the request
    # + return - A paginated list of components matching the given filters
    remote isolated function listComponents(map<string|string[]> headers = {}, *ListComponentsQueries queries)
            returns PaginatedComponentResponse|error {
        return self.baseClient->listComponents(self.withOrgHeader(headers), queries = queries);
    }

    # Create a component
    #
    # + payload - The payload to be sent with the request
    # + headers - Headers to be sent with the request
    # + return - The newly created component
    remote isolated function createComponent(CreateComponentRequest payload, map<string|string[]> headers = {})
            returns Component|error {
        return self.baseClient->createComponent(payload, self.withOrgHeader(headers));
    }
}

isolated function requiresOrgLabel(string serviceUrl) returns boolean => serviceUrl.includes("://app.ardoq.com");

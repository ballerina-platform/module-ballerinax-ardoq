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

import ballerina/http;

listener http:Listener ep0 = new (9090);

final Metadata1 mockMeta = {
    createdByEmail: "jane.doe@example.com",
    lastUpdated: "2026-07-16T09:30:00.000Z",
    createdByName: "Jane Doe",
    createdBy: "5f8a1b2c3d4e5f6a7b8c9d0e",
    created: "2026-07-01T08:00:00.000Z",
    lastModifiedBy: "5f8a1b2c3d4e5f6a7b8c9d0e",
    lastModifiedByEmail: "jane.doe@example.com",
    lastModifiedByName: "Jane Doe"
};

final Component mockComponent = {
    customFields: {},
    rootWorkspace: "6f9b2c3d4e5f6a7b8c9d0e1f",
    meta: mockMeta,
    description: "A core banking service",
    'type: "Application",
    name: "Payment Service",
    typeId: "p1655e4d90a065713",
    id: "7a0c3d4e5f6a7b8c9d0e1f2a",
    version: 1,
    componentKey: "APP-42"
};

final Reference mockReference = {
    displayText: "depends on",
    customFields: {},
    targetWorkspace: "6f9b2c3d4e5f6a7b8c9d0e1f",
    rootWorkspace: "6f9b2c3d4e5f6a7b8c9d0e1f",
    meta: mockMeta,
    description: "Payment Service depends on Ledger Service",
    'source: "7a0c3d4e5f6a7b8c9d0e1f2a",
    id: "8b1d4e5f6a7b8c9d0e1f2a3b",
    'type: 2,
    version: 1,
    target: "9c2e5f6a7b8c9d0e1f2a3b4c"
};

final Workspace mockWorkspace = {
    startView: "blockDiagram",
    name: "Application Portfolio",
    meta: mockMeta,
    description: "Workspace holding the application portfolio",
    id: "6f9b2c3d4e5f6a7b8c9d0e1f",
    version: 3,
    views: ["blockDiagram", "componentTree"],
    workspaceKey: "APPPORT"
};

final Attachment mockAttachment = {
    filename: "architecture-diagram.png",
    folder: "diagrams",
    'resource: {resourceType: "workspace", resourceId: "6f9b2c3d4e5f6a7b8c9d0e1f"},
    meta: mockMeta,
    id: "1d3f6a7b8c9d0e1f2a3b4c5d",
    version: 1.0
};

final ReportOverview mockReport = {
    datasource: "advancedSearch",
    columns: [
        {label: "Application", 'key: "application"},
        {label: "Criticality", 'key: "criticality"}
    ],
    name: "Application Criticality Report",
    description: "Lists applications and their business criticality",
    meta: mockMeta,
    id: "2e4a7b8c9d0e1f2a3b4c5d6e",
    version: 2
};

service /api/v2 on ep0 {
    # Delete a component
    #
    # + id - An Ardoq identifier (OID)
    # + return - Success
    resource function delete components/[string id]() returns http:NoContent {
        return http:NO_CONTENT;
    }

    # Delete a reference
    #
    # + id - An Ardoq identifier (OID)
    # + return - Success
    resource function delete references/[string id]() returns http:NoContent {
        return http:NO_CONTENT;
    }

    # List attachments
    #
    # + filename - The filename of the attachment
    # + folder - The `id` of the folder that the attachment is in
    # + return - Success
    resource function get attachments(string? filename, string? folder) returns PaginatedAttachmentResponse {
        return {links: {}, values: [mockAttachment]};
    }

    # Get an attachment
    #
    # + id - An Ardoq identifier (OID)
    # + return - Success
    resource function get attachments/[string id]() returns Attachment {
        return mockAttachment;
    }

    # List Components
    #
    # + name - The name of the entity
    # + rootWorkspace - The ardoq identifier of the workspace that the component belongs to
    # + parent - The parent identifier of the component
    # + componentKey - Referred to as the 'Ardoq ID' in the App
    # + typeId - The type identifier of the component
    # + return - Success
    resource function get components(string? name, string? rootWorkspace, string? parent, string? componentKey, string? typeId) returns PaginatedComponentResponse {
        return {links: {}, values: [mockComponent]};
    }

    # Get a component
    #
    # + id - An Ardoq identifier (OID)
    # + return - Success
    resource function get components/[string id]() returns Component {
        return mockComponent;
    }

    # Get current user and organization info
    #
    # + return - Success
    resource function get me() returns UserInfo {
        return {
            org: {name: "acme", label: "ACME Corporation"},
            user: {email: "jane.doe@example.com"}
        };
    }

    # List References
    #
    # + displayText - Display label for your reference
    # + rootWorkspace - The ardoq identifier of the workspace that the reference/source belongs to
    # + 'source - The ardoq identifier of the source
    # + targetWorkspace - The ardoq identifier of the workspace that the target belongs to
    # + target - The ardoq identifier of the target
    # + 'type - The type identifier of the reference
    # + return - Success
    resource function get references(string? displayText, string? rootWorkspace, string? 'source, string? targetWorkspace, string? target, string? 'type) returns PaginatedReferenceResponse {
        return {links: {}, values: [mockReference]};
    }

    # Get a reference
    #
    # + id - An Ardoq identifier (OID)
    # + return - Success
    resource function get references/[string id]() returns Reference {
        return mockReference;
    }

    # List Report definitions
    #
    # + name - The name of the report
    # + return - Success
    resource function get reports(string? name) returns PaginatedReportResponse {
        return {links: {}, values: [mockReport]};
    }

    # Report definition
    #
    # + id - An Ardoq identifier (OID)
    # + return - Success
    resource function get reports/[string id]() returns ReportOverview {
        return mockReport;
    }

    # Run Report (Objects)
    #
    # + id - An Ardoq identifier (OID)
    # + keyFormat - This parameter is used to manage the format of the objects keys. The api will default to 'label'
    # + return - Success
    resource function get reports/[string id]/run/objects("label"|"key"? keyFormat) returns PaginatedReportObjectResponse {
        return {
            links: {},
            values: [{"application": "Payment Service", "criticality": "High"}],
            meta: {
                columns: [
                    {label: "Application", 'key: "application"},
                    {label: "Criticality", 'key: "criticality"}
                ],
                name: "Application Criticality Report"
            }
        };
    }

    # Run Report (Tabular)
    #
    # + id - An Ardoq identifier (OID)
    # + return - Success
    resource function get reports/[string id]/run/tabular() returns PaginatedReportTabularResponse {
        return {
            links: {},
            values: [["Payment Service", "High"], ["Ledger Service", "Medium"]],
            meta: {
                columns: [
                    {label: "Application", 'key: "application"},
                    {label: "Criticality", 'key: "criticality"}
                ],
                name: "Application Criticality Report"
            }
        };
    }

    # List Workspaces
    #
    # + name - The name of the entity
    # + componentModel - The ardoq identifier of the model that the workspace has
    # + return - Success
    resource function get workspaces(string? name, string? componentModel) returns PaginatedWorkspaceResponse {
        return {links: {}, values: [mockWorkspace]};
    }

    # Get a workspace
    #
    # + id - An Ardoq identifier (OID)
    # + return - Success
    resource function get workspaces/[string id]() returns Workspace {
        return mockWorkspace;
    }

    # Workspace Context
    #
    # + id - An Ardoq identifier (OID)
    # + return - Success
    resource function get workspaces/[string id]/context() returns WorkspaceContext {
        return {
            customFields: [
                {
                    apiKey: "criticality",
                    defaultValue: "Medium",
                    options: ["Low", "Medium", "High"],
                    description: "Business criticality of the component",
                    readOnly: false,
                    label: "Criticality",
                    'type: "List",
                    calculated: false
                }
            ],
            componentTypes: [
                {
                    image: (),
                    color: "#4a90d9",
                    shape: "box",
                    customFields: ["criticality"],
                    name: "Application",
                    icon: "cube",
                    typeId: "p1655e4d90a065713"
                }
            ],
            rootWorkspace: "6f9b2c3d4e5f6a7b8c9d0e1f",
            referenceTypes: [
                {
                    customFields: [],
                    name: "Depends On",
                    'type: 2
                }
            ],
            tags: [{name: "critical"}, {name: "legacy"}]
        };
    }

    # Update a component
    #
    # + ifVersionMatch - This parameter is used to manage concurrency control. The value **MUST** be either a positive integer, or the enum `latest`.
    # | Value | Meaning |
    # |--------|---------|
    # |<nobr>`<integer>`</nobr>| The update **MUST** fail if the `_version` field of the stored entity is not identical to the provided value. |\n|`latest`   | The update should use the current (latest) version of the stored entity. |
    # For more information about versioning and concurrency control please see the [API guide on Versioning](/api-guides/concepts/versioning/)
    # + id - An Ardoq identifier (OID)
    # + return - Success
    resource function patch components/[string id](string ifVersionMatch, @http:Payload UpdateComponentRequest payload) returns Component {
        return mockComponent;
    }

    # Update a Reference
    #
    # + ifVersionMatch - This parameter is used to manage concurrency control. The value **MUST** be either a positive integer, or the enum `latest`.
    # | Value | Meaning |
    # |--------|---------|
    # |<nobr>`<integer>`</nobr>| The update **MUST** fail if the `_version` field of the stored entity is not identical to the provided value. |\n|`latest`   | The update should use the current (latest) version of the stored entity. |
    # For more information about versioning and concurrency control please see the [API guide on Versioning](/api-guides/concepts/versioning/)
    # + id - An Ardoq identifier (OID)
    # + return - Success
    resource function patch references/[string id](string ifVersionMatch, @http:Payload UpdateReferenceRequest payload) returns Reference {
        return mockReference;
    }

    # Execute a batch request
    #
    # + return - Success
    resource function post batch(@http:Payload record {record {boolean respondWithEntities?;} options?; record {record {|record {record {|string...;|} customFields?; string rootWorkspace?; anydata name?; string componentKey?;}...;|} components?; record {|record {record {|string...;|} customFields?; string rootWorkspace?; string 'source?; string target?; int 'type?;}...;|} references?;} aliases?; record {record {string batchId?; record {string rootWorkspace; string? shape?; string? image?; string? parent?; anydata name; anydata typeId; string? color?; anydata? description?; record {} customFields?; string? icon?;} body;}[] create?; record {string[] uniqueBy; record {string rootWorkspace; string? shape?; string? image?; string? parent?; anydata name; anydata typeId; string? color?; anydata? description?; record {} customFields?; string? icon?;} body; string batchId?;}[] upsert?; record {string id; int|"latest" ifVersionMatch; record {record {} customFields?; anydata name?; anydata? description?; string? color?; string? shape?; string? icon?; string? image?; string? parent?;} body;}[] update?; record {string id?; record {record {|string...;|} customFields?; string rootWorkspace?; anydata name?; string componentKey?; anydata typeId?;} 'match?;}[] delete?;} components?; record {record {record {record {} customFields?; int 'type; string displayText?; anydata? description?; string 'source; string target;} body; string batchId?;}[] create?; record {string[] uniqueBy; record {record {} customFields?; int 'type; string displayText?; anydata? description?; string 'source; string target;} body; string batchId?;}[] upsert?; record {string id; int|"latest" ifVersionMatch; record {record {} customFields?; string displayText?; anydata? description?; string 'source?; string target?;} body;}[] update?; record {string id?; record {record {|string...;|} customFields?; string rootWorkspace?; string 'source?; string target?; int 'type?; string targetWorkspace?;} 'match?;}[] delete?;} references?;} payload) returns BatchResponse {
        return {
            components: {
                created: [{id: "7a0c3d4e5f6a7b8c9d0e1f2a", batchId: "comp-1"}],
                updated: [{id: "7a0c3d4e5f6a7b8c9d0e1f2a"}],
                deleted: [{id: "3f5b8c9d0e1f2a3b4c5d6e7f"}]
            },
            references: {
                created: [{id: "8b1d4e5f6a7b8c9d0e1f2a3b", batchId: "ref-1"}],
                updated: [{id: "8b1d4e5f6a7b8c9d0e1f2a3b"}],
                deleted: [{id: "4a6c9d0e1f2a3b4c5d6e7f8a"}]
            }
        };
    }

    # Expand Batch
    #
    # + return - Success
    resource function post batch/expand(@http:Payload record {record {boolean respondWithEntities?;} options?; record {record {|record {record {|string...;|} customFields?; string rootWorkspace?; anydata name?; string componentKey?;}...;|} components?; record {|record {record {|string...;|} customFields?; string rootWorkspace?; string 'source?; string target?; int 'type?;}...;|} references?;} aliases?; record {record {string batchId?; record {string rootWorkspace; string? shape?; string? image?; string? parent?; anydata name; anydata typeId; string? color?; anydata? description?; record {} customFields?; string? icon?;} body;}[] create?; record {string[] uniqueBy; record {string rootWorkspace; string? shape?; string? image?; string? parent?; anydata name; anydata typeId; string? color?; anydata? description?; record {} customFields?; string? icon?;} body; string batchId?;}[] upsert?; record {string id; int|"latest" ifVersionMatch; record {record {} customFields?; anydata name?; anydata? description?; string? color?; string? shape?; string? icon?; string? image?; string? parent?;} body;}[] update?; record {string id?; record {record {|string...;|} customFields?; string rootWorkspace?; anydata name?; string componentKey?; anydata typeId?;} 'match?;}[] delete?;} components?; record {record {record {record {} customFields?; int 'type; string displayText?; anydata? description?; string 'source; string target;} body; string batchId?;}[] create?; record {string[] uniqueBy; record {record {} customFields?; int 'type; string displayText?; anydata? description?; string 'source; string target;} body; string batchId?;}[] upsert?; record {string id; int|"latest" ifVersionMatch; record {record {} customFields?; string displayText?; anydata? description?; string 'source?; string target?;} body;}[] update?; record {string id?; record {record {|string...;|} customFields?; string rootWorkspace?; string 'source?; string target?; int 'type?; string targetWorkspace?;} 'match?;}[] delete?;} references?;} payload) returns BatchRequest {
        return {
            components: {
                create: [
                    {
                        batchId: "comp-1",
                        body: {
                            rootWorkspace: "6f9b2c3d4e5f6a7b8c9d0e1f",
                            name: "Payment Service",
                            typeId: "p1655e4d90a065713"
                        }
                    }
                ]
            },
            options: {respondWithEntities: false}
        };
    }

    # Create a component
    #
    # + return - Success
    resource function post components(@http:Payload CreateComponentRequest payload) returns Component {
        return mockComponent;
    }

    # Create a Reference
    #
    # + return - Success
    resource function post references(@http:Payload CreateReferenceRequest payload) returns Reference {
        return mockReference;
    }
}

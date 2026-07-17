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

import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://app.ardoq.com/api/v2" : "http://localhost:9090/api/v2";
final string token = isLiveServer ? os:getEnv("ARDOQ_TOKEN") : "test_token";
final map<string|string[]> & readonly authHeaders = {"Authorization": "Bearer " + token};

final string componentId = "7a0c3d4e5f6a7b8c9d0e1f2a";
final string referenceId = "8b1d4e5f6a7b8c9d0e1f2a3b";
final string workspaceId = "6f9b2c3d4e5f6a7b8c9d0e1f";
final string attachmentId = "1d3f6a7b8c9d0e1f2a3b4c5d";
final string reportId = "2e4a7b8c9d0e1f2a3b4c5d6e";

final Client ardoq = check new (serviceUrl = serviceUrl);

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetMe() returns error? {
    UserInfo response = check ardoq->getMe(authHeaders);
    test:assertTrue(response?.user !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testListReferences() returns error? {
    PaginatedReferenceResponse response = check ardoq->listReferences(authHeaders);
    test:assertTrue(response.values.length() > 0);
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testCreateReference() returns error? {
    CreateReferenceRequest payload = {
        displayText: "depends on",
        'source: componentId,
        'type: 2,
        target: "9c2e5f6a7b8c9d0e1f2a3b4c"
    };
    Reference response = check ardoq->createReference(payload, authHeaders);
    test:assertTrue(response.id != "");
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testGetReference() returns error? {
    Reference response = check ardoq->getReference(referenceId, authHeaders);
    test:assertEquals(response.id, referenceId);
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testUpdateReference() returns error? {
    UpdateReferenceRequest payload = {displayText: "depends on"};
    Reference response = check ardoq->updateReference(referenceId, payload, authHeaders, ifVersionMatch = "latest");
    test:assertEquals(response.id, referenceId);
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testDeleteReference() returns error? {
    error? response = ardoq->deleteReference(referenceId, authHeaders);
    test:assertTrue(response is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testListAttachments() returns error? {
    PaginatedAttachmentResponse response = check ardoq->listAttachments(authHeaders);
    test:assertTrue(response.values.length() > 0);
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testGetAttachment() returns error? {
    Attachment response = check ardoq->getAttachment(attachmentId, authHeaders);
    test:assertEquals(response.id, attachmentId);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testListComponents() returns error? {
    PaginatedComponentResponse response = check ardoq->listComponents(authHeaders);
    test:assertTrue(response.values.length() > 0);
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testCreateComponent() returns error? {
    CreateComponentRequest payload = {
        name: "Payment Service",
        rootWorkspace: workspaceId,
        typeId: "p1655e4d90a065713"
    };
    Component response = check ardoq->createComponent(payload, authHeaders);
    test:assertTrue(response.id != "");
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testGetComponent() returns error? {
    Component response = check ardoq->getComponent(componentId, authHeaders);
    test:assertEquals(response.id, componentId);
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testUpdateComponent() returns error? {
    UpdateComponentRequest payload = {name: "Payment Service v2"};
    Component response = check ardoq->updateComponent(componentId, payload, authHeaders, ifVersionMatch = "latest");
    test:assertEquals(response.id, componentId);
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testDeleteComponent() returns error? {
    error? response = ardoq->deleteComponent(componentId, authHeaders);
    test:assertTrue(response is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testListWorkspaces() returns error? {
    PaginatedWorkspaceResponse response = check ardoq->listWorkspaces(authHeaders);
    test:assertTrue(response.values.length() > 0);
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testGetWorkspace() returns error? {
    Workspace response = check ardoq->getWorkspace(workspaceId, authHeaders);
    test:assertEquals(response.id, workspaceId);
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testGetWorkspaceContext() returns error? {
    WorkspaceContext response = check ardoq->getWorkspaceContext(workspaceId, authHeaders);
    test:assertEquals(response.rootWorkspace, workspaceId);
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testExecuteBatch() returns error? {
    BatchResponse response = check ardoq->executeBatch({
        components: {
            create: [
                {
                    batchId: "comp-1",
                    body: {
                        rootWorkspace: workspaceId,
                        name: "Payment Service",
                        typeId: "p1655e4d90a065713"
                    }
                }
            ]
        }
    }, authHeaders);
    test:assertTrue(response?.components !is ());
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testExpandBatch() returns error? {
    BatchRequest response = check ardoq->expandBatch({
        components: {
            create: [
                {
                    batchId: "comp-1",
                    body: {
                        rootWorkspace: workspaceId,
                        name: "Payment Service",
                        typeId: "p1655e4d90a065713"
                    }
                }
            ]
        }
    }, authHeaders);
    test:assertTrue(response?.components !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testListReports() returns error? {
    PaginatedReportResponse response = check ardoq->listReports(authHeaders);
    test:assertTrue(response.values.length() > 0);
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testGetReport() returns error? {
    ReportOverview response = check ardoq->getReport(reportId, authHeaders);
    test:assertEquals(response.id, reportId);
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testRunReportObjects() returns error? {
    PaginatedReportObjectResponse response = check ardoq->runReportObjects(reportId, authHeaders);
    test:assertTrue(response.values.length() > 0);
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testRunReportTabular() returns error? {
    PaginatedReportTabularResponse response = check ardoq->runReportTabular(reportId, authHeaders);
    test:assertTrue(response.values.length() > 0);
}

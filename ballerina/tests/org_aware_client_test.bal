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

import ballerina/test;

@test:Config {
    groups: ["mock_tests"]
}
isolated function testRequiresOrgLabelForSharedDomain() {
    test:assertTrue(requiresOrgLabel("https://app.ardoq.com/api/v2"));
    test:assertTrue(requiresOrgLabel("https://app.ardoq.com"));
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testRequiresOrgLabelForDedicatedOrLocalDomains() {
    test:assertFalse(requiresOrgLabel("https://wso2-sandbox.us.ardoq.com/api/v2"));
    test:assertFalse(requiresOrgLabel("https://myorg.ardoq.com/api/v2"));
    test:assertFalse(requiresOrgLabel(serviceUrl));
}

final OrgAwareClient orgAwareClient = check new ({auth: {token: token}}, serviceUrl = serviceUrl);

@test:Config {
    groups: ["mock_tests"]
}
isolated function testOrgAwareClientOnDedicatedDomain() returns error? {
    // On a dedicated/local domain no org label lookup is needed, so this must
    // succeed without requiring the mock service to expose a working `/me`
    // response tailored for that purpose.
    UserInfo response = check orgAwareClient->getMe();
    test:assertTrue(response?.user !is ());
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testOrgAwareClientForwardsQueryParameters() returns error? {
    PaginatedWorkspaceResponse response = check orgAwareClient->listWorkspaces(name = "Application Portfolio");
    test:assertTrue(response.values.length() > 0);
}

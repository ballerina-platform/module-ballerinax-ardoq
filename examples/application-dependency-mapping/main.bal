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

// This example models an application dependency in Ardoq: it finds a workspace
// by name, discovers the component and reference types defined by its model,
// creates two application components, and links them with a reference.

import ballerina/io;
import ballerinax/ardoq;

configurable string token = ?;
configurable string serviceUrl = "https://instance.ardoq.com/api/v2";
configurable string workspaceName = "Application Portfolio";

public function main() returns error? {
    ardoq:Client ardoqClient = check new ({auth: {token: token}}, serviceUrl = serviceUrl);

    // Step 1: Find the workspace to model in
    ardoq:PaginatedWorkspaceResponse workspaces = check ardoqClient->listWorkspaces(name = workspaceName);
    if workspaces.values.length() == 0 {
        return error(string `Workspace '${workspaceName}' was not found`);
    }
    ardoq:Workspace workspace = workspaces.values[0];
    io:println(string `Using workspace: ${workspace.name.toString()} (${workspace.id})`);

    // Step 2: Discover the component and reference types defined by the workspace model
    ardoq:WorkspaceContext context = check ardoqClient->getWorkspaceContext(workspace.id);
    if context.componentTypes.length() == 0 || context.referenceTypes.length() == 0 {
        return error("The workspace model defines no component or reference types");
    }
    anydata componentTypeId = context.componentTypes[0].typeId;
    int referenceTypeId = context.referenceTypes[0].'type;

    // Step 3: Create the two application components
    ardoq:Component paymentService = check ardoqClient->createComponent({
        name: "Payment Service",
        rootWorkspace: workspace.id,
        typeId: componentTypeId,
        description: "Handles customer payment processing"
    });
    io:println(string `Created component: ${paymentService.name.toString()} (${paymentService.id})`);

    ardoq:Component ledgerService = check ardoqClient->createComponent({
        name: "Ledger Service",
        rootWorkspace: workspace.id,
        typeId: componentTypeId,
        description: "Maintains the financial ledger"
    });
    io:println(string `Created component: ${ledgerService.name.toString()} (${ledgerService.id})`);

    // Step 4: Link them with a dependency reference
    ardoq:Reference dependency = check ardoqClient->createReference({
        displayText: "depends on",
        'source: paymentService.id,
        target: ledgerService.id,
        'type: referenceTypeId
    });
    io:println(string `Created reference: ${dependency.id} (${paymentService.name.toString()} -> ${ledgerService.name.toString()})`);
}

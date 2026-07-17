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

// This example exports the results of an Ardoq report: it finds a report by
// name, fetches its definition to show the configured columns, then runs the
// report and prints the results in tabular format.

import ballerina/io;
import ballerinax/ardoq;

configurable string token = ?;
configurable string serviceUrl = "https://app.ardoq.com/api/v2";
configurable string reportName = "Application Criticality Report";

public function main() returns error? {
    ardoq:Client ardoqClient = check new (serviceUrl = serviceUrl);
    map<string|string[]> headers = {"Authorization": "Bearer " + token};

    // Step 1: Find the report by name
    ardoq:PaginatedReportResponse reports = check ardoqClient->listReports(headers, name = reportName);
    if reports.values.length() == 0 {
        return error(string `Report '${reportName}' was not found`);
    }
    ardoq:ReportOverview report = reports.values[0];
    io:println("Found report: ", report.name, " (", report.id, ")");

    // Step 2: Fetch the report definition and show its columns
    ardoq:ReportOverview definition = check ardoqClient->getReport(report.id, headers);
    string[] columnLabels = from ardoq:Column column in definition.columns
        select column.label;
    io:println("Columns: ", string:'join(", ", ...columnLabels));

    // Step 3: Run the report and print each result row
    ardoq:PaginatedReportTabularResponse results = check ardoqClient->runReportTabular(report.id, headers);
    io:println("Rows: ", results.values.length());
    foreach anydata[] row in results.values {
        io:println(row);
    }
}

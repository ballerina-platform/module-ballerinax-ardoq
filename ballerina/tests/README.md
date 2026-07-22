# Tests

The test suite covers all 22 operations of the Ardoq connector: user identity (`getMe`), workspace operations (`listWorkspaces`, `getWorkspace`, `getWorkspaceContext`), component CRUD (`listComponents`, `createComponent`, `getComponent`, `updateComponent`, `deleteComponent`), reference CRUD (`listReferences`, `createReference`, `getReference`, `updateReference`, `deleteReference`), attachments (`listAttachments`, `getAttachment`), reports (`listReports`, `getReport`, `runReportObjects`, `runReportTabular`), and batch operations (`executeBatch`, `expandBatch`). Each test asserts on the identifiers and collection sizes returned by the mock service.

## Running Tests

```bash
bal test
```

The test suite uses a mock server (`tests/mock_service.bal`) that intercepts HTTP calls so no real credentials are required.

To run the tests against the live Ardoq API instead, set the following environment variables:

```bash
export IS_LIVE_SERVER=true
export ARDOQ_TOKEN=<your-ardoq-api-token>
bal test --groups live_tests
```

_Author_:  Dilan Perera \
_Created_: 2026/07/17 \
_Updated_: 2026/07/20 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Ardoq. 
The OpenAPI specification is obtained from [Ardoq Developer Portal](https://developer.ardoq.com/public-api/).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.


1. Change the `url` property of the servers object
- **Original**: `https://app.ardoq.com`
- **Updated**: `https://app.ardoq.com/api/v2`
- **Reason**: Common prefix added to base URL to simplify endpoint paths.
<!-- auto-generated -->

2. Update the API Paths
- **Original**: Paths included common prefix `/api/v2` in each endpoint.
- **Updated**: Common prefix removed from endpoints as it is now in the base URL.
- **Reason**: Simplifies API paths and avoids duplication.
<!-- auto-generated -->

3. Change `Attachment folder` to nullable
- **Original**: The `folder` field in `Attachment` was `not nullable`.
- **Updated**: The `folder` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

4. Change `ReportOverview name` to nullable
- **Original**: The `name` field in `ReportOverview` was `not nullable`.
- **Updated**: The `name` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

5. Change `ReportOverview description` to nullable
- **Original**: The `description` field in `ReportOverview` was `not nullable`.
- **Updated**: The `description` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

6. Change `Metadata name` to nullable
- **Original**: The `name` field in `Metadata` was `not nullable`.
- **Updated**: The `name` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

7. Change `Field description` to nullable
- **Original**: The `description` field in `Field` was `not nullable`.
- **Updated**: The `description` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

8. Change `Component image` to nullable
- **Original**: The `image` field in `Component` was `not nullable`.
- **Updated**: The `image` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

9. Change `Component parent` to nullable
- **Original**: The `parent` field in `Component` was `not nullable`.
- **Updated**: The `parent` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

10. Change `Component shape` to nullable
- **Original**: The `shape` field in `Component` was `not nullable`.
- **Updated**: The `shape` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

11. Change `Component color` to nullable
- **Original**: The `color` field in `Component` was `not nullable`.
- **Updated**: The `color` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

12. Change `Component icon` to nullable
- **Original**: The `icon` field in `Component` was `not nullable`.
- **Updated**: The `icon` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

13. Change `Component description` to nullable
- **Original**: The `description` field in `Component` was `not nullable`.
- **Updated**: The `description` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

14. Change `ComponentType image` to nullable
- **Original**: The `image` field in `ComponentType` was `not nullable`.
- **Updated**: The `image` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

15. Change `ComponentType color` to nullable
- **Original**: The `color` field in `ComponentType` was `not nullable`.
- **Updated**: The `color` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

16. Change `ComponentType shape` to nullable
- **Original**: The `shape` field in `ComponentType` was `not nullable`.
- **Updated**: The `shape` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

17. Change `ComponentType icon` to nullable
- **Original**: The `icon` field in `ComponentType` was `not nullable`.
- **Updated**: The `icon` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

18. Change `Reference displayText` to nullable
- **Original**: The `displayText` field in `Reference` was `not nullable`.
- **Updated**: The `displayText` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

19. Change `Reference description` to nullable
- **Original**: The `description` field in `Reference` was `not nullable`.
- **Updated**: The `description` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

20. Change `Workspace startView` to nullable
- **Original**: The `startView` field in `Workspace` was `not nullable`.
- **Updated**: The `startView` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

21. Change `Workspace description` to nullable
- **Original**: The `description` field in `Workspace` was `not nullable`.
- **Updated**: The `description` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

22. Change `Workspace views` to nullable
- **Original**: The `views` field in `Workspace` was `not nullable`.
- **Updated**: The `views` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

23. Change `CreateReferenceRequest description` to nullable
- **Original**: The `description` field in `CreateReferenceRequest` was `not nullable`.
- **Updated**: The `description` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

24. Change `UpdateComponentRequest image` to nullable
- **Original**: The `image` field in `UpdateComponentRequest` was `not nullable`.
- **Updated**: The `image` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

25. Change `UpdateComponentRequest parent` to nullable
- **Original**: The `parent` field in `UpdateComponentRequest` was `not nullable`.
- **Updated**: The `parent` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

26. Change `UpdateComponentRequest color` to nullable
- **Original**: The `color` field in `UpdateComponentRequest` was `not nullable`.
- **Updated**: The `color` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

27. Change `UpdateComponentRequest shape` to nullable
- **Original**: The `shape` field in `UpdateComponentRequest` was `not nullable`.
- **Updated**: The `shape` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

28. Change `UpdateComponentRequest icon` to nullable
- **Original**: The `icon` field in `UpdateComponentRequest` was `not nullable`.
- **Updated**: The `icon` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

29. Change `UpdateComponentRequest description` to nullable
- **Original**: The `description` field in `UpdateComponentRequest` was `not nullable`.
- **Updated**: The `description` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

30. Change `UpdateReferenceRequest description` to nullable
- **Original**: The `description` field in `UpdateReferenceRequest` was `not nullable`.
- **Updated**: The `description` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

31. Change `CreateComponentRequest image` to nullable
- **Original**: The `image` field in `CreateComponentRequest` was `not nullable`.
- **Updated**: The `image` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

32. Change `CreateComponentRequest parent` to nullable
- **Original**: The `parent` field in `CreateComponentRequest` was `not nullable`.
- **Updated**: The `parent` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

33. Change `CreateComponentRequest shape` to nullable
- **Original**: The `shape` field in `CreateComponentRequest` was `not nullable`.
- **Updated**: The `shape` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

34. Change `CreateComponentRequest color` to nullable
- **Original**: The `color` field in `CreateComponentRequest` was `not nullable`.
- **Updated**: The `color` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

35. Change `CreateComponentRequest icon` to nullable
- **Original**: The `icon` field in `CreateComponentRequest` was `not nullable`.
- **Updated**: The `icon` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

36. Change `CreateComponentRequest description` to nullable
- **Original**: The `description` field in `CreateComponentRequest` was `not nullable`.
- **Updated**: The `description` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

37. Change `ComponentDocument image` to nullable
- **Original**: The `image` field in `ComponentDocument` was `not nullable`.
- **Updated**: The `image` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

38. Change `ComponentDocument parent` to nullable
- **Original**: The `parent` field in `ComponentDocument` was `not nullable`.
- **Updated**: The `parent` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

39. Change `ComponentDocument shape` to nullable
- **Original**: The `shape` field in `ComponentDocument` was `not nullable`.
- **Updated**: The `shape` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

40. Change `ComponentDocument color` to nullable
- **Original**: The `color` field in `ComponentDocument` was `not nullable`.
- **Updated**: The `color` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

41. Change `ComponentDocument icon` to nullable
- **Original**: The `icon` field in `ComponentDocument` was `not nullable`.
- **Updated**: The `icon` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

42. Change `ComponentDocument description` to nullable
- **Original**: The `description` field in `ComponentDocument` was `not nullable`.
- **Updated**: The `description` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

43. Change `ReferenceDocument description` to nullable
- **Original**: The `description` field in `ReferenceDocument` was `not nullable`.
- **Updated**: The `description` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

44. Change `PartialReferenceDocument description` to nullable
- **Original**: The `description` field in `PartialReferenceDocument` was `not nullable`.
- **Updated**: The `description` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

45. Change `PartialComponentDocument image` to nullable
- **Original**: The `image` field in `PartialComponentDocument` was `not nullable`.
- **Updated**: The `image` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

46. Change `PartialComponentDocument parent` to nullable
- **Original**: The `parent` field in `PartialComponentDocument` was `not nullable`.
- **Updated**: The `parent` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

47. Change `PartialComponentDocument color` to nullable
- **Original**: The `color` field in `PartialComponentDocument` was `not nullable`.
- **Updated**: The `color` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

48. Change `PartialComponentDocument shape` to nullable
- **Original**: The `shape` field in `PartialComponentDocument` was `not nullable`.
- **Updated**: The `shape` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

49. Change `PartialComponentDocument icon` to nullable
- **Original**: The `icon` field in `PartialComponentDocument` was `not nullable`.
- **Updated**: The `icon` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

50. Change `PartialComponentDocument description` to nullable
- **Original**: The `description` field in `PartialComponentDocument` was `not nullable`.
- **Updated**: The `description` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

51. Add a `BearerAuth` security scheme
- **Original**: The specification did not declare any `securitySchemes`, so the generated client required callers to manually attach an `Authorization: Bearer <token>` header to every request.
- **Updated**: Added an HTTP bearer `securitySchemes.BearerAuth` and applied it globally via `security: [{"BearerAuth": []}]`.
- **Reason**: Lets the generated `ConnectionConfig` carry an `auth: http:BearerTokenConfig` field so the token is supplied once at client construction and attached automatically by the underlying `http:Client`.

52. Change `ReportOverview datasource` enum
- **Original**: `datasource` only allowed `"graphSearch"` and `"advancedSearch"`.
- **Updated**: Added `"advancedSearchPostgres"` as a third allowed value.
- **Reason**: The live API returns this value for reports backed by the Postgres-based advanced search engine, but the original specification omitted it, causing payload binding failures on `listReports`/`getReport`.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.json -o ballerina --mode client --license docs/license.txt --client-methods remote
```

Note: The license year is hardcoded to 2026, change if necessary.

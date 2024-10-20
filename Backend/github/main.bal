import ballerina/http;

// Create an HTTP service to listen on localhost
service / on new http:Listener(8080) {
    resource function get [string owner]/[string repo]() returns json|error {
        // GitHub API URL to fetch repository details
        string repoUrl = string `https://api.github.com/repos/${owner}/${repo}`;

        // Create a new HTTP client
        http:Client githubClient = check new (repoUrl);

        // Send a GET request to fetch the repository details
        http:Response response = check githubClient->get("");

        // Extract the JSON payload from the response
        json repoDetails = check response.getJsonPayload();

        // Return repository details as the response to the localhost request
        return repoDetails;
    }
}
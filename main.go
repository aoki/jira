package main

import (
    "fmt"
    "github.com/andygrunwald/go-jira"
)

var (
    Version  string
    Revision string
)

func main() {
  jiraClient, _ := jira.NewClient(nil, "https://jira.atlassian.com/")
  req, _ := jiraClient.NewRequest("GET", "/rest/api/2/project", nil)

  projects := new([]jira.Project)
  _, err := jiraClient.Do(req, projects)
  if err != nil {
      panic(err)
  }

  for _, project := range *projects {
      fmt.Printf("%s: %s\n", project.Key, project.Name)
  }

    // MESOS-3325: Running mesos-slave@0.23 in a container causes slave to be lost after a restart
    // Type: Bug
    // Priority: Critical
}

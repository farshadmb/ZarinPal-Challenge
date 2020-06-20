//
//  GitHubGraphQLFactory.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct GitHubGraphQLFactory {
    
    static func repositoriesQuery(last: Int, cursor: String?) -> IGraphQLQueryRequest {
        let beforeCursor = cursor != nil ? "\"\(cursor!)\"" : nil
        return """
        {
            viewer {
        repositories(last: \(last), before: \( beforeCursor ?? "null")) {
                    totalCount
                    edges {
                        node {
                            id
                            name
                            description
                            forkCount
                            stargazers {
                                totalCount
                            }
                            owner {
                                avatarUrl
                            }
                            primaryLanguage {
                                name
                                color
                            }
                        }
                    }
                    pageInfo {
                        endCursor
                        hasNextPage
                        hasPreviousPage
                    }
                }
            }
        }
        """
    }
    
    static func repositoryQuery(name: String) -> IGraphQLQueryRequest {
        return """
        {
          viewer {
            repository(name: "\(name)") {
              ... on Repository {
                id
                name
                description
                forkCount
                stargazers {
                  totalCount
                }
                owner {
                  avatarUrl
                }
                primaryLanguage {
                  name
                  color
                }
                pullRequests(last: 10) {
                  edges {
                    node {
                      number
                      title
                      bodyText
                      state
                      author {
                        login
                        avatarUrl
                        ... on User {
                          id
                          name
                          email
                        }
                      }
                    }
                  }
                }
                issues(last: 10) {
                  edges {
                    node {
                      number
                      title
                      bodyText
                      state
                      author {
                        login
                        avatarUrl
                        ... on User {
                          id
                          name
                          email
                        }
                      }
                    }
                  }
                }
                refs(first: 100, refPrefix: "refs/heads/") {
                  nodes {
                    name
                  }
                }
              }
            }
          }
        }
"""
    }
    
    static func profileQuery() -> IGraphQLQueryRequest {
        return """
        {
          viewer {
            id
            name
            email
            avatarUrl
            url
            twitterUsername
            bio
            company
            login
            websiteUrl
          }
        }
"""
    }
}

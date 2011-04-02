package org.nopalsoft.mercury.domain

/**
 * User: cesarreyes
 * Date: 30/11/10
 * Time: 21:29
 */
class IssueFilter {
   int id
   String status
   String priority
   String assignee
   String from
   Date createdFrom
   Date createdUntil
   String name
   String reporter
   GroupBy groupBy
}

enum GroupBy {
   Priority,
   Category,
   Type,
   Status,
   Assignee,
   Reporter
}

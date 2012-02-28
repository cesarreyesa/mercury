/*
 * Copyright 2006-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.nopalsoft.mercury.domain

/**
 * User: cesarreyes
 * Date: 18-feb-2007
 * Time: 23:15:15
 */

class Issue {

   String code

   String summary
   String description
   Status status
   Date date
   Date lastUpdated
   Date startDate
   Date dueDate
   Date dateResolved
   Project project
   IssueType issueType
   Resolution resolution
   Priority priority
   Milestone milestone
   Category category
   Issue parent
   Conversation conversation

   static hasMany = [attachments: IssueAttachment, watchers: User, childs: Issue]

//  Long estimate;

   //  Long timeSpent;
   //  Date lastWorkDate;

   User assignee
   User reporter

   static constraints = {
      code(maxSize: 15)
      summary(blank: false)
      description(nullable: true, maxSize: 4000)
      date(blank: false)
      startDate(nullable: true)
      dueDate(nullable: true)
      resolution(nullable: true)
      dateResolved(nullable: true)
      assignee(nullable: true)
      milestone(nullable: true)
      category(nullable: true)
      conversation(nullable: true)
   }

   static mapping = {
      id generator: 'increment'
      version false
      priority column: 'priority'
      date column: 'date_'
      dueDate column: 'end_date'
      watchers joinTable: [name: 'issue_watcher', key: 'issue_id', column: 'user_id']
   }
}

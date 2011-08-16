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
   Date dueDate
   Date dateResolved
   Project project
   IssueType issueType
   Resolution resolution
   Priority priority
   Milestone milestone
   Category category
   Issue parent

   static hasMany = [attachments: IssueAttachment, watchers: User, childs: Issue]

//  Long estimate;

   //  Long timeSpent;
   //  Date lastWorkDate;

   User assignee
   User reporter

   static constraints = {
      code(unique: true)
      summary(blank: false)
      description(nullable: true, maxSize: 4000)
      date(blank: false)
      dueDate(nullable: true)
      resolution(nullable: true)
      dateResolved(nullable: true)
      assignee(nullable: true)
      milestone(nullable: true)
      category(nullable: true)
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

//  @Column(name = "date_closed")
//  Date dateClosed;
//
//  @ManyToOne
//  @JoinColumn(name = "milestone_id", nullable = true)
//  Milestone milestone;
//
//  public Element toXml(String elementName) {
//    Element el = DocumentHelper.createElement(elementName);
//    el.addElement("id").addText(this.id.toString());
//    el.addElement("code").addText(this.code);
//    el.addElement("summary").addText(this.summary);
//    if (this.environment != null) el.addElement("environment").addText(this.environment);
//    if (this.description != null) el.addElement("description").addText(this.description);
//    el.addElement("date").addText(this.date.toString());
//    el.addElement("lastUpdated").addText(this.lastUpdated == null ? "" : this.lastUpdated.toString());
//    el.addElement("dueDate").addText(this.dueDate == null ? "" : this.dueDate.toString());
//    el.addElement("completedPercentage").addText(this.completedPercentage == null ? "" : this.completedPercentage.toString());
//    el.addElement("isArchived").addText(this.isArchived == null ? "" : this.isArchived.toString());
//    if (this.project != null) el.add(this.project.toXml("project"));
//    if (this.issueType != null) el.add(this.issueType.toXml("issueType"));
//    if (this.status != null) el.add(this.status.toXml("status"));
//    if (this.resolution != null) {
//      el.addElement("resolutionText").addText(this.resolution.getName());
//    } else {
//      el.addElement("resolutionText").addText("SIN RESOLVER");
//    }
////        if(this.project != null) el.add(this.project.toXml("project"));
//    if (this.priority != null) el.add(this.priority.toXml("priority"));
//    if (this.assignee != null) el.add(this.assignee.toXml("assignee"));
//    if (this.reporter != null) el.add(this.reporter.toXml("reporter"));
////        if(reporter != null){
////        	Element reporterEl = el.addElement("reportero");
////        	reporterEl.addElement("name").addText(this.reporter.getFullName());
////        }
//
//    return el;
//  }
//}

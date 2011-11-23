<%--
  User: cesarreyesa
  Date: 28-feb-2010
  Time: 21:20:05
--%>

<%@ page import="org.nopalsoft.mercury.domain.MessageComment; org.nopalsoft.mercury.domain.IssueComment" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Dashboard</title>
  <meta name="layout" content="main"/>
  <script type='text/javascript' src='http://www.google.com/jsapi'></script>
</head>
<body>
<content tag="navbar">
  <g:render template="/shared/menu" model="[selected:'main']"/>
</content>

<div class="row">
   <div class="span8">
      <h2 style="margin-bottom: 20px;">Actividad reciente</h2>

      <div class="activity-feed">
         <g:each in="${activities}" var="activity">
            <div class="activity" style="clear: both;">
               <g:if test="${activity instanceof IssueComment}">
                  <div>
                     <strong>${activity.user}</strong> <strong><g:message code="comment.issue.${activity.action}"/></strong>
                     la incidencia <g:link controller="issues" action="view" id="${activity.issue.code}">${activity.issue.code}</g:link>
                     hace <f:humanTime time="${activity.dateCreated}"/>
                  </div>
                  <div>
                     <div style="float: left;">
                        <img src="http://www.gravatar.com/avatar/${activity.user.email.encodeAsMD5()}?s=30" alt="gravatar">
                     </div>
                     <div style="float: left;color: #a0a0a0;padding-left: 10px;">
                        <g:if test="${activity.action == 'create'}">
                           <p>${activity.issue.summary}</p>
                        </g:if>
                        <g:if test="${activity.content}">
                           <p>${activity.content}</p>
                        </g:if>
                     </div>
                  </div>
               </g:if>
               <g:elseif test="${activity instanceof MessageComment}">
                  <div>
                     <strong>${activity.user}</strong> edit&oacute;
                     el mensaje <g:link controller="messages" action="view" id="${activity.message.id}">${activity.message.title}</g:link>
                     hace <f:humanTime time="${activity.dateCreated}"/>
                  </div>
                  <div>
                     <div style="float: left;">
                        <img src="http://www.gravatar.com/avatar/${activity.user.email.encodeAsMD5()}?s=30" alt="gravatar">
                     </div>
                     <div style="float: left;color: #a0a0a0;padding-left: 10px;">
                        %{--<g:if test="${activity.action == 'create'}">--}%
                           %{--<p>${activity.message.body}</p>--}%
                        %{--</g:if>--}%
                        %{--<g:if test="${activity.content}">--}%
                           %{--<p>${activity.content}</p>--}%
                        %{--</g:if>--}%
                     </div>
                  </div>
               </g:elseif>
               <g:else>
                  <div>
                     <strong>${activity.user}</strong> hace <f:humanTime time="${activity.dateCreated}"/>
                  </div>
                  <div>
                     <div style="float: left;">
                        <img src="http://www.gravatar.com/avatar/${activity.user.email.encodeAsMD5()}?s=30" alt="gravatar">
                     </div>
                     <div style="float: left;color: #a0a0a0;padding-left: 10px;">
                        <p>${activity.content}</p>
                     </div>
                  </div>
               </g:else>
            </div>
         </g:each>
      </div>
   </div>
   <div class="span8">
      <h2>Dashboard</h2>
      <table>
        <tr>
          <td><div id="issuesByStatusDiv"></div></td>
        </tr>
        <tr>
          <td><div id="issuesByPriorityDiv"></div></td>
        </tr>
        <tr>
          <td><div id="issuesByAssigneeDiv"></div></td>
        </tr>
        <tr>
          <td><div id="openIssuesByPriorityDiv"></div></td>
        </tr>
      </table>
   </div>
</div>

<script type="text/javascript">

  google.load('visualization', '1', {packages:['corechart']});
  google.setOnLoadCallback(drawVisualization);

  function drawVisualization() {
    // Create and populate the data table.
    var issuesByStatus = new google.visualization.DataTable();
    issuesByStatus.addColumn('string', 'Status');
    issuesByStatus.addColumn('number', 'Issues');
    issuesByStatus.addRows(${issuesByStatus.size()});
  <g:each in="${issuesByStatus}" var="summary" status="i">
    issuesByStatus.setValue(${i}, 0, '${summary["status"].name}');
    issuesByStatus.setValue(${i}, 1, ${summary["count"]});
  </g:each>

    new google.visualization.PieChart(document.getElementById('issuesByStatusDiv')).
        draw(issuesByStatus, {width: 450, height: 300, title:"Resumen del proyecto"});

    var issuesByPriority = new google.visualization.DataTable();
    issuesByPriority.addColumn('string', 'Priority');
    issuesByPriority.addColumn('number', 'Issues');
    issuesByPriority.addRows(${issuesByPriority.size()});

  <g:each in="${issuesByPriority}" var="summary" status="i">
    issuesByPriority.setValue(${i}, 0, '${summary["priority"].name}');
    issuesByPriority.setValue(${i}, 1, ${summary["count"]});
  </g:each>

    new google.visualization.PieChart(document.getElementById('issuesByPriorityDiv')).
        draw(issuesByPriority, {width: 450, height: 300, title:"Incidencias abiertas por prioridad"});

    var issuesByAssignee = new google.visualization.DataTable();
    issuesByAssignee.addColumn('string', 'Assignee');
    issuesByAssignee.addColumn('number', 'Issues');
    issuesByAssignee.addRows(${issuesByAssignee.size()});
  <g:each in="${issuesByAssignee}" var="summary" status="i">
    issuesByAssignee.setValue(${i}, 0, '${summary["assignee"].fullName}');
    issuesByAssignee.setValue(${i}, 1, ${summary["count"]});
  </g:each>
    new google.visualization.PieChart(document.getElementById('issuesByAssigneeDiv')).
        draw(issuesByAssignee, {width: 450, height: 300, title:"Incidencias abiertas por encargado"});

    var openIssuesByPriority = new google.visualization.DataTable();
    openIssuesByPriority.addColumn('string', 'Assignee');
    openIssuesByPriority.addColumn('number', 'Issues');
    openIssuesByPriority.addRows(${openIssuesByPriority.size()});
  <g:each in="${openIssuesByPriority}" var="summary" status="i">
    openIssuesByPriority.setValue(${i}, 0, '${summary["priority"].name}');
    openIssuesByPriority.setValue(${i}, 1, ${summary["count"]});
  </g:each>
    new google.visualization.PieChart(document.getElementById('openIssuesByPriorityDiv')).
        draw(openIssuesByPriority, {width: 450, height: 300, title:"Mis Pendientes por prioridad"});
  }


</script>

</body>
</html>


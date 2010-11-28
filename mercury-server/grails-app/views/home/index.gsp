<%--
  User: cesarreyesa
  Date: 28-feb-2010
  Time: 21:20:05
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
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

<div id="main" style="width:100%;">
  <div class="block" id="block-text">
    <div class="content">
      <h2 class="title">Dashboard</h2>
      <div class="inner">
        <table>
          <tr>
            <td><div id="issuesByStatusDiv"></div></td>
            <td><div id="issuesByPriorityDiv"></div></td>
          </tr>
          <tr>
            <td><div id="issuesByAssigneeDiv"></div></td>
            <td><div id="openIssuesByPriorityDiv"></div></td>
          </tr>
        </table>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">

  google.load('visualization', '1', {packages:['imagepiechart']});
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

    new google.visualization.ImagePieChart(document.getElementById('issuesByStatusDiv')).
        draw(issuesByStatus, {title:"Resumen del proyecto"});

    var issuesByPriority = new google.visualization.DataTable();
    issuesByPriority.addColumn('string', 'Priority');
    issuesByPriority.addColumn('number', 'Issues');
    issuesByPriority.addRows(${issuesByPriority.size()});

  <g:each in="${issuesByPriority}" var="summary" status="i">
    issuesByPriority.setValue(${i}, 0, '${summary["priority"].name}');
    issuesByPriority.setValue(${i}, 1, ${summary["count"]});
  </g:each>

    new google.visualization.ImagePieChart(document.getElementById('issuesByPriorityDiv')).
        draw(issuesByPriority, {title:"Incidencias abiertas por prioridad"});

    var issuesByAssignee = new google.visualization.DataTable();
    issuesByAssignee.addColumn('string', 'Assignee');
    issuesByAssignee.addColumn('number', 'Issues');
    issuesByAssignee.addRows(${issuesByAssignee.size()});
  <g:each in="${issuesByAssignee}" var="summary" status="i">
    issuesByAssignee.setValue(${i}, 0, '${summary["assignee"].fullName}');
    issuesByAssignee.setValue(${i}, 1, ${summary["count"]});
  </g:each>
    new google.visualization.ImagePieChart(document.getElementById('issuesByAssigneeDiv')).
        draw(issuesByAssignee, {title:"Incidencias abiertas por encargado"});

    var openIssuesByPriority = new google.visualization.DataTable();
    openIssuesByPriority.addColumn('string', 'Assignee');
    openIssuesByPriority.addColumn('number', 'Issues');
    openIssuesByPriority.addRows(${openIssuesByPriority.size()});
  <g:each in="${openIssuesByPriority}" var="summary" status="i">
    openIssuesByPriority.setValue(${i}, 0, '${summary["priority"].name}');
    openIssuesByPriority.setValue(${i}, 1, ${summary["count"]});
  </g:each>
    new google.visualization.ImagePieChart(document.getElementById('openIssuesByPriorityDiv')).
        draw(openIssuesByPriority, {title:"Mis Pendientes por prioridad"});
  }


</script>

</body>
</html>


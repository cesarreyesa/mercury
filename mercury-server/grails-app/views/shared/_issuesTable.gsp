<%--
  User: cesarreyes
  Date: 29/12/10
  Time: 21:20
--%>

<style type="text/css">
   .issueOptions {
      visibility:hidden;
      /*margin:.5em 0 .25em 0;*/
   }
   .issues tr:hover .issueOptions{
      visibility:visible;
   }
   .issues tr.sub td{
      font-size: 80%;
      padding-top: 3px;
      padding-bottom: 3px;
   }
</style>

<table class="zebra-striped issues" cellpadding="0" cellspacing="0">
  <tr>
    <g:if test="${includeCheckbox}">
      <th class="first">
        <g:checkBox name="selectAll" onclick="jQuery('[name=issue]').attr('checked', this.checked)"/>
      </th>
      <th>P</th>
    </g:if>
    <g:else>
      <th class="first">P</th>
    </g:else>
    <th>C&oacute;digo</th>
    <th>Resumen</th>
    <th>Reportador</th>
    <th>Creado</th>
    <th style="white-space:nowrap;">Asignado a</th>
    <th>A</th>
  </tr>
  <g:each in="${issues}" var="issue" status="i">
    <tr class="${(i % 2) == 0 ? 'odd' : 'even'} ${(extendedView || issue.childs.size() > 0) ? 'noborder' : ''}">
      <g:if test="${includeCheckbox}">
        <td><g:checkBox name="issue" value="${issue.id}" checked="false"/></td>
      </g:if>
      <td><img src="${resource(dir: 'images/icons', file: issue.priority.icon)}" alt="${issue.priority.name}"></td>
      <td style="white-space:nowrap;"><g:link controller="issues" action="view" id="${issue.code}">${issue.code}</g:link></td>
      <td>
         ${issue.childs.size() > 0 ? '&#9658;' : ''}
         <g:link controller="issues" action="view" id="${issue.code}">${issue.summary}</g:link>
         <span class="issueOptions" style="float: right;"><a href="#" class="addSubIssue" data-code="${issue.code}">add sub issue</a></span>
      </td>
      <td style="white-space:nowrap;">${issue.reporter.fullName}</td>
      <td style="white-space:nowrap;"><g:formatDate date="${issue.date}" format="d, MMM yyyy"/></td>
      <td style="white-space:nowrap;">${issue.assignee ? issue.assignee.fullName : '--'}</td>
      <td><g:if test="${issue.attachments}">[A]</g:if></td>
    </tr>
    <g:if test="${extendedView && issue.description}">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        <g:if test="${includeCheckbox}">
          <td>&nbsp;</td>
        </g:if>
        <td colspan="2">&nbsp;</td>
        <td colspan="4" style="font-size:80%;">
          ${issue.description}
        </td>
      </tr>
    </g:if>
     <g:each in="${issue.childs.findAll{ it.status?.code != 'closed' }}" var="child">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'} noborder sub">
           <g:if test="${includeCheckbox}">
              <td>&nbsp;</td>
           </g:if>
           <td>
              %{--<img src="${resource(dir: 'images/icons', file: child.priority.icon)}" alt="${child.priority.name}">--}%
              &nbsp;
           </td>
           <td style="white-space:nowrap;">
              %{--<g:link action="view" id="${child.code}">${child.code}</g:link>--}%
              &nbsp;
           </td>
           <td style="padding-left: 25px;">
              <g:link controller="issues" action="view" id="${child.code}">${child.code} - ${child.summary}</g:link>
              <span class="issueOptions" style="float: right;"><a href="#" class="addSubIssue" data-code="${child.code}">add sub issue</a></span>
           </td>
           <td colspan="4">&nbsp;</td>
        </tr>
     </g:each>
  </g:each>
</table>

<script type="text/javascript">
   $("#newIssueDialog").modal({ keyboard: true });

   $('.addSubIssue').click(function(e) {
      e.preventDefault();
      $("#newIssueDialog").html('<div style="padding: 30px;">Loading...</div>');
      $("#newIssueDialog").modal('show');
      $("#newIssueDialog").load('${createLink(controller:'issues', action:'newIssueWindow')}' + '?parent=' + $(this).data('code') + '&reload=true');
   });
</script>

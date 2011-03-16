<%--
  User: cesarreyes
  Date: 29/12/10
  Time: 21:20
--%>

<table class="table" cellpadding="0" cellspacing="0">
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
    <th>Codigo</th>
    <th>Resumen</th>
    <th>Reportador</th>
    <th>Creado</th>
    <th style="white-space:nowrap;">Asignado a</th>
    <th>A</th>
    <g:if test="${enableIssueSort}">
      <th>Ordenar</th>
    </g:if>
  </tr>
  <g:each in="${issues}" var="issue" status="i">
    <tr class="${(i % 2) == 0 ? 'odd' : 'even'} ${extendedView ? 'noborder' : ''}">
      <g:if test="${includeCheckbox}">
        <td><g:checkBox name="issue" value="${issue.id}" checked="false"/></td>
      </g:if>
      <td><img src="${resource(dir: 'images/icons', file: issue.priority.icon)}" alt="${issue.priority.name}"></td>
      <td style="white-space:nowrap;"><g:link action="view" id="${issue.code}">${issue.code}</g:link></td>
      <td><g:link controller="issues" action="view" id="${issue.code}">${issue.summary}</g:link></td>
      <td style="white-space:nowrap;">${issue.reporter.fullName}</td>
      <td style="white-space:nowrap;"><g:formatDate date="${issue.date}" format="d, MMM yyyy"/></td>
      <td style="white-space:nowrap;">${issue.assignee ? issue.assignee.fullName : '--'}</td>
      <td><g:if test="${issue.attachments}">[A]</g:if></td>
      <g:if test="${enableIssueSort}">
        <td>
          <g:if test="${i > 0}">
            <a href="#" onclick="$('#moveUpForm input[type=hidden]#issue').val(${issue.id});$('#moveUpForm').submit();return false;">▲</a>
          </g:if>
          <g:else>
            ▲
          </g:else>|
          <g:if test="${i < issues.size() - 1}">
            <a href="#" onclick="$('#moveDownForm input[type=hidden]#issue').val(${issue.id});$('#moveDownForm').submit();return false;">▼</a>
          </g:if>
          <g:else>
            ▼
          </g:else>
        </td>
      </g:if>
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
  </g:each>
</table>


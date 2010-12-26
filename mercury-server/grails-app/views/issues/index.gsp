<%--
  ~ Copyright 2006-2009 the original author or authors.
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~       http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  --%>

<html>
<head>
  <title>${currentFilter.name}</title>
  <meta name="layout" content="main"/>
  <style type="text/css">
  strong {
    font-weight: bold;
  }

  .issues thead td {
    border-bottom: 1px solid #666;
  }

  .issue td {
    margin: 0;
    padding: 3px;
    border-bottom: 1px solid #ccc;
  }

  .issue a, .issue a:visited {
    color: #084B96;
  }

  .paginator{
    padding-top:20px;
    padding-bottom:5px;
  }

  .paginator a.step{
    border:1px solid #ccc;
    padding: 2px 5px;
    margin:4px;
  }

  .paginator .currentStep{
    background-color:#ccc;
    color:#fff;
    padding: 2px 5px;
  }

  </style>
</head>
<body>

<content tag="navbar">
  <g:render template="/shared/menu" model="[selected:'issues']"/>
</content>

<div id="main">
  <div class="block" id="block-text">
    <div class="content">
      <h2 class="title">${currentFilter.name}</h2>
      <div class="inner">
        <div style="text-align:right;padding-bottom:0px;">
          Mostrando <strong>${totalIssues}</strong> incidencias,
          agrupado por: <a href="#" id="groupByAnchor"><strong>${currentFilter.groupBy}</strong></a>
        </div>
          <g:each in="${issueGroups}" var="entry">
            <h3>${entry.key.toString()}</h3>
            <table class="table" cellpadding="0" cellspacing="0">
              <tr>
                <th class="first">P</th>
                <th>Codigo</th>
                <th>Resumen</th>
                <th>Reportador</th>
                <th style="white-space:nowrap;">Asignado a</th>
                <th>A</th>
              </tr>
            <g:each in="${entry.value}" var="issue" status="i">
              <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                <td><img src="${resource(dir: 'images/icons', file: issue.priority.icon)}" alt="${issue.priority.name}"></td>
                <td style="white-space:nowrap;"><g:link action="view" id="${issue.code}">${issue.code}</g:link></td>
                <td><g:link action="view" id="${issue.code}">${issue.summary}</g:link></td>
                <td style="white-space:nowrap;">${issue.reporter.fullName}</td>
                <td style="white-space:nowrap;">${issue.assignee ? issue.assignee.fullName : '--'}</td>
                <td><g:if test="${issue.attachments}">[A]</g:if></td>
              </tr>
            </g:each>
            </table>
          </g:each>
        <div class="actions-bar wat-cf">
          <div class="pagination">
            <g:paginate next="Siguiente" prev="Atras" maxsteps="4" max="50" total="${totalIssues}" params="${[filter: currentFilter.id]}"/>
          </div>
        </div>

      </div>
    </div>
  </div>
</div>

<div id="sidebar">
  <div class="block">
    <h3>Filtros</h3>
    <ul class="navigation">
      <g:each in="${filters}" var="filter">
        <li class="${currentFilter?.id == filter.id ? 'active' : ''}">
          <g:link action="index" params="${[filter:filter.id]}">${filter.name}</g:link>
        </li>
      </g:each>
    </ul>
  </div>
</div>

<div id="groupByDialog" title="" style="display:none;">
  <g:form name="groupByForm" action="index" method="get">
    <g:select name="groupBy" from="['priority':'Prioridad', 'type':'Tipo', 'assignee':'Asignado a', 'reporter':'Reportador']" optionKey="key" optionValue="value"/>
  </g:form>
</div>

<script type="text/javascript">
  $(function(){
    $('#groupByAnchor').click(function(event){
      event.preventDefault();
      var position = $(this).position();
      $( "#groupByDialog").dialog({
        minHeight:0, position: [position.left, position.top + $(this).height()], resizable:false, dialogClass:'simple'
      });
    });
    $('#groupBy').change(function(){
      $('#groupByForm').submit();
    });
  });
</script>
</body>
</html>


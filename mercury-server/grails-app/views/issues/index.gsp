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
  <title>Incidencias</title>
  <meta name="layout" content="main"/>
  <style type="text/css">
  .issues {

  }

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

    .filters li{
      padding: 2px 4px;
    }
    .filters li.selected{
      background-color:#084B96;
    }
    .filters li.selected a, .filters li.selected a:visited{
      color:#fff;
    }
  </style>
</head>
<body>

<content tag="navbar">
  <g:render template="/shared/menu" model="[selected:'issues']"/>
</content>

<div style="float:left;width:200px;padding-right:10px;">
  <h2>Filtros</h2>

  <ul class="filters">
    <g:each in="${filters}" var="filter">
      <li class="${currentFilter?.id == filter.id ? 'selected' : ''}">
        <g:link action="index" params="${[filter:filter.id]}">${filter.name}</g:link>
      </li>
    </g:each>
  </ul>
</div>

<div>
  <table class="issues" cellpadding="0" cellspacing="0">
    <thead>
    <tr>
      <td colspan="4">
        Mostrando <strong>${totalIssues}</strong> incidencias
      </td>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>&nbsp;</td>
    </tr>
    <g:each in="${issues}" var="issue">
      <tr class="issue">
        <td><img src="${resource(dir: 'images/icons', file: issue.priority.icon)}" alt="${issue.priority.name}"></td>
        <td style="white-space:nowrap;"><g:link action="view" id="${issue.code}">${issue.code}</g:link></td>
        <td><g:link action="view" id="${issue.code}">${issue.summary}</g:link></td>
        <td>${issue.reporter.fullName}</td>
      </tr>
    </g:each>
    <tr>
      <td colspan="4" class="paginator">
        <g:paginate next="Siguiente" prev="Atras" maxsteps="4" max="20" total="${totalIssues}"/>
      </td>
    </tr>
    </tbody>
  </table>
</div>

</body>
</html>


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
</head>

<body>

<content tag="navbar">
   <g:render template="/shared/menu" model="[selected:'issues']"/>
</content>

<div class="row">
   <div id="filters" class="sidebar" style="display: none;position:absolute;border: 1px solid #1a1a1a;">
      <div class="block">
         <ul class="navigation">
            <g:each in="${filters}" var="filter">
               <li class="${currentFilter?.id == filter.id ? 'active' : ''}">
                  <g:link action="index" params="${[filter:filter.id, groupBy:params.groupBy]}">${filter.name}</g:link>
               </li>
            </g:each>
         </ul>
      </div>
   </div>

   <div class="content">
      <h2 class="title">
         <a id="currentFilter" href="#">${currentFilter.name} &#9660;</a>
      <span style="padding-right:20px;;float:right;font-size:x-small;font-weight:normal;">
         <g:if test="${params.boolean('extendedView')}">
            <g:link action="index" params="[extendedView:false]">Ocultar detalles</g:link></span>
         </g:if>
         <g:else>
            <g:link action="index" params="[extendedView:true]">Mostrar detalles</g:link></span>
         </g:else>
      </h2>

      <div class="inner">
         <div style="text-align:right;padding-bottom:0px;">
            Mostrando <strong>${totalIssues}</strong> incidencias,
         agrupado por: <a href="#" id="groupByAnchor"><strong><g:message
               code="issue.${currentFilter.groupBy.toString().toLowerCase()}"/></strong></a>
         </div>
         <g:each in="${issueGroups}" var="entry">
            <h3>${entry.key.toString()}</h3>
            <g:render template="/shared/issuesTable"
                      model="[issues:entry.value, extendedView:params.boolean('extendedView')]"/>
         </g:each>
         <div class="pagination">
            <f:paginate total="${totalIssues}" maxsteps="4" max="50" params="${[filter: currentFilter.id]}"/>
         </div>

      </div>
   </div>
</div>

<div id="groupByDialog" title="" style="display:none;">
   <g:form name="groupByForm" action="index" method="get">
      <g:hiddenField name="filter" value="${params.filter}"/>
      <g:select name="groupBy"
                from="['priority':'Prioridad', 'category':'Categoria', 'type':'Tipo', 'assignee':'Asignado a', 'reporter':'Reportador']"
                optionKey="key" optionValue="value"/>
   </g:form>
</div>

<script type="text/javascript">
   $(function() {
      $('#groupByAnchor').click(function(event) {
         event.preventDefault();
         var position = $(this).position();
         $("#groupByDialog").dialog({
            minHeight:0, position: [position.left, position.top + $(this).height()], resizable:false, dialogClass:'simple'
         });
      });
      $('#groupBy').change(function() {
         $('#groupByForm').submit();
      });

      $("#currentFilter").click(function(e) {
         e.preventDefault();
         if(!$('#filters').is(':visible')){
            var pos = $("#currentFilter").offset();
            var height = $("#currentFilter").height();
            //show the menu directly over the placeholder
            $("#filters").css({ "left": (pos.left) + "px", "top":(pos.top + height) + "px" });
            $("#filters").show();
         }
         else{
            $("#filters").hide();
         }
      });


   });
</script>
</body>
</html>


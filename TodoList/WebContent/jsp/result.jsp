<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<html>
<head>
    <title>All Tasks Summary</title>
    <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css">  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
  <script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  
</head>
<script type="text/javascript">
  	$(document).ready(function() {
  		$('#tasksTable').DataTable();
  	})
  </script>

<body>
<div class="container">
<h2>My Tasks Info</h2>
<button type="button" class="btn btn-default" value="View Current Tasks" onclick="loadAllTasks()">View Current Tasks</button>
<button type="button" class="btn btn-default" value="View Logged Tasks" onclick="loadLoggedTasks()">View Logged Tasks</button>
<button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal">Custom Search</button>
   <table class="display" id="tasksTable">
   	<thead>
   		<tr>
	   		<th>Selection</th>
	   		<th>Task Summary</th>
	   		<th>Priority</th>
	   		<th>Creation date</th>
	   		<th>Task Status</th>
	   		<th>Logged Status</th>
   		</tr>
   	</thead>
   	<tbody>
   <c:forEach var="o" items="${tasks}">
   <c:choose>
   			<c:when test="${o.getTaskStatus()==1}">
   			<c:set var="cssclass" value="info"></c:set>
   			</c:when>
   			<c:when test="${o.getTaskStatus()==2}">
   			<c:set var="cssclass" value="active"></c:set>
   			</c:when>
   			<c:when test="${o.getTaskStatus()==3}">
   			<c:set var="cssclass" value="success"></c:set>
   			</c:when>
   			<c:when test="${o.isLogged()==true}">
   			<c:set var="cssclass" value="info"></c:set>
   			</c:when>	   	
   	</c:choose>
   	<tr class="${cssclass}" >
   		<td><input type="radio" value="${o.getTaskId()}" id="radioButton" name="radioButtonName"/></td>
   		<td><a href="/TodoList/getTaskDetails?id=${o.getTaskId()}" data-toggle="modal" data-target="#taskDetail">${o.getTaskSummary()}</a></td>
   		<c:choose>
   			<c:when test="${o.getPriority()==1}">
   			<td style="background-color: #FB6E6E">Very Critical</td>
   			</c:when>
   			<c:when test="${o.getPriority()==2}">
   			<td style="background-color: #FB946E">Critical</td>
   			</c:when>
   			<c:when test="${o.getPriority()==3}">
   			<td>Valuable</td>
   			</c:when>
   			<c:when test="${o.getPriority()==4}">
   			<td class="success">Desirable</td>
   			</c:when>
   		</c:choose>
   		<td>${o.getDateOfCreation()}</td>
   		<c:choose>
   			<c:when test="${o.getTaskStatus()==1}">
   			<td>Created</td>
   			</c:when>
   			<c:when test="${o.getTaskStatus()==2}">
   			<td>In Progress</td>
   			</c:when>
   			<c:when test="${o.getTaskStatus()==3}">
   			<td>Completed</td>
   			</c:when>
   		</c:choose>
   		<c:choose>
   			<c:when test="${o.isLogged()==false}">
   			<td>Current</td>
   			</c:when>
   			<c:when test="${o.isLogged()==true}">
   			<td>Logged</td>
   			</c:when>   			
   		</c:choose>
   	</tr>
    </c:forEach>
    </tbody>
    </table>
    
    <button type="button" class="btn btn-default" value="Delete Tasks" onclick="deleteTask()">Delete Tasks</button>
    <button type="button" class="btn btn-default" value="Mark as In-Progress" onclick="inProgressTask()">Mark as In-Progress</button>
    <button type="button" class="btn btn-default" value="Mark as Complete" data-toggle="modal" data-target="#completeTask">Mark as Complete</button>
    <button type="button" class="btn btn-default" value="Move the task to log" onclick="moveTaskToLog()" >Move the task to log</button>
   </div>
   
   <div class="modal fade" id="myModal" role="dialog" >
	<div class="modal-dialog" >
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Narrow Your Search</h4>
			</div>
			<div class="modal-body">
				<form role="form">
					<div class="form-group">
    					<label for="email">From Date:</label>
					    <input type="text" class="form-control" id="fromDate" placeholder="dd/MM/yyyy"/>
					</div>
					<div class="form-group">
						<label for="toDate">To Date:</label>
					    <input type="text" class="form-control" id="toDate" placeholder="dd/MM/yyyy"/>
					</div>
					<div class="form-group">
					  <label for="email">Task Priority:</label>
					    <select class="form-control" id="queryPriority" >      
					    	<option value="1">Very Critical</option>
					    	<option value="2">Critical</option>
					    	<option value="3">Valuable</option>
					    	<option value="4">Desirable</option>      	
					    </select>
					</div>					
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal" onclick="getQueriedTasks()">Query</button>
        	</div>
		</div>
	</div>
	</div>
	
	<div class="modal fade" id="completeTask" role="dialog" >
	<div class="modal-dialog" >
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Mark the task as Complete</h4>
			</div>
			<div class="modal-body">
				<form role="form">
					<div class="form-group">
    					<label for="comments">Comments:</label>
					    <textarea class="form-control" id="comments" rows="5" placeholder="Enter the comments here"></textarea>
					</div>					
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal" onclick="completeTask()">Mark as Complete</button>
        	</div>
		</div>
	</div>
	</div>
	
	<div id="taskDetail" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
            	     
            </div>
        </div>
    </div>
   
</body>
</html>
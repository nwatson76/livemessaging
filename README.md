# livemessaging
The following solution is a sample signalR messaging application. The frontend is hosted inside an ASP.Net MVC5 application using Razor views, Bootstrap and AngularJS for a modern and responsive experience. The signalR server is hosted on the OWIN pipeline and mock information is sent to the signalR server via windows service (configured as an ASP.Net signalR client). 

</br>
Windows Service - Microsoft.AspNet.SignalR.Client
</br>
MVC5 Razor Partial View - HTML markup + AngularJS controllers to display data in the grid plus data filtering
</br>
SQL Server - backplane for signalR where all messages are logged. Database script included.
</br>



<p align="center">
  <img src="https://github.com/nwatson76/livemessaging/blob/master/LiveMessage.png" />
</p>



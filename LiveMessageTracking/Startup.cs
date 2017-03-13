
using Owin;
using Microsoft.Owin;
using Microsoft.AspNet.SignalR;
[assembly: OwinStartup(typeof(LiveMessageTracking.Startup))]
namespace LiveMessageTracking
{
    public class Startup
    {
        /// <summary>
        /// Configure the OWIN pipeline to host singlarR
        /// </summary>
        /// <param name="app"></param>
        public void Configuration(IAppBuilder app)
        {
            //connection string to the SQL Server database used for backplaning signalR
            string sqlConnectionString = "Server=testserver;Database=LiveMessageTracking;Integrated Security=True;";

            //use SQL server as the backplane for signalR
            GlobalHost.DependencyResolver.UseSqlServer(sqlConnectionString);
            
            //map the signalR pipeline, e.g http://localhost:8081/signalr
            app.MapSignalR();
        }
    }
}

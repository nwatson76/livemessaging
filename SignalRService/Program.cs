using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNet.SignalR.Client;
using System.Threading;
using System.Security.Principal;
using System.Net;
using System.Configuration;

namespace SignalRService
{
    class Program
    {
        
        /// <summary>
        /// Create a singnalR hub connection that will be consumed by a web client 
        /// </summary>
        static HubConnection hubConnection = new HubConnection("http://localhost:8100/signalr", useDefaultUrl: false);
        

        /// <summary>
        /// Main thread of windows service to 
        /// </summary>
        /// <param name="args"></param>
        static void Main(string[] args)
        {
            try
            {
                //set credentials to execute signalR connection
                string userName = ConfigurationManager.AppSettings["UserName"];
                string password = ConfigurationManager.AppSettings["Password"];
                string domain = ConfigurationManager.AppSettings["Domain"];
                string source = ConfigurationManager.AppSettings["Source"];
                
                ICredentials credentials = new NetworkCredential(userName, password, domain);
                
                //apply credentials to run the signalR connection
                hubConnection.Credentials = credentials;
                
                string userID = WindowsIdentity.GetCurrent().Name; 
                Console.WriteLine(userID); 
                Thread.Sleep(2000);

                //create the signalR Hub
                IHubProxy alphaProxy = hubConnection.CreateHubProxy("CommunicationHub");
                
                //start the hub and wait for the hub to be started
                hubConnection.Start().Wait();

                //create an endless loop that will send signals to the signalR hub
                var good = true;
                var evil = false;
                var i = 0;
                while (good != evil)
                {
                    //send information to the hub
                    //dateTime, service Name, entry Source, status Message, extra Detail
                    alphaProxy.Invoke("Send", DateTime.Now.ToString(), "Test Service", source, "Message from Service" + i++.ToString(),"", false);
                    alphaProxy.Invoke("Send", DateTime.Now.ToString(), "ServiceA", source, "Message from Service" + i++.ToString(), "", false);
                    alphaProxy.Invoke("Send", DateTime.Now.ToString(), "ServiceB", source, "Message from Service" + i++.ToString(), "", false);
                    alphaProxy.Invoke("Send", DateTime.Now.ToString(), "ServiceC", source, "Error, can't contact host server " + i++.ToString(), "", true);
                    //sleep for approx. two seconds
                    Thread.Sleep(2000);
                }
                
                
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

    }
}

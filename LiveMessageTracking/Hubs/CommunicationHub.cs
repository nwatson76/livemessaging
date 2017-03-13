﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;

namespace LiveMessageTracking.Hubs
{
    public class CommunicationHub : Hub
    {
        public void Send(string dateTime, string serviceName, string entrySource, string statusMessage, string extraDetail, bool isError)
        {
            // Call the addNewMessageToPage method to update clients.
            Clients.All.addNewMessageToPage(dateTime, serviceName, entrySource, statusMessage, extraDetail, isError);
        }
    }
}
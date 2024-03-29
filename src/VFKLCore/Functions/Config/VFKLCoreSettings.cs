﻿using System;
using System.Collections.Generic;
using System.Text;

namespace VFKLCore.Functions.Config
{
    /// <summary>
    /// Required configuration for the system
    /// </summary>
    public class VFKLCoreSettings
    {
        /// <summary>
        /// Base URL for the Apps cluster for the Application Owner this system is set up for. Example for TTD in TT02.  https://ttd.apps.tt02.altinn.no
        /// </summary>
        public string AppsBaseUrl { get; set; }

        /// <summary>
        /// Base URL for the Platform cluster for the environment this ApplicationOwnerSystem is configured for Example: https://platform.tt02.altinn.no/
        /// </summary>
        public string PlatformBaseUrl { get; set; }

        /// <summary>
        /// Endpoint to blob storage
        /// </summary>
        public string BlobEndpoint { get; set; }

        /// <summary>
        /// Account name for Azure Storage Account
        /// </summary>
        public string AccountName { get; set; }

        /// <summary>
        /// The account key for the Azure Storage Account
        /// </summary>
        public string AccountKey { get; set; }

        /// <summary>
        /// The blob container to store incomming data
        /// </summary>
        public string StorageContainer { get; set; } = "inbound";

        /// <summary>
        /// The blob container where registered subscription info are stored
        /// </summary>
        public string RegisteredSubStorageContainer { get; set; } = "active-subscriptions";

        /// <summary>
        /// The base adress for Maskinporten in the environment where this Application Owner System is used Example: https://ver2.maskinporten.no
        /// </summary>
        public string MaskinportenBaseAddress { get; set; }

        /// <summary>
        /// The adress for Maskinporten in the environment where this Application Owner System is used Example: https://tt02.altinn.no/maskinporten-api/
        /// </summary>
        public string AltinnMaskinportenApiEndpoint { get; set; }

        /// <summary>
        /// The adress for Maskinporten in the environment where this Application Owner System is used Example: https://ver2.maskinporten.no/
        /// </summary>
        public string MaskinportenAudience { get; set; }

        /// <summary>
        /// The Application Owners Client ID 
        /// </summary>
        public string MaskinPortenClientId { get; set; }

        /// <summary>
        /// The connection string to database 
        /// </summary>
        public string DatabaseSecretId { get; set; }

        /// <summary>
        /// The connection string to database 
        /// </summary>
        public string DatabaseConnectionString { get; set; }

        /// <summary>
        /// Testmode. Only relevant for TTD and DIGDIR
        /// </summary>
        public bool TestMode { get; set; }

        /// <summary>
        /// Thumbprint for when running functions locally
        /// </summary>
        public string LocalCertThumbprint { get; set; }

        /// <summary>
        /// Datatype for xml feedback. If not set no feedback is generated
        /// </summary>
        public string XMLFeedbackDataType { get; set; } = string.Empty;

        /// <summary>
        /// Eventtype to generate xml feedback for
        /// </summary>
        public string XMLFeedbackEventType { get; set; } = string.Empty;

        /// <summary>
        /// Email account for sending invitations
        /// </summary>
        public string EmailAccount { get; set; }

        /// <summary>
        /// Email account name
        /// </summary>
        public string EmailAccountName { get; set; }

        /// <summary>
        /// Email url
        /// </summary>
        public string EmailUrl { get; set; }

        /// <summary>
        /// SendGrid ApiKey
        /// </summary>
        public string SendGridApiKey { get; set; }
    }
}
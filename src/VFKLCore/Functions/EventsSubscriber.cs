using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using VFKLCore.Functions.Services.Interface;

namespace VFKLCore.Functions
{
    /// <summary>
    /// Azure Function that confirmes that data for a given instance is downloaded
    /// </summary>
    public class EventsSubscriber
    {
        private readonly ISubscription _subscriptionService;

        private static ILogger _logger;

        /// <summary>
        /// Initializes a new instance of the <see cref="EventsFeedback"/> class.
        /// </summary>
        public EventsSubscriber(ISubscription subscriptionService, ILogger<EventsSubscriber> logger)
        {
            _subscriptionService = subscriptionService;
            _logger = logger;
        }

        /// <summary>
        /// Function method that register a new subscription when file is added to blob storage
        /// </summary>
        /// <returns>A <see cref="Task"/> representing the result of the asynchronous operationŒ.</returns>
        [Function("EventsSubscriber")]
        public async Task Run(
            [BlobTrigger("add-subscriptions/{name}.json", Connection = "VFKLCoreSettings:BlobEndpoint")] byte[] blob, // Use byte[] https://github.com/Azure/azure-functions-dotnet-worker/issues/398
            string name)
        {
            string blobContent = System.Text.Encoding.UTF8.GetString(blob);
            _logger.LogInformation($"C# Blob trigger function Processed blob Name: {name} Content: {blobContent}");
            try
            {
                Subscription subscription = JsonSerializer.Deserialize<Subscription>(blobContent);
                _logger.LogInformation($"Deserialized object as json: {subscription.ToJson()}");
                await _subscriptionService.RegisterSubscription(name, subscription);
            }
            catch (JsonException ex)
            {
                _logger.LogError(ex, "Failed to deserialize blob content");
            }
            catch (System.Exception ex)
            {
                _logger.LogError(ex, "Error while registering subscription");
            }
        }
    }
}
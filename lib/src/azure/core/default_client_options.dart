import 'client_options.dart';
import 'environment.dart';


class DefaultClientOptions extends ClientOptions
    {
        DefaultClientOptions(): base(null, null)
        {
            transport = HttpPipelineTransport.create();
            bool? disableTelemetry = environmentVariableToBool(Environment.getEnvironmentVariable("AZURE_TELEMETRY_DISABLED"));
            diagnostics.isTelemetryEnabled = disableTelemetry ?? true;
            bool? disableAzureTracing = environmentVariableToBool(Environment.getEnvironmentVariable("AZURE_TELEMETRY_DISABLED"));
            diagnostics.isDistributedTracingEnabled = disableAzureTracing ?? true;
        }

        static bool? environmentVariableToBool(String? value) {
          if (value == "true" || value == "1") {
            return true;
            }
          if (value == "false" || value == "0") {
            return false;
          }
        return null;
        }
    }
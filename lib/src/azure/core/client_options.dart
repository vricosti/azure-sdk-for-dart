import 'package:http/http.dart';
import 'exceptions.dart';
import 'diagnostics_options.dart';
import 'default_client_options.dart';
import 'retry_options.dart';

abstract class ClientOptions
    {
        final DiagnosticsOptions _diagnosticsOptions = DiagnosticsOptions(null);
        HttpPipelineTransport _transport;
        
        
        bool isCustomTransportSet = false;
        

        /// <summary>
        /// Gets the default set of <see cref="ClientOptions"/>. Changes to the <see cref="Default"/> options would be reflected
        /// in new instances of <see cref="ClientOptions"/> type created after changes to <see cref="Default"/> were made.
        /// </summary>
        static ClientOptions _defaultOptions = DefaultClientOptions();
        static ClientOptions get defaultOptions => _defaultOptions;
        

        // For testing
        static void resetDefaultOptions()
        {
            _defaultOptions = DefaultClientOptions();
        }

        
        ClientOptions({ClientOptions? clientOptions, DiagnosticsOptions? diagnostics})
        {
            if (clientOptions != null)
            {
                retry = RetryOptions(clientOptions.retry);
                diagnostics = diagnostics ?? DiagnosticsOptions(clientOptions.diagnostics);
                _transport = clientOptions.Transport;
                if (clientOptions.policies != null)
                {
                    Policies = clientOptions.Policies;
                }
            }
            else
            {
                // Implementation Note: this code must use the copy constructors on DiagnosticsOptions and RetryOptions specifying
                // null as the argument rather than calling their default constructors. Calling their default constructors would result
                // in a stack overflow as this constructor is called from a static initializer.
                _transport = getDefaultTransport();
                diagnostics = DiagnosticsOptions(null);
                retry = RetryOptions(null);
            }
        }

        /// <summary>
        /// The <see cref="HttpPipelineTransport"/> to be used for this client. Defaults to an instance of <see cref="HttpClientTransport"/>.
        /// </summary>
        HttpPipelineTransport transport
        {
            get => _transport;
            set
            {
                _transport = value ?? throw new ArgumentNullException(nameof(value));
                IsCustomTransportSet = true;
            }
        }

        /// <summary>
        /// Gets the client diagnostic options.
        /// </summary>
        DiagnosticsOptions get diagnostics => _diagnosticsOptions;

        

        /// <summary>
        /// Gets the client retry options.
        /// </summary>
        RetryOptions _retryOptions = RetryOptions(null);
        RetryOptions get retry { return _retryOptions; }
        set retry(RetryOptions value) { _retryOptions = value; }
        
        /// <summary>
        /// Adds an <see cref="HttpPipeline"/> policy into the client pipeline. The position of policy in the pipeline is controlled by <paramref name="position"/> parameter.
        /// If you want the policy to execute once per client request use <see cref="HttpPipelinePosition.PerCall"/> otherwise use <see cref="HttpPipelinePosition.PerRetry"/>
        /// to run the policy for every retry. Note that the same instance of <paramref name="policy"/> would be added to all pipelines of client constructed using this <see cref="ClientOptions"/> object.
        /// </summary>
        /// <param name="policy">The <see cref="HttpPipelinePolicy"/> instance to be added to the pipeline.</param>
        /// <param name="position">The position of policy in the pipeline.</param>
        void addPolicy(HttpPipelinePolicy policy, HttpPipelinePosition position)
        {
            if (position != HttpPipelinePosition.PerCall &&
                position != HttpPipelinePosition.PerRetry &&
                position != HttpPipelinePosition.BeforeTransport)
            {
                throw new ArgumentOutOfRangeException(nameof(position), position, null);
            }

            Policies ??= new();
            Policies.Add((position, policy));
        }

        List<(HttpPipelinePosition Position, HttpPipelinePolicy Policy)>? Policies { get; private set; }

        static HttpPipelineTransport _getDefaultTransport()
        {
            return HttpClientTransport.Shared;
        }
    }
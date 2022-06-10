class HttpMessage 
    {
        /// <summary>
        /// This dictionary is keyed with <c>Type</c> for a couple of reasons. Primarily, it allows values to be stored such that even if the accessor methods
        /// become public, storing values keyed by internal types make them inaccessible to other assemblies. This protects internal values from being overwritten
        /// by external code. See the <see cref="TelemetryDetails"/> and <see cref="UserAgentValueKey"/> types for an example of this usage.
        /// </summary>
        Map<String, Object>? _typeProperties;
        

        Response? _response;

        /// <summary>
        /// Creates a new instance of <see cref="HttpMessage"/>.
        /// </summary>
        /// <param name="request">The request.</param>
        /// <param name="responseClassifier">The response classifier.</param>
        public HttpMessage(Request request, ResponseClassifier responseClassifier)
        {
            Request = request;
            ResponseClassifier = responseClassifier;
            BufferResponse = true;
        }

        /// <summary>
        /// Gets the <see cref="Request"/> associated with this message.
        /// </summary>
        public Request Request { get; }

        /// <summary>
        /// Gets the <see cref="Response"/> associated with this message. Throws an exception if it wasn't set yet.
        /// To avoid the exception use <see cref="HasResponse"/> property to check.
        /// </summary>
        public Response Response
        {
            get
            {
                if (_response == null)
                {
                    throw InvalidOperationException("Response was not set, make sure SendAsync was called");
                }
                return _response;
            }
            set => _response = value;
        }

        /// <summary>
        /// Gets the value indicating if the response is set on this message.
        /// </summary>
        bool hasResponse => _response != null;

        /// <summary>
        /// The <see cref="System.Threading.CancellationToken"/> to be used during the <see cref="HttpMessage"/> processing.
        /// </summary>
        //CancellationToken cancellationToken { get; internal set; }

        /// <summary>
        /// The <see cref="ResponseClassifier"/> instance to use for response classification during pipeline invocation.
        /// </summary>
        ResponseClassifier responseClassifier;

        /// <summary>
        /// Gets or sets the value indicating if response would be buffered as part of the pipeline. Defaults to true.
        /// </summary>
        bool bufferResponse;

        /// <summary>
        /// Gets or sets the network timeout value for this message. If <c>null</c> the value provided in <see cref="RetryOptions.NetworkTimeout"/> would be used instead.
        /// Defaults to <c>null</c>.
        /// </summary>
        Duration? networkTimeout;

        void applyRequestContext(RequestContext? context, ResponseClassifier? classifier)
        {
            if (context == null)
            {
                return;
            }

            context.Freeze();

            if (context.Policies?.Count > 0)
            {
                Policies ??= new(context.Policies.Count);
                Policies.AddRange(context.Policies);
            }

            if (classifier != null)
            {
                ResponseClassifier = context.Apply(classifier);
            }
        }

        List<(HttpPipelinePosition Position, HttpPipelinePolicy Policy)>? policies;

        /// <summary>
        /// Gets a property that modifies the pipeline behavior. Please refer to individual policies documentation on what properties it supports.
        /// </summary>
        /// <param name="name">The property name.</param>
        /// <param name="value">The property value.</param>
        /// <returns><c>true</c> if property exists, otherwise. <c>false</c>.</returns>
        bool tryGetProperty(String name, out Object? value)
        {
            value = null;
            if (_typeProperties == null || !_typeProperties.TryGetValue(typeof(MessagePropertyKey), out var rawValue))
            {
                return false;
            }
            var properties = (Dictionary<string, object>)rawValue!;
            return properties.TryGetValue(name, out value);
        }

        /// <summary>
        /// Sets a property that modifies the pipeline behavior. Please refer to individual policies documentation on what properties it supports.
        /// </summary>
        /// <param name="name">The property name.</param>
        /// <param name="value">The property value.</param>
        void setProperty(String name, Object value)
        {
            _typeProperties ??= new Dictionary<Type, object>();
            Dictionary<string, object> properties;
            if (!_typeProperties.TryGetValue(typeof(MessagePropertyKey), out var rawValue))
            {
                properties = new Dictionary<string, object>();
                _typeProperties[typeof(MessagePropertyKey)] = properties;
            }
            else
            {
                properties = (Dictionary<string, object>)rawValue!;
            }
            properties[name] = value;
        }

        /// <summary>
        /// Gets a property that is stored with this <see cref="HttpMessage"/> instance and can be used for modifying pipeline behavior.
        /// </summary>
        /// <param name="type">The property type.</param>
        /// <param name="value">The property value.</param>
        /// <returns><c>true</c> if property exists, otherwise. <c>false</c>.</returns>
        bool tryGetInternalProperty(Type type, out object? value)
        {
            value = null;
            return _typeProperties?.TryGetValue(type, out value) == true;
        }

        /// <summary>
        /// Sets a property that is stored with this <see cref="HttpMessage"/> instance and can be used for modifying pipeline behavior.
        /// Internal properties can be keyed with internal types to prevent external code from overwriting these values.
        /// </summary>
        /// <param name="type">The key for the value.</param>
        /// <param name="value">The property value.</param>
        void setInternalProperty(Type type, object value)
        {
            _typeProperties ??= new Dictionary<Type, object>();
            _typeProperties[type] = value;
        }

        /// <summary>
        /// Returns the response content stream and releases it ownership to the caller. After calling this methods using <see cref="Azure.Response.ContentStream"/> or <see cref="Azure.Response.Content"/> would result in exception.
        /// </summary>
        /// <returns>The content stream or null if response didn't have any.</returns>
        public Stream? extractResponseContent()
        {
            switch (_response?.ContentStream)
            {
                case ResponseShouldNotBeUsedStream responseContent:
                    return responseContent.Original;
                case Stream stream:
                    _response.ContentStream = new ResponseShouldNotBeUsedStream(_response.ContentStream);
                    return stream;
                default:
                    return null;
            }
        }

        /// <summary>
        /// Disposes the request and response.
        /// </summary>
        // private class ResponseShouldNotBeUsedStream : Stream
        // {
        //     public Stream Original { get; }

        //     public ResponseShouldNotBeUsedStream(Stream original)
        //     {
        //         Original = original;
        //     }

        //     private static Exception CreateException()
        //     {
        //         return new InvalidOperationException("The operation has called ExtractResponseContent and will provide the stream as part of its response type.");
        //     }

        //     public override void Flush()
        //     {
        //         throw CreateException();
        //     }

        //     public override int Read(byte[] buffer, int offset, int count)
        //     {
        //         throw CreateException();
        //     }

        //     public override long Seek(long offset, SeekOrigin origin)
        //     {
        //         throw CreateException();
        //     }

        //     public override void SetLength(long value)
        //     {
        //         throw CreateException();
        //     }

        //     public override void Write(byte[] buffer, int offset, int count)
        //     {
        //         throw CreateException();
        //     }

        //     public override bool CanRead => throw CreateException();
        //     public override bool CanSeek => throw CreateException();
        //     public override bool CanWrite => throw CreateException();
        //     public override long Length => throw CreateException();

        //     public override long Position
        //     {
        //         get => throw CreateException();
        //         set => throw CreateException();
        //     }
        // }
    }
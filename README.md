# sprinkler

DoS prevention mechanisms designed for distributed systems:
* distributed agent threads working in an asynchronous or a realtime synchronous pattern
* master threads to gather ONLY important events of anomaly, potentially also provide some backtracing capability
* clusterwide thread id

The **agent threads**, at a remote location, will independently detect system anomalies and intervene while notifying master threads.
All threads (including master threads) work independently of each other, so that there will not be a single point of failure.

The anomaly detection is typically formulated as a *finite state machine* that tracks the operational activities of the system.
Then intervene as necessary based on the *anomaly state transitions* that occur in the local system.
A notification may be send to master threads through an encrypted channel, possibly containing identifying information to facilitate backtracing.
Therefore, a proper communication over TLS is enforced.

> Note: to make distribution of configuration and certificates easier, most information is baked into the binary executable at compilation, private key encrypted, which is to be done on a master node (that has all the configs, certs, keys and toolchain ready).

The **master threads**, gathered at a single reachable networking endpoint, may participate in DoS prevention from a control plane angle or only record system anomalies.
They do not have control over agent threads or send anything back (which otherwise may open up more security loopholes).

> Note: to simplify firewall configurations, only the master node listens

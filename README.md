# sprinkler

DoS prevention mechanisms, which are consisted of distributed agent threads monitored by master threads, identifiable by a systemwide id.

The agent threads, at a remote location, will independently detect system anomalies and intervene while notifying master threads,
so that there will not be a single point of failure.

The master threads, gathered at a single reachable networking endpoint, may participate in DoS prevention from a control plane angle or only record system anomalies.

The systemwide configuration is done by replicating the same config file and executable.

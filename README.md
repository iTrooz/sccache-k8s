# sccache-deploy

Helm chart and Docker Compose setup for deploying a [sccache](https://github.com/mozilla/sccache) distributed compilation cluster.

# Ways of deploying
## Docker (local)

```bash
# 1. Edit tokens in scheduler/worker configs
vim docker/scheduler.conf docker/worker.conf

# 2. Start the cluster
docker compose -f docker/compose.yml up -d
```

Scheduler listens on `:7634`, worker on `:10501`.

## Kubernetes (Helm)

```bash
# 1. Create a values.local.yaml
cp values.example.yaml values.local.yaml

# 2. Label nodes that will run the compilation jobs
kubectl label node <worker-node> sccache_worker=true

# 3. Install the chart, adding values.local.yaml as an additional values file
helm upgrade --install sccache . -f values.local.yaml
```

The helm chart deploys:
- **Scheduler** (Deployment + Service) — orchestrates build distribution
- **Worker** (DaemonSet + Service) — runs on labeled nodes, executes builds in sandboxed environments via bubblewrap
- **Ingress** (optional) — for external client access to the scheduler

# Docs

- [Distributed Quickstart](https://github.com/mozilla/sccache/blob/main/docs/DistributedQuickstart.md)
- [Distributed architecture](https://github.com/mozilla/sccache/blob/main/docs/Distributed.md)

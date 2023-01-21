---
title: Push to deploy
layout: "base.njk"
eleventyNavigation:
  key: PushToDeploy
  title: Push to deploy
  parent: Servers
  order: 2
---

Don't want to click the deploy button each time you make a change?

You can easily enable **push to deploy** by generating a deploy webhook. This means you can automatically trigger a deploy each time you push to your default branch.

<div class="bg-blue-100 rounded-lg py-5 px-6 mb-4 text-base text-blue-700 mb-3" role="alert">
  If many commits are pushed in a short amount of time, deploy jobs will be queued and run in correct order. You can cancel deployments if you want to skip to the last one.
</div>

In your settings, you should see `Deployment webhook`, and the option to generate a deploy key for your server.

<img src="/images/deploy-hook-generate-button.webp">

After pressing the `Generate` key, you will see some output with a deploy link and a generated Github action:

<img src="/images/generated-deploy-hook.webp">

The provided deploy key URL can be used anywhere, but it's recommended to not expose the generated deploy key secret publicly.

## Github action

Push to deploy can easily achieved with Github actions.

### Store deploy hook secret on Github

To keep your webhook secret safe, we recommend storing it as a secret in your Github repo.

Go to `Settings` in your repository.

<img src="/images/github-deployhook-1.webp">

Then, select `Secrets and variables`

<img src="/images/github-deployhook-2.webp">

Select `Actions` in the sidebar menu, then hit the `New repository secret` button.

<img src="/images/github-deployhook-3.webp">

Set the `DEPLOY_HOOK_SECRET` to the generated webhook secret.

<img src="/images/github-deployhook-4.webp">

### Set Github action secret

With Github actions, you can make a simple **"deploy every time anyone pushes to a certain branch"**. We will use the `main` branch as default.

Create a folder inside your project repo to store Github actions:

```
mkdir -p .github/workflows
touch .github/workflows/trigger-deploy.yml
```

Inside the `.github/workflows/trigger-deploy.yml` file, insert the following:

```yaml
name: Auto deploy to Shipnix stage
run-name: ${{ github.actor }} auto deploying to Shipnix stage 🚀
on: [push]
jobs:
  Trigger-Deploy-Webhook:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - run: echo "Github Owner ID ${{ github.actor_id }} "
      - run: echo "Github commit hash ${{ github.sha }}"
      - run: echo "Github commit message ${{ github.event.head_commit.message }}"
      - run: curl --fail "https://shipnix.io/TriggerDeploy?serverId=YOUR_SERVER_ID&key=${{ secrets.WEBHOOK_SECRET_STAGE }}&commitHash=${{ github.sha }}&githubUserId=${{ github.actor_id }}"
```

After adding this, you can commit changes and push. After a few seconds, this should trigger a deploy.

# Docker-Compose Template
This is a simple docker-compose template, initially used for a Drupal setup, but you can actually use it in many other cases.
This template is meant to be used on a private server, not a shared hosting, and it also doesn't provide any horizontal scaling.

More details about this template are written on my blog article: 

Here's what you have to do if you're planning to use it.

1. Fork (or copy the contents of) this repo into your own private repo.
2. Get a server (I'm using Hetzner, I really like what they offer, here's [my referral link with 20 Euro sign-up credit](https://hetzner.cloud/?ref=Xt1tRLDLeR7n)).
3. Secure the server ssh connections (no root login, only .pub key based).
4. Clone your repo on the server.
5. Make sure you have Python3 as default python by running `sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1`
6. Install `pip`:
```bash
$ curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
$ sudo python get-pip.py --user
```
7. Install ansible - `sudo python -m pip install ansible` - installs it globally.
8. Install requirements - `ansible-galaxy install -r ansible/requirements.yml`
9. Make sure the .env file exists - (populate with your secrets)
10. Run playbook - `ansible-playbook ansible/main.yml`

## Before starting services
1. Make sure you have .env - copied (from sample) and configured;
2. Make sure you have access to the GitHub Packages (if you're using GitHub Actions or other CI/CD) - [follow this link](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry).
3. Make sure you have your folders (the ones you're planning to use for Volumes) and various secrets - created.

## Generating certificates

I usually do this like this (because I have a reverse NGINX proxy on the host):
- Certificates live on the host and host feeds unencrypted traffic to the docker container;
- I first launch and test things w/o using SSL.
- Once I'm happy, I generate the certificates and then I edit the host nginx configs to use SSL.

There's a dedicated docker-compose under **/certificates/** folder.

1. I followed this tutorial: https://www.nodinrogers.com/post/2022-03-10-certbot-cloudflare-docker/
2. On the server, create a folder ./certificates/cloudflare and in that folder create the credentials file.
3. As said in the tutorial - generate the token and paste it there.
4. Depending on your action - uncomment a given command and run `docker compose up`.
5. Once you're happy, edit (uncomment) host nginx configurations (and Drupal's settings configs as well).

## Install New Relic on the Host
I know, it goes against ansible but I don't have time to figure out how to do it properly.

1. Go to New Relic > Logs (you can pick Linux)
2. Run the command, something like: 

`curl -Ls https://download.newrelic.com/install/newrelic-cli/scripts/install.sh | bash && sudo NEW_RELIC_API_KEY=*** NEW_RELIC_ACCOUNT_ID=*** NEW_RELIC_REGION=EU /usr/local/bin/newrelic install`

3. Now under /etc/newrelic-infra/logging.d/ - you can copy the files you need.

## Troubleshooting

1. Make sure you run the ansible from the root of the project.
2. Make sure you have the .env file in place.
3. Make sure you have the domain name in place (or use `server_name _;` and delete /etc/nginx/sites-enabled/default).

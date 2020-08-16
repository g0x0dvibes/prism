# Prism

This a project to build C2 infrastructure for pentesting and collaborative CTF. It can:

- Build and deploy a pentesting box with a good collection of modern tools effortlessly on aws.
- Standup C2 infrastructure with minimal effort. Covenant, Empire/Starkiller and Metasploit are ready to go.
- Teams can remotely collaborate in a shared terminal environment. Catch reverse shells and allow multiple team members to interact with them at the same time.
- Automate activities that take time like firewall management, distributing and staging payloads, proxies/pivoting and backups.

### Installation

Clone the repository:

```
git clone https://github.com/g0x0dvibes/prism.git
```

Build the image:
```
chmod +x build.sh
./build.sh
```

There isn't a great way to automate passing the AMI and generating keys with Terraform right now. So go into the AWS console -> EC2 -> Keypairs, generate a keypair and call it c2.

Put the key file into keys/c2.pem and give it proper permissions
```
chmod 0600 keys/c2.pem
```

Then grab the ami:
```
cat current_ami.txt
```

Edit terraform/variables.tf and put the AMI id of your home ip. Then set execute permissions and run:

```
chmod +x deploy
./deploy
```

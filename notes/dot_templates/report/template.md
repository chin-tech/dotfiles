---
layout: post
title: "Penetration Test"
subtitle: "CPTS Exam Report"
author:
    name: Alexander Chin-Lenn
    affiliation: HTB Candidate
    email: alex@chin-tech.org
# date: 
# List Format
company_logo: ""
# company: Inlanefreight
toc: true
company_name: Inlanefreight
company_contacts:
    name: John Doe
    affiliation: CEO
    email: jDoe@inlanefreight.htb
customer_name: InlaneFreight

report_type: "P" # P [Network Pentest] | W [ Web Penetration  Test] | A [Application Penetration Test]
approach_type: "B" # 
initial_creds: "_creds_"

## Scope
scope_rules:
  - ""

scope_external_domains:
  - ""

scope_internal_domains:
  - ""


# List Format
ip_addresses: 
    - 10.10.11.69
    - 10.10.11.70
    - 10.10.11.71
    - 10.10.11.72
    - 10.10.11.73
---


# Statement of Confidentiality

The contents of this document have been developed by the Author of this paper. The Author considers this document to be proprietary and business confidential information. This information is to be used only in the performance of its intended use . This document may not be released to another vendor, business partner or contractor without prior written consent from the Author. Additionally, no portion of this document may be communicated, reproduced, copied, or distributed with prior consent of the Author.

The contents of this document do not constitute legal advice. The Author's offer of services that relate to compliance, litigation, or other legal interestes are not intended as legal counsel and should not be taken as such. The assessment detailed herin is against a fictional company for training and examination purposes, and the vulnerabilities in no way affect Hack The Box's external or internal infrastructure.

# Engagement Contacts

%company_contacts%


%assesor_contacts%

# Overview

This is a %report_type% document for %company_name%. It was conducted by the assesors referenced in the engagement contacts.


# Executive Summary

%company_name% ("%company_shortname%" herein) contracted %author% ("Assessor" herein) to perform a penetration test of %company_shortname%'s  externally facing network to identify unknown weaknesses, vulnerabilities, and misconfiguations. Testing was performed non-evasively, meaning no attempt was made to subvert detection from blue-team efforts. Testing was performed remotely from %authors% assessment labs. Each finding was documented and investigated to determine the exploitation and/or escalation potential. Assessor sought to demonstrate the full impact of every vulnerability, up to and including internal domain compromise. If the Assessor gained a foothold in the internal network, %company_shortname% allowed for further testing including lateral movement and horizontal/vertical privilege escalation to demonstrate the business impact of an internal network compromise.

## Approach

%approach_type%

## Scope

%company_shortname% has determined these to be in scope for the assessment:

%penetration_test_scope%


# Assessment Summary

The test was conducted from the perspective of an unauthenticated user on the internet. %company_shortname% only provided approved network ranges and domains but no other information such as how many websites they had, what systems they were running or any configuration information. The assesor was able to uncover numerous networks, external and internal as well as numerous vulnerabilities. Below is a discovery of the the domains followed by all of the respecitive findings on each domain separated by CVSS rating.

- External Networks
    - DOMAIN

- Internal Networks
    - DOMAIN


%findings_summary%


# Internal Network Compromise

During the period of the assessment the assesor was able to gain a foothold via the external network, perform multiple lateral movements and escalations in order to achieve full domain compromise of the internal network. 
The steps below will demonstrate the exact attack path to achieve this compromise and any other method found to aid in this compromise. This will not cover all findings, that is reserved for the detailed technical findings.
The intent is to demonstrate the danger of chained vulnerabilities and how even smaller risks can be dangerous in totality for an organization.

## Detailed walkthough

# Remediation Summary

All of the findings will have their own suggested fixes, however below are the highest priority fixes and suggestions split into three categories.

## Quick Fixes

## Medium-Term

## Long-Term

# Detailed Technical Findings

<!-- For the author: Start a line with CVSS X.X to provide the proper syntax highlighting for the document -->
This section contains detailed technical findings of the assessment ordered by domain followed by [Common Vulnerability Scoring System (CVSS 3.1) Rating](https://www.first.org/cvss/). The CVSS rating measures the _technical severity_ of a vulnerability -- including potential impact to confidentiality, integrity, and availability -- but it is _not_ the same as organizational risk. The rating is assumes a default environment, not your environment. Meaning, we can have a vulnerability that has a critical rating of 9.8 because it is web-server that is exploitable over the internet and doesn't need authentication and could allow for complete compromise of confidentiality, integrity and availability of the webapp. However, that could be an isolated system without exposure to any customer facing data. To mitigate this confusion, there will be notes included to draw your attention to particular findings that may pose signficant risk.

A note will appear like this.

>[!IMPORTANT]
> Relevant information here.

Below will be all of the findings by the finding, the CVSS Score, a high-level definition of the vulnerability for reference, and the specific example found during the assessment.

Utilize your `;finding` snippet

_______
INSERT_FINDINGS



# Appendix

## Severities

## Host & Service Discovery

## Subdomain Discovery

## Exploited Hosts

## Compromised Users

## Alterations / Host Cleanup

## Flags

## Tools Reference

This section provides links for any non-proprietary tools used, proprietary ones will be named if used. 
### Network Tools

  - [Nmap - Network Mapper](https://nmap.org/): A powerful network scanner used for host discovery, port scanning, and service version detection.
  - [Burp Suite Community Edition](https://portswigger.net/burp/communitydownload): An integrated platform for performing security testing of web applications.
  - [Feroxbuster](https://github.com/epi052/feroxbuster): A fast, recursive content discovery tool for web servers.
  - [FFUF - Fuzz Faster U Fool](https://github.com/ffuf/ffuf): A versatile web fuzzer for finding vulnerabilities like directories, files, and virtual hosts.
  - [Gowitness](https://github.com/sensepost/gowitness): A web screenshot utility for reconnaissance.
  - [SQLmap](https://sqlmap.org/): An automatic SQL injection and database takeover tool.
  - [Swaks - Swiss Army Knife for SMTP](http://www.jetmore.org/john/code/swaks/): A command-line tool for testing SMTP servers.
  - [Tcpdump](https://www.tcpdump.org/): A command-line packet analyzer.
  - [Wireshark](https://www.wireshark.org/): A popular network protocol analyzer.
  - [Wpscan](https://wpscan.com/): A vulnerability scanner for WordPress.
  - [Whois](https://linux.die.net/man/1/whois): A tool for querying domain and IP registration information.

-----

### General Exploitation

  - [Metasploit Framework](https://www.metasploit.com/): A world-class exploitation framework used for developing and executing exploit code.
  - [Hashcat](https://hashcat.net/hashcat/): A powerful password cracking tool.
  - [Hydra](https://github.com/vanhauser-thc/thc-hydra): A fast network logon cracker supporting numerous protocols.
  - [Cewl](https://github.com/digininja/CeWL): A custom wordlist generator by spidering a website.
  - [Exploit-DB](https://www.exploit-db.com/): A database of exploits and shellcode for various software.
  - [Impacket](https://github.com/fortra/impacket): A collection of Python classes for working with network protocols, often used in lateral movement.
  - [NetExec (nxc)](https://www.netexec.wiki/): A network service exploitation tool for a variety of protocols, focused on Active Directory.
  - [Responder](https://github.com/lgandx/Responder): A rogue server and spoofer tool for LLMNR, NBT-NS, and mDNS poisoning.

-----

### Network Pivoting & Tunneling

  - [Chisel](https://github.com/jpillora/chisel): A fast TCP/UDP tunnel over HTTP, useful for pivoting.
  - [Proxychains-NG](https://github.com/rofl0r/proxychains-ng): A tool for redirecting network traffic through a proxy chain.
  - [Socat](http://www.dest-unreach.org/socat/): A command-line utility for creating bidirectional data channels.

-----

### Reconnaissance & Information Gathering

  - [Gobuster](https://github.com/OJ/gobuster): A directory and file brute-forcer for web servers.
  - [Kerbrute](https://github.com/ropnop/kerbrute): A tool to quickly brute-force or enumerate valid Active Directory accounts from the command line.
  - [Smbclient](https://www.samba.org/samba/docs/current/man-html/smbclient.1.html): A client to access SMB/CIFS shares.

-----

### Remote Access & Lateral Movement

  - [PowerShell](https://github.com/PowerShell/PowerShell): A powerful scripting language and command-line shell used for post-exploitation on Windows systems.
  - [Evil-WinRM](https://github.com/Hackplayers/evil-winrm): A tool for remote management of Windows hosts via the Windows Remote Management protocol.
  - [FreeRDP](https://www.freerdp.com/): An RDP client for connecting to remote Windows systems.

-----

-- DEFINE YOUR ASSETS HERE --
-- This will allow you to have a single place to reference all created images and use them in findings/walthrough --

[image_reference_name]: ./image_path "Alt text"
[domain_description]: ./assets/domain/description.png "alt description"


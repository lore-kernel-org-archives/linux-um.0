Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEsb1-0006Cg-4L
 for linux-um@lists.infradead.org; Wed, 24 Feb 2021 11:44:48 +0000
Subject: Re: linux uml segfault
References: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
 <6d37b5aa-36f2-1fce-b70b-8faa0ff882e0@kot-begemot.co.uk>
 <c8bb257c-1542-12f5-89f1-5c1f14b8a70a@collabora.com>
 <db40449e-6916-56bf-377c-01b042b9c890@kot-begemot.co.uk>
 <529cd4e2f39efffb18125dffab3058aeec3351ce.camel@debian.org>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <573e256a-990b-ddf6-7965-367bb8b21229@kot-begemot.co.uk>
Date: Wed, 24 Feb 2021 11:44:39 +0000
MIME-Version: 1.0
In-Reply-To: <529cd4e2f39efffb18125dffab3058aeec3351ce.camel@debian.org>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: rrs@debian.org, Christopher Obbard <chris.obbard@collabora.com>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Cc: 983379@bugs.debian.org



On 23/02/2021 17:26, Ritesh Raj Sarraf wrote:
> Added the debian bug report in CC.
> 
> On Tue, 2021-02-23 at 17:19 +0000, Anton Ivanov wrote:
>>> The current Debian user-mode-linux package in unstable is based on
>>> the 5.10.5 stable source which includes the mentioned patch, but is
>>> still causing an error for some users.
>>
>> After updating the tree to 5.10.5 and applying all Debian patches
>> from the package, I cannot reproduce the bug.
>>
>> I am running it on 5.10, 5.2 and 4.19 hosts with the same parameters
>> without issues. Hosts are all up to date Debian 10.8 and so is the
>> UML userspace.
>>
> 
> Did you mean 5.10, 5.2 and 4.19 (UML) guests ?
> 
> We've seen this happen on Debian Testing and Unstable Host (of which
> the former would soon be the next stable i.e. Debian Bullseye).
> 
> In our tests, when running the same linux uml binary (5.10) on a Debian
> Stable Host, it is working fine.

I cannot reproduce it on a physical Bullseye host using the Debian user-mode-linux package compiled from source.

Environment - Bullseye minimal install and build deps. 6 cores/12 threads Ryzen

I cannot reproduce it using the upstream source and the patches from the user-mode-linux package

Environment - same as above.

I cannot reproduce it using the upstream source + patches and compiling on Buster using the following:

1. Bullseye physical host, minimal install, same hardware

2. Bullseye VM, minimal install, running with 4 vCPUs on the same host

3. Bullseye LXC container running on a Debian Buster host, minimal install, same hardware

In all cases it boots cleanly and there are no segfaults.

So, frankly, no idea what is causing it to crash - I have run most combinations of 5.10 on a 5.10, all work fine here.

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPm6C-0006ej-JZ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 10:40:24 -0700
Received: from carriage.microbus.com ([195.224.204.205])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPm6C-0002KH-2A for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 10:40:24 -0700
Message-ID: <40A8F902.8090001@microbus.com>
From: Robbie Dinn <robbie@microbus.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] 2.4.23(24?)-2 TT mode hangs on request_module
References: <Pine.LNX.4.44.0405171722530.17607-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0405171722530.17607-100000@filer.marasystems.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 17 May 2004 18:40:18 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Henrik Nordstrom wrote:

> I can very reliably reproduce the problem by
> 
> 1. Boot in single user mode (/proc mounted etc.., but no other disturbing 
> factors)
> 2. iptables -A INPUT -j REJECT
> 

I think I may have seen this too, although I didn't understand what
was going on at the time (still don't). I am a little unsure what
versions of software I was using, because I wasn't working very
systematically. It might have been:
  host: 2.6.6 + skas3 patch or 2.6.6-rc3-mm2 + ska3 patch
	+ recent CVS netfilter p-o-m

  uml: 2.6.6 + blaisorblades unofficial patches
	and/or uml patches from suse kernel
	+ recent CVS netfilter p-o-m

I am just a monkey applying patches here, I don't claim to actually
understand the code.

I could get the UML machine to start in single user mode, but
when starting in run level 2 or 3, it would hang (eating lots of cpu
cycles) while starting the firewall.

I assumed that the hang was due to me failing to recompile and install
a fresh version of iptables on UML machine, but I don't have any good
reason to back up that belief. Does that sound plausible?
(I was using iptables-1.2.9 built against an older UML kernel, and had
the 1.2.10 sources waiting to be used).

> The sequence of events here is:
> 
> 1. iptables modprobes the base modules (iptable_filter), then uploads the 
> new iptable which referes to the REJECT match.
> 
> 2. The kernel verifies the new iptable and triggers a request_module call
> for the ipt_REJECT module and here the kernel gets completely stuck..
> 
> If all required modules are loaded manually avoiding the call to
> request_module then there is no problem, but unfortunately this is not a
> very feasible workaround here..
> 

The UML binary that I was using had all the iptables stuff statically
linked. I wasn't using modules at all.

If by so minor miracle I do manage to assemble something that works or
I find some useful information, I will post a follow up of course.

HTH

Robbie Dinn


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

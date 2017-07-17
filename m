Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1dX0D0-0007q9-Mf
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jul 2017 07:12:46 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
	helo=www.kot-begemot.co.uk)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dX0Cz-0000U0-Mc
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jul 2017 07:12:46 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Mon, 17 Jul 2017 07:29:08 +0100
Message-Id: <20170717062911.26576-1-anton.ivanov@kot-begemot.co.uk>
Subject: [uml-devel] High Performance IRQ and Network Subsystems
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hi List,

The following is a set of patches which cleans up and finally
stabilizes the work I did a couple of years ago while at Cisco.

1. The IRQ handling improves significantly and now allows large
numbers of devices without incurring penalties to look up "who
spoke". IRQ is now edge driven - further decreasing the cost
of triggering and servicing and interrupt.

2. There are now true write IRQs.

3. I have used the IRQ work for a significant rewrite of the
network subsystem resulting in up to 4x larger throughput. In fact
for some use cases the throughput is higher than kvm with virtio.

4. The IRQ controller is a drop in replacement. 

5. I could not do the network drivers as a drop-in replacement.
Our existing parser was in the way so for the time being the new
devices initialize as vecX, not ethX. They also support GRE
and L2TPv3 transports in addition to tap and raw ethernet.

I have run this patch in this form for a few months now including
backporting it to OpenWRT as a virtual CPE load.

I have not been able to break it. IMHO it is stable and long overdue
as UML has been lagging behind performance-wise for a very long
time. 

Some details on the possible setups, speeds and feeds can be
found at: http://foswiki.kot-begemot.co.uk/Main/EatYourOwnDogFood

A.


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CITxR-0001oc-3g for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Oct 2004 08:25:29 -0700
Received: from nudl.linbit.com ([212.69.162.21] helo=mail.linbit.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CITxP-0002S7-Ot for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Oct 2004 08:25:29 -0700
Received: from minna.local (c-134-76-216.b.dial.de.ignite.net [62.134.76.216])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 07A5214320
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 15 Oct 2004 17:25:22 +0200 (CEST)
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
Subject: Re: [uml-devel] larger MTU _does_ work
Message-ID: <j5CdDyjc/VcEI6ceosXdw7k=lge@web.de>
References: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
	<xneXIovOv53ZtptO+AU2uyI=lge@web.de>
	<20041012001140.GB17340@wotan.suse.de>
	<200410120310.59432.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410120310.59432.blaisorblade_spam@yahoo.it>
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
Date: Fri, 15 Oct 2004 17:25:17 +0200
To: user-mode-linux-devel@lists.sourceforge.net

/ 2004-10-12 03:10:59 +0200
\ BlaisorBlade:
> > > btw,
> > > anyone wants to give me a hint how to tune it best?
> > > maybe how to up the mtu of the UML "nics"?
> >
> > Don't go over 4K because the VM doesn't like >order 0 allocations
> > very much. But in general bigger is better.
> 
> Sadly there is a problem: since we use TAP and emulate whole Ethernet frames, 
> the code does not allow to increase the MTU to > 1500 bytes. I think this 
> cannot be fixed currently, but if you think this is wrong, please let us now.
> 
> Obviously we could add another interface emulation with bigger MTU, but I've 
> no ideas about which ones to emulate.

now, if I
  config eth0=daemon,FE:FD:00:00:00:01,,/tmp/uml0.ctl
and then
  ifconfig eth0 mtu 8192, uml does not complain
  (but does not work, either).

and if I then patch uml_switch from uml_utilities_20040114 (which is
what I have here, did not check whether there is anything newer out there)

===================
diff -ru tools.orig/uml_router/port.c tools/uml_router/port.c
--- tools.orig/uml_router/port.c	2003-03-12 16:19:03.000000000 +0100
+++ tools/uml_router/port.c	2004-10-15 16:59:07.000000000 +0200
@@ -14,7 +14,7 @@
     unsigned char src[ETH_ALEN];
     unsigned char proto[2];
   } header;
-  unsigned char data[1500];
+  unsigned char data[9000];
 };
 
 struct port {
===================

it even works!

I guess with mcast or other non-daemon transport (not yet tried),
it will just work, too (maybe you need to adjust the mtu on the host).

for the first time I really get 65507 byte udp packages through uml <-> uml.
(not that it makes any sense to use udp with that large messages ...)
anything larger won't work anyways...


	Lars Ellenberg



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

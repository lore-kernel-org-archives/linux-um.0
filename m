Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GhCHx-00070j-2R for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Nov 2006 13:45:54 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GhCHt-0000u6-Cs
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Nov 2006 13:45:53 -0800
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GhCHc-0007AG-2y for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Nov 2006 22:45:32 +0100
Received: from dhcp65-62.ietf67.org ([130.129.65.62])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 06 Nov 2006 22:45:32 +0100
Received: from mcr by dhcp65-62.ietf67.org with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 06 Nov 2006 22:45:32 +0100
From: Michael Richardson <mcr@sandelman.ca>
Date: Mon, 06 Nov 2006 13:44:56 -0800
Message-ID: <eioacp$m4r$1@sea.gmane.org>
References: <eilvlj$b5r$1@sea.gmane.org>
Mime-Version: 1.0
In-Reply-To: <eilvlj$b5r$1@sea.gmane.org>
Subject: Re: [uml-devel] problems with ifup-a on etch compiled kernels
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Michael Richardson wrote:
> I don't know whether to blame a recent update to debian testing from stable --- likely it would be a glibc issue, but...
> I did run into the _syscall0() problem after that, and I found that I could get around it by appropriately #define 
> _KERNEL prior to #include <linux/unistd.h>. What I don't get about the remark of Paolo is that _syscall0() is a userland 
> thing, not a kernel thing.
> 
> I.e. any user program should be able to use _syscall() to get an open coded call to the kernel.
> 
> Anyway, my problem: 2.6.15, 2.6.17.13 (both patched as above), and 2.6.19-rc3 all fail during ifup -a:
> 
> + echo -n 'Configuring network interfaces: '
> Configuring network interfaces: + ifup -a
> BUG: soft lockup detected on CPU#0!
> 083bf9f0:  [<080632a2>] dump_stack+0x22/0x30
> 083bfa08:  [<080a25c4>] softlockup_tick+0x84/0xa0
> 083bfa20:  [<0808ca32>] run_local_timers+0x12/0x20
> 083bfa28:  [<0808c796>] update_process_times+0x36/0x90
> 083bfa48:  [<080636fc>] timer_handler+0x3c/0x70
> 083bfa64:  [<080798f9>] sig_handler_common_skas+0xa9/0x100
> 083bfa88:  [<08075413>] real_alarm_handler+0x23/0x60
> 083bfaa0:  [<080754a2>] alarm_handler+0x52/0x70
> 083bfabc:  [<08077eda>] hard_handler+0x1a/0x20
> 083bfacc:  [<ffffe420>] _etext+0xf7df5404/0x0
> 083bfe14:  [<081a3431>] inet_ioctl+0x61/0xa0
> 083bfe2c:  [<081525a4>] sock_ioctl+0x144/0x2b0

I've tracked this down to a number of places. It looks like the ifa->ifa_dev is not
valid when the notification chain is called:

08707a08:  [<08074329>] sig_handler_common_skas+0xa9/0x120
08707a30:  [<0806ff25>] sig_handler+0x35/0x70
08707a4c:  [<080728ea>] hard_handler+0x1a/0x20
08707a5c:  [<ffffe420>] _etext+0xf7defac0/0x0
08707d64:  [<0808bcdc>] notifier_call_chain+0x6c/0x90
08707d94:  [<0808beb0>] blocking_notifier_call_chain+0x30/0x50
08707db0:  [<081a2d14>] __inet_insert_ifa+0xd4/0x160
08707dd4:  [<081a2dbd>] inet_insert_ifa+0x1d/0x20

The stack item <ffffe420>] _etext+0xf7defac0/0x0, seems to be bogus. I instrumented
kernel/sys.c, to print the functions which notifier_call_chain was calling,
and learnt that it was crashing in arch/um/drivers/net_kern.c because of:
	struct net_device *dev = ifa->ifa_dev->dev;

in uml_inetaddr_event.

sure enough, ifa->ifa_dev was NULL. Naturally, if I run things manually, or under GDB, it fails.
Furthermore, this happens with 2.6.15 and 2.6.17.13 (patched to compile on etch), and
with 2.6.19-rc3 (which I'm using as my debug base).  I tried with gcc-3.3 and with gcc-4.1.2.

So, whatever is going on is related somehow to the glibc, (my guess), but represents some
real bug that has been hidden for awhile.

I patched around the problem in uml_inetaddr_event (return immediately if ifa_dev==NULL), and found
the next instance of it net/ipv4/fib_frontend.c, in fib_netdev_event.
Clearly, either we aren't initializing something right, or it's getting blown away at some point.
Perhaps a different malloc policy in this glibc?

I will spend the rest of today on this (I'm at IETF in San Diego), but afterwards,
I'll begin to start reverting to sarge (if I can), so that I can continue working on my real problem.
I should be on IRC and in jabber. (mrcharlesr@gmail.com, mrichardson@ecotroph.net).

(Hmm. I'm trying Mozilla news for gmane.org reading. I don't like the composer much, I have no
idea what column I'm on...)


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

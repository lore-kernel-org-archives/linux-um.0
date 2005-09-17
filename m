Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGhAE-0002iN-Q3	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Sep 2005 11:11:50 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EGhAD-00061h-1G
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Sep 2005 11:11:51 -0700
Subject: Re: [uml-devel] testing: 2.6.13 to 2.6.14-rc1 TT boot hangs early
	(sometimes)
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <200509171741.30694.blaisorblade@yahoo.it>
References: <1126653933.3769.45.camel@localhost>
	 <200509162124.42522.blaisorblade@yahoo.it>
	 <1126901562.17715.9.camel@localhost>
	 <200509171741.30694.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1126980920.1169.13.camel@localhost>
Mime-Version: 1.0
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
Date: Sat, 17 Sep 2005 19:15:19 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>

> > It stopped complaining at about mem=200M (roughly IIRC)
> Well, that's too low, so yes, there's some problem. Especially because memory 
> is shrunk down to 28M...
> 
> Which is the host distro? Having a RH/Fc could be a cause (I don't know the 
> current situation with these).
That box is a Mandriva system, why would the distribution be relevant?
I thought things like memory allocation would depend on the kernel (or
glibc malloc?) - host kernel is 2.6.13.1

> > The host is fine... so far.
> Sorry, was talking about UML. But I assume it locks up. 
Not always.
> Was SMP enabled?
No.
>  In 
> that case, there's a couple of things in -bs1 (just published) which may help 
> it.
I'll try that.

> > > > * Good points:
> > > > pcap works really well.
> > > > I just wished there was a way to easily figure out which libraries need
> > > > to be included in the chroot to make it work (beyond lipcap)
> 
> > > Idea: try using ltrace with focus on dlopen (from libdl).
> 
> > I'll do that and post the results.
Not tried it yet, but I found this which may be of interest - literally
thousands of these stacktraces in the logs.
I believe the interface that pcap was bound to was restarted - but I am
not sure this is the cause.
After that the interface refuses to be brought back up (inside the
guest), only a guest reboot does it, and dmesg has this message too: 
[43003437.440000] dev_ip_addr - device not assigned an IP address
[43003437.440000] pcap_dispatch failed - recvfrom: Network is down

Here is the repeated message:
[42977981.360000] Badness in local_bh_enable at kernel/softirq.c:140
[42977981.360000] a037f6c0:  [<a001c4de>] dump_stack+0x1e/0x20
[42977981.360000] a037f6e0:  [<a0053fcc>] local_bh_enable+0x6c/0x90
[42977981.360000] a037f710:  [<a0230caa>] __dev_remove_pack+0x7a/0xa0
[42977981.360000] a037f720:  [<a0293b93>] packet_notifier+0xd3/0x130
[42977981.360000] a037f750:  [<a005df9e>] notifier_call_chain+0x1e/0x40
[42977981.360000] a037f780:  [<a0231689>] dev_close+0x89/0xa0
[42977981.360000] a037f7b0:  [<a0039058>] uml_net_interrupt+0x68/0x70
[42977981.360000] a037f7d0:  [<a006e006>] handle_IRQ_event+0x36/0x90
[42977981.360000] a037f800:  [<a006e0fc>] __do_IRQ+0x9c/0xf0
[42977981.360000] a037f820:  [<a0016fdf>] do_IRQ+0x2f/0x40
[42977981.360000] a037f830:  [<a0017534>] sigio_handler+0xd4/0x110
[42977981.360000] a037f860:  [<a0023c78>] sig_handler_common_skas
+0xa8/0x130
[42977981.360000] a037f890:  [<a0040b9f>] sig_handler+0x2f/0x40
[42977981.360000] a037f8b0:  [<ffffe420>] ifaddrs+0x5fa477e0/0x4
[42977981.360000] a037fbb0:  [<a0019a3a>] default_idle+0x5a/0x80
[42977981.360000] a037fbe0:  [<a0023724>] init_idle_skas+0x24/0x30
[42977981.360000] a037fbf0:  [<a00015d1>] start_kernel+0x181/0x1c0
[42977981.360000] a037fc00:  [<a002375b>] start_kernel_proc+0x2b/0x30
[42977981.360000] a037fc10:  [<a00194bf>] run_kernel_thread+0x2f/0x40
[42977981.360000] a037fcd0:  [<a0023401>] new_thread_handler+0xb1/0x110
[42977981.360000] a037fd20:  [<ffffe420>] ifaddrs+0x5fa477e0/0x4
[42977981.360000]

Another query, unrelated (I think): what does this mean?
[42949410.920000] uml_net_start_xmit: failed(-1)

Last, is it possible that there is a connection leak in the socket code?
I've experienced problems running tomcat and ntop in uml guests (but not
apache...), after a while the process are still running but do not
respond to SYN packets, although netstat and lsof still list the
processes as listening on the port - I think I'll prepare a root_fs
instance for you to try out. The problem with ntop could be linked with
the example above of the interface disappearing for a short while, and
as for Java it could be many things..

Cheers
Antoine



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

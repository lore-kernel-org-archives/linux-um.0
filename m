Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ggsgj-0007yc-4E for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Nov 2006 16:50:09 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ggsgi-0006YI-L2
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Nov 2006 16:50:09 -0800
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Ggsgb-0007zN-Uu for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Nov 2006 01:50:02 +0100
Received: from m974b36d0.tmodns.net ([208.54.75.151])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 06 Nov 2006 01:50:01 +0100
Received: from mcr by m974b36d0.tmodns.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 06 Nov 2006 01:50:01 +0100
From: Michael Richardson <mcr@sandelman.ca>
Date: Sun, 05 Nov 2006 16:29:39 -0800
Message-ID: <eilvlj$b5r$1@sea.gmane.org>
Mime-Version: 1.0
Subject: [uml-devel] problems with ifup-a on etch compiled kernels
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

I don't know whether to blame a recent update to debian testing from stable --- likely it would be a glibc issue, but...
I did run into the _syscall0() problem after that, and I found that I could get around it by appropriately #define 
_KERNEL prior to #include <linux/unistd.h>. What I don't get about the remark of Paolo is that _syscall0() is a userland 
thing, not a kernel thing.

I.e. any user program should be able to use _syscall() to get an open coded call to the kernel.

Anyway, my problem: 2.6.15, 2.6.17.13 (both patched as above), and 2.6.19-rc3 all fail during ifup -a:

+ echo -n 'Configuring network interfaces: '
Configuring network interfaces: + ifup -a
BUG: soft lockup detected on CPU#0!
083bf9f0:  [<080632a2>] dump_stack+0x22/0x30
083bfa08:  [<080a25c4>] softlockup_tick+0x84/0xa0
083bfa20:  [<0808ca32>] run_local_timers+0x12/0x20
083bfa28:  [<0808c796>] update_process_times+0x36/0x90
083bfa48:  [<080636fc>] timer_handler+0x3c/0x70
083bfa64:  [<080798f9>] sig_handler_common_skas+0xa9/0x100
083bfa88:  [<08075413>] real_alarm_handler+0x23/0x60
083bfaa0:  [<080754a2>] alarm_handler+0x52/0x70
083bfabc:  [<08077eda>] hard_handler+0x1a/0x20
083bfacc:  [<ffffe420>] _etext+0xf7df5404/0x0
083bfe14:  [<081a3431>] inet_ioctl+0x61/0xa0
083bfe2c:  [<081525a4>] sock_ioctl+0x144/0x2b0
083bfe60:  [<080d022f>] do_ioctl+0x5f/0x70
083bfe80:  [<080d04e2>] vfs_ioctl+0x62/0x2d0
083bfebc:  [<080d0791>] sys_ioctl+0x41/0x70
083bfee4:  [<08065a83>] handle_syscall+0xd3/0xe0
083bff54:  [<0807897a>] handle_trap+0x2a/0x130
083bff7c:  [<08079074>] userspace+0x1c4/0x220
083bffd4:  [<0806569e>] fork_handler+0x9e/0xb0
083bfffc:  [<00000000>] _sinittext+0xf7fb7000/0x20

If I boot with "linux emergency" login to the single user shell and run "ifup -a", everything is fine.

This is on my laptop running 2.6.17.4 as the host kernel, not under XenU as I previously had
been posting about.

(I'm in an airport lounge at Chicago)


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

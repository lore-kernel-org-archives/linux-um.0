Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rjones@redhat.com>) id 1V7tXc-00039K-JN
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 20:44:08 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V7tXZ-0003vt-4r for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 20:44:08 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r79KhwFj006037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 9 Aug 2013 16:43:59 -0400
Received: from localhost (vpn1-6-126.ams2.redhat.com [10.36.6.126])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id r79Khvx2019949 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 9 Aug 2013 16:43:58 -0400
Date: Fri, 9 Aug 2013 21:43:55 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20130809204355.GA10864@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Using UML in libguestfs
To: user-mode-linux-devel@lists.sourceforge.net

Today I wrote some patches (for libguestfs) which add an experimental
UML backend:

  https://www.redhat.com/archives/libguestfs/2013-August/msg00005.html

There are some observations from this.

* 'ubd<N>=cow,original' is not parsed correctly.  This was reported a
while back and I'm seeing the same thing with the latest kernel from
git:

  http://thread.gmane.org/gmane.linux.uml.devel/13556

If I have some time I'll have a go at fixing this since it seems like
a simple regression.

* I'm trying to use a serial port to communicate between guest and
host, using ssl3=fd:<N>.  This causes the Linux process to crash soon
(but not immediately) after the guest has opened /dev/ttyS3:

  spurious interrupt in ubd_handler, err = -4

I've put the full call trace at the end of the email because it's
quite long[1].  This was also reported before, although the suggested
patch did not fix it:

  http://marc.info/?l=linux-kernel&m=123242364211797&w=2

I wonder if anyone has used the fd:<N> option in anger?  I will try
using a Unix domain socket and see if it makes a difference.

* UML is pretty fast!  It's certainly faster (by a factor of > 5) than
spinning up a lightweight KVM VM.

Rich.

[1] Call trace

spurious interrupt in ubd_handler, err = -4

Modules linked in:
Pid: 1614169860, comm:  Not tainted 3.11.0-rc4-00103-g6c2580c
RIP: 0033:[<000000006001db74>]
RSP: 0000000080ca9f98  EFLAGS: 00010206
RAX: 0000000000000008 RBX: 0000000000000008 RCX: 0000003f2cae6970
RDX: 0000000000000000 RSI: 0000000080ca9fb0 RDI: 0000000000000005
RBP: 0000000080ca9fe8 R08: 0000000080ca9ed8 R09: 0000000080ca9e40
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000001000
R13: 0000000080e867c4 R14: 0000000000000001 R15: 68c00000000080ea
Call Trace: 
80ca9538:  [<600151ac>]------------[ cut here ]------------
WARNING: CPU: 0 PID: 6 at block/blk.h:210 generic_make_request_checks+0x1aa/0x234()
BUG: recent printk recursion!
80ca9648:  [<60022207>] sig_handler_common+0x8c/0xa2
80ca96d0:  [<6001db74>] io_thread+0x63/0x243
80ca9988:  [<600222c2>] sig_handler+0x2e/0x39
80ca99a8:  [<60021f33>] hard_handler+0x83/0xab
80ca9aa8:  [<6001db74>] io_thread+0x63/0x243
80ca9d88:  [<60021eb0>] hard_handler+0x0/0xab
80ca9f70:  [<60020308>] os_seek_file+0x11/0x27
80ca9f80:  [<6002032a>] os_read_file+0xc/0x1f
80ca9f90:  [<6001db3b>] io_thread+0x2a/0x243

Kernel panic - not syncing: Segfault with no mm
CPU: 0 PID: 1614169860 Comm:  Not tainted 3.11.0-rc4-00103-g6c2580c #3

Modules linked in:
Pid: 1614169860, comm:  Not tainted 3.11.0-rc4-00103-g6c2580c
RIP: 0033:[<0000000060026715>]
RSP: 0000000080ca9328  EFLAGS: 00010246
RAX: 0000000080ca9398 RBX: 00000000602d2460 RCX: 0000000080ca8000
RDX: 0000000000000008 RSI: 636f6c6e6f6e5f88 RDI: 0000000080ca9398
RBP: 0000000080ca9350 R08: 636f6c6e6f6e5f70 R09: 636f6c6e6f6e5f70
R10: 0000003f2ca892da R11: 0000003f2ca892da R12: 000000006026b27c
R13: 000000006001db74 R14: 0000000000000004 R15: 0000000000000000
Call Trace: 
80ca88b8:  [<600151ac>] segv+0x66/0x241
80ca8988:  [<600153e9>] segv_handler+0x62/0x6c
80ca89c8:  [<60022207>] sig_handler_common+0x8c/0xa2
80ca89e0:  [<6001db74>] io_thread+0x63/0x243
80ca8a50:  [<60026715>] memcpy+0xb5/0x140
80ca8d08:  [<600222c2>] sig_handler+0x2e/0x39
80ca8d28:  [<60021f33>] hard_handler+0x83/0xab
80ca8d58:  [<6001db74>] io_thread+0x63/0x243
80ca8dd0:  [<6001db74>] io_thread+0x63/0x243
80ca8e28:  [<60026715>] memcpy+0xb5/0x140
80ca90e8:  [<60017226>] generic_write+0xf/0x38
80ca9108:  [<600172f9>] generic_console_write+0x3e/0x165
80ca9288:  [<6004c396>] vprintk_emit+0x2dd/0x2ee
80ca92d8:  [<6001db74>] io_thread+0x63/0x243
80ca92f8:  [<601edf38>] printk+0x97/0x99
80ca9308:  [<60015eff>] copy_from_user+0x36/0x8a
80ca9328:  [<60015eff>] copy_from_user+0x36/0x8a
80ca9358:  [<600699d4>] __probe_kernel_read+0x3c/0x6d
80ca9368:  [<6003f2ac>] probe_kthread_data+0x29/0x2f
80ca9388:  [<6003becc>] print_worker_info+0x66/0x124
80ca93f8:  [<6004d204>] dump_stack_print_info+0xa6/0xaf
80ca9428:  [<601efbeb>] dump_stack+0xe/0x19
80ca9438:  [<601ed8b7>] panic+0xf7/0x1e4
80ca9490:  [<60056982>] __module_text_address+0xd/0x4d
80ca94a8:  [<6005a007>] is_module_text_address+0x9/0x11
80ca94b8:  [<6003cd40>] __kernel_text_address+0x26/0x49
80ca94d8:  [<60014146>] show_trace+0x8e/0x95
80ca9508:  [<60026491>] show_regs+0x27/0x2a
80ca9520:  [<6001db74>] io_thread+0x63/0x243
80ca9538:  [<6001524f>] segv+0x109/0x241
80ca9608:  [<600153e9>] segv_handler+0x62/0x6c
80ca9628:  [<60022169>] unblock_signals+0x4a/0x5c
80ca9648:  [<60022207>] sig_handler_common+0x8c/0xa2
80ca96d0:  [<6001db74>] io_thread+0x63/0x243
80ca9988:  [<600222c2>] sig_handler+0x2e/0x39
80ca99a8:  [<60021f33>] hard_handler+0x83/0xab
80ca9aa8:  [<6001db74>] io_thread+0x63/0x243
80ca9d88:  [<60021eb0>] hard_handler+0x0/0xab
80ca9f70:  [<60020308>] os_seek_file+0x11/0x27
80ca9f80:  [<6002032a>] os_read_file+0xc/0x1f
80ca9f90:  [<6001db3b>] io_thread+0x2a/0x243

Kernel panic - not syncing: Segfault with no mm

Modules linked in:
Pid: 1614169860, comm:  Not tainted 3.11.0-rc4-00103-g6c2580c
RIP: 0000:[<000001a400000004>]
RSP: 0000000000000000  EFLAGS: 6002e720
RAX: 000000006002e770 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000602706ae
RBP: 0000000000000000 R08: 0000000000000000 R09: 000001a400000004
R10: 00000000602d04ac R11: 000000006027069b R12: 0000000000000000
R13: 000000006002e720 R14: 0000000000000000 R15: 000001a400000004
Call Trace: 
80ca8748:  [<6001564c>] panic_exit+0x2b/0x41
80ca8758:  [<6015a3ac>] vsnprintf+0xd0/0x431
80ca8768:  [<600427c7>] notifier_call_chain+0x39/0x5c
80ca8790:  [<60026715>] memcpy+0xb5/0x140
80ca87a8:  [<60042804>] atomic_notifier_call_chain+0xf/0x11
80ca87b8:  [<601ed8d2>] panic+0x112/0x1e4
80ca8810:  [<60056982>] __module_text_address+0xd/0x4d
80ca8828:  [<6005a007>] is_module_text_address+0x9/0x11
80ca8838:  [<6003cd40>] __kernel_text_address+0x26/0x49
80ca8858:  [<60014146>] show_trace+0x8e/0x95
80ca8888:  [<60026491>] show_regs+0x27/0x2a
80ca88a0:  [<60026715>] memcpy+0xb5/0x140
80ca88b8:  [<6001524f>] segv+0x109/0x241
80ca8988:  [<600153e9>] segv_handler+0x62/0x6c
80ca89c8:  [<60022207>] sig_handler_common+0x8c/0xa2
80ca89e0:  [<6001db74>] io_thread+0x63/0x243

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAFWK-0001mD-TG	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Aug 2005 16:28:00 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EAFWJ-0004x9-BT
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Aug 2005 16:28:00 -0700
Subject: Re: [uml-devel] Re: [uml-user] Hardware Requirements -Some
	Questions about UML by a Newbie
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <20050828140355.GF3192@ccure.user-mode-linux.org>
References: <396648218@web.de>
	 <20050811232256.GF11873@ccure.user-mode-linux.org>
	 <200508121814.43201.blaisorblade@yahoo.it>
	 <1124960678.28722.29.camel@localhost.localdomain>
	 <20050828140355.GF3192@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1125448055.3801.6.camel@localhost.localdomain>
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
Date: Wed, 31 Aug 2005 01:27:35 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>, Blaisorblade <blaisorblade@yahoo.it>, eric_leitner@web.de

Thanks Jeff,

Works for me (tm)
I reckon that this patch is small enough to go into 2.6.13.1
It fixes a bug, so it should be included, right?

There are still problems that I can't track down. On occasion I ended up
with a system hosed up, where I couldn't even do a 'ps -ef' without
hanging the terminal.

Not sure this is relevant, but I caught this on the host (it could just
be that my latop caught some MCE errors after overheating, but it
happened more than once so I thought I'd post it):
[13783.971150] ----------- [cut here ] --------- [please bite here ]
---------
[13783.971159] Kernel BUG at "mm/prio_tree.c":125
[13783.971162] invalid operand: 0000 [1] PREEMPT
[13783.971165] CPU 0
[13783.971167] Modules linked in: ipt_MASQUERADE iptable_nat tun
parport_pc lp parport eeprom i2c_sensor i2c_viapro i2c_dev i2c_core
rfcomm l2cap bluetooth af_packet ipt_REJECT ipt_state ip_conntrack
iptable_filter ip_tables dm_mod container ipv6 ohci1394 ieee1394
uhci_hcd ehci_hcd shpchp via_ircc irda crc_ccitt tg3 usbcore joydev
tsdev unix
[13783.971185] Pid: 24646, comm: vmlinux-2.6.13- Tainted: G   M  2.6.13
[13783.971188] RIP: 0010:[<ffffffff8016ea98>]
<ffffffff8016ea98>{vma_prio_tree_remove+88}
[13783.971199] RSP: 0018:ffff81004a225df8  EFLAGS: 00010283
[13783.971203] RAX: 00000000000000fd RBX: ffff8100497aa528 RCX:
fffffffffffffffc
[13783.971208] RDX: ffff810036ec4e78 RSI: ffff810036ec4e98 RDI:
ffff81004a1e5c48
[13783.971213] RBP: ffff81004a1e5c48 R08: ffff810036ec4e98 R09:
ffff81004a225df0
[13783.971218] R10: ffff8100494cd6f8 R11: ffff8100494cd6f8 R12:
ffff81003747b380
[13783.971222] R13: ffff81004a1e5c48 R14: ffff81004a1e5cf8 R15:
ffff81004a1e5d10
[13783.971227] FS:  000000006069e860(0000) GS:ffffffff806ec800(0000)
knlGS:000000006471aff8
[13783.971230] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[13783.971233] CR2: 0000007fbffff030 CR3: 000000000459c000 CR4:
00000000000006e0
[13783.971238] Process vmlinux-2.6.13- (pid: 24646, threadinfo
ffff81004a224000, task ffff81000f991560)
[13783.971240] Stack: ffffffff8065d080 ffff810036ec4e78 ffff81004a1e5c48
ffffffff80174d51
[13783.971248]        0000000000000000 ffff81000df04180 ffff81004a1e5c48
ffffffff80175c8e
[13783.971253]        0000000000000000 ffff81000df04188
[13783.971257] Call Trace:<ffffffff80174d51>{remove_vm_struct+65}
<ffffffff80175c8e>{do_munmap+670}
[13783.971270]        <ffffffff8010e2dd>{do_signal+157}
<ffffffff80176a43>{do_mmap_pgoff+931}
[13783.971281]        <ffffffff8015f122>{audit_syscall_entry+338}
<ffffffff8047e525>{__down_write+53}
[13783.971294]        <ffffffff80115425>{sys_mmap+165}
<ffffffff8010ed52>{tracesys+209}
[13783.971306]
[13783.971311]
[13783.971312] Code: 0f 0b a3 e0 33 4a 80 ff ff ff ff c2 7d 00 48 83 7f
60 00 74
[13783.971322] RIP <ffffffff8016ea98>{vma_prio_tree_remove+88} RSP
<ffff81004a225df8>
[13783.971328]  <6>note: vmlinux-2.6.13-[24646] exited with
preempt_count 1
[13783.971337] scheduling while atomic: vmlinux-2.6.13-/0x00000001/24646
[13783.971339]
[13783.971340] Call Trace:<ffffffff8047ce5a>{schedule+122}
<ffffffff8047e4c5>{__down_read+213}
[13783.971351]        <ffffffff80138a59>{exit_mm+57}
<ffffffff80139874>{do_exit+484}
[13783.971361]        <ffffffff8038bd0e>{do_unblank_screen+110}
<ffffffff80110535>{die+69}
[13783.971372]        <ffffffff80111073>{do_invalid_op+163}
<ffffffff8016ea98>{vma_prio_tree_remove+88}
[13783.971381]        <ffffffff80313e4a>{avc_has_perm+90}
<ffffffff8010f4e1>{error_exit+0}
[13783.971393]        <ffffffff8016ea98>{vma_prio_tree_remove+88}
<ffffffff80174d51>{remove_vm_struct+65}
[13783.971406]        <ffffffff80175c8e>{do_munmap+670}
<ffffffff8010e2dd>{do_signal+157}
[13783.971414]        <ffffffff80176a43>{do_mmap_pgoff+931}
<ffffffff8015f122>{audit_syscall_entry+338}
[13783.971425]        <ffffffff8047e525>{__down_write+53}
<ffffffff80115425>{sys_mmap+165}
[13783.971435]        <ffffffff8010ed52>{tracesys+209}





On Sun, 2005-08-28 at 10:03 -0400, Jeff Dike wrote:
> On Thu, Aug 25, 2005 at 10:04:38AM +0100, Antoine Martin wrote:
> > 64-bit is broken atm, you'll run out of memory very quickly.
> 
> Um, and the patch is really included this time.
> 
> 				Jeff



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

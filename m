Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1S7aN0-0001Op-WB
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Mar 2012 22:39:07 +0000
Received: from natasha.panasas.com ([67.152.220.90])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S7aN0-0007zB-0t for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Mar 2012 22:39:06 +0000
Message-ID: <4F5FCC7D.5090307@panasas.com>
Date: Tue, 13 Mar 2012 15:38:53 -0700
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
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
Subject: [uml-devel] UML: Please help with __module_text_address crashing
To: Richard Weinberger <richard@nod.at>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Since a while now my UMLs are constantly crashing in __module_text_address

which makes no sense because if I do gdb> list *(__module_text_address+0xd)
I get:

0x6005614e is in __module_text_address (/media/usr0/export/dev/bharrosh/git/pub/linux-open-osd/kernel/module.c:3469).
3464     * module doesn't get freed during this.
3465     */
3466    struct module *__module_text_address(unsigned long addr)
3467    {
3468            struct module *mod = __module_address(addr);
3469            if (mod) {
3470                    /* Make sure it's within the text section. */
3471                    if (!within(addr, mod->module_init, mod->init_text_size)
3472                        && !within(addr, mod->module_core, mod->core_text_size))
3473                            mod = NULL;

It can not be crashing in line 3469, I suspect it's crashing inside __module_address(addr); at line 3468

Below it's crashing as part of the console operation, which is the most common one, but it can crash in
__module_text_address as part of other stack traces like networking and so on. From my feel it's always
related to some UML driver that actually operates as part of the host. But I can't be sure.

I'm running with 3.3-rc4 but I'm hit with this since 3.0, I tried to bisect
this at the time, but I found out that I could not find a perfectly good point
even as far as 3.6.37. So I suspected there is something wrong with my uml-image file
or my host. But now I upgraded both host and image to FC15 (was FC12/FC13) and I get
the same exact crashes. It came to a situation that I can't complete any kind
of heavy operation anymore and have abandoned UML for VMS for now. But I'm
very sorry to see UML go.

Can anyone help me with some insight on what I should try, to debug this thing.

BTW:
How to debug UML under gdb, it forks like mad and if I do:
	gdb> set detach-on-fork off
It will just freeze. And if I do 
	gdb> attach <some-vmlinux-child-process>
(Try to attach to any but the top parent process)
Will return "access not permitted". I guess UML is a debugger of sorts and it can't be
double debugged.

Thanks
Boaz

Kernel panic - not syncing: Kernel mode fault at addr 0x54, ip 0x6015c233

Modules linked in: md5 objlayoutdriver nfsd exofs exportfs libore async_xor async_tx xor cryptomgr aead crc32c crypto_hash crypto_algapi iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi osd scsi_mod libosd nfs lockd auth_rpcgss nfs_acl sunrpc ipv6 [last unloaded: scsi_wait_scan]
Pid: 1223, comm: bash Not tainted 3.3.0-rc4-pnfs+
RIP: 0033:[<000000387aed78a3>]
RSP: 0000007fbfee78c8  EFLAGS: 00000206
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: ffffffffffffffff
RDX: 0000007fbfee7890 RSI: 0000000000005403 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000007fbfee7940 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000002
R13: 00000000000000c8 R14: 0000000000000000 R15: 0000000000000000
Call Trace: 
602ab598:  [<6001697c>] panic_exit+0x2f/0x45
602ab5b8:  [<60046678>] notifier_call_chain+0x32/0x5e
602ab5e8:  [<6015c233>] do_raw_spin_lock+0x12/0xdb
602ab5f8:  [<600466c6>] atomic_notifier_call_chain+0x13/0x15
602ab608:  [<601e90a4>] panic+0x112/0x1ea
602ab640:  [<6015c233>] do_raw_spin_lock+0x12/0xdb
602ab660:  [<6005614e>] __module_text_address+0xd/0x56
602ab678:  [<60059324>] is_module_text_address+0x9/0x11
602ab688:  [<6004019b>] __kernel_text_address+0x21/0x47
602ab6a8:  [<600154de>] show_trace+0x8e/0x95
602ab6b0:  [<6015c233>] do_raw_spin_lock+0x12/0xdb
602ab6d8:  [<60028683>] show_regs+0x2b/0x30
602ab6f8:  [<6015c233>] do_raw_spin_lock+0x12/0xdb
602ab708:  [<60016713>] segv_handler+0x0/0x81
602ab718:  [<600603d1>] handle_irq_event_percpu+0xfd/0x119
602ab758:  [<6006300f>] rcu_sched_qs+0x74/0x79
602ab7d8:  [<6001678a>] segv_handler+0x77/0x81
602ab808:  [<60013c26>] sigio_handler+0x58/0x5d
602ab828:  [<60023e9d>] sig_handler_common+0x84/0x98
602ab890:  [<60018efc>] line_chars_in_buffer+0x0/0x4c
602ab8b0:  [<6015c233>] do_raw_spin_lock+0x12/0xdb
602ab8d0:  [<60016fe8>] virt_to_pte+0x4a/0x6a
602ab928:  [<6001141c>] _einittext+0x1a0d/0x2c91
602ab938:  [<60010760>] _einittext+0xd51/0x2c91
602aba18:  [<6001141c>] _einittext+0x1a0d/0x2c91
602abb58:  [<60023f8d>] sig_handler+0x2d/0x38
602abb78:  [<60023bc3>] hard_handler+0x6b/0x9d
602abc48:  [<60018efc>] line_chars_in_buffer+0x0/0x4c
602abc68:  [<6015c233>] do_raw_spin_lock+0x12/0xdb

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1S7bsf-00084L-Pw
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Mar 2012 00:15:53 +0000
Received: from natasha.panasas.com ([67.152.220.90])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S7bsd-0001ZM-IE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Mar 2012 00:15:53 +0000
Message-ID: <4F5FE32B.9040301@panasas.com>
Date: Tue, 13 Mar 2012 17:15:39 -0700
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <4F5FCC7D.5090307@panasas.com> <4F5FDF42.90004@nod.at>
In-Reply-To: <4F5FDF42.90004@nod.at>
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
Subject: Re: [uml-devel] UML: Please help with __module_text_address crashing
To: Richard Weinberger <richard@nod.at>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On 03/13/2012 04:58 PM, Richard Weinberger wrote:
> 
> What exactly triggers the crash?
> IOW, how can I reproduce it?
> 

It's totally random, but always the same crash.

I guess if you don't have it then you don't. The most reliable way for me to get
it is a simple "halt". I'm not able to ever shut down properly it reliably crashes
like:

Kernel panic - not syncing: Kernel mode fault at addr 0x54, ip 0x6015c233

Modules linked in: nfs lockd auth_rpcgss nfs_acl sunrpc ipv6 [last unloaded: scsi_wait_scan]
Pid: 1210, comm: autofs Not tainted 3.3.0-rc4-pnfs+
RIP: 0033:[<000000387aed28d0>]
RSP: 0000007fbf9876d8  EFLAGS: 00000246
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: ffffffffffffffff
RDX: 0000000000000001 RSI: 0000000040008000 RDI: 0000000000000001
RBP: 0000000040008000 R08: 00000000ffffffff R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 000000387b1928e0
R13: 0000000000000001 R14: 000000000093eb80 R15: 000000000093eb80
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
602ab890:  [<60018eb8>] line_write_room+0x0/0x44
602ab8b0:  [<6015c233>] do_raw_spin_lock+0x12/0xdb
602ab8d0:  [<6015435a>] prio_tree_insert+0x4c/0x23b
602ab928:  [<6001141c>] _einittext+0x1a0d/0x2c91
602ab938:  [<60010760>] _einittext+0xd51/0x2c91
602aba18:  [<6001141c>] _einittext+0x1a0d/0x2c91
602abb58:  [<60023f8d>] sig_handler+0x2d/0x38
602abb78:  [<60023bc3>] hard_handler+0x6b/0x9d
602abc48:  [<60018eb8>] line_write_room+0x0/0x44
602abc68:  [<6015c233>] do_raw_spin_lock+0x12/0xdb

I'd give anything to get your setup that works. 

Though I have everything by the letter:
- Newly installed FC15 host
- Copied over FC15 image from a KVM with the tty0 /etc fixes.
- commandline:
  ./vmlinux ubd0=Fedora15-AMD64-root_fs-1 ubd1=swap_file-1 eth0=tuntap,,,172.17.132.231 mem=384M

It'll crash every time

>> BTW:
>> How to debug UML under gdb, it forks like mad and if I do:
>> 	gdb>  set detach-on-fork off
>> It will just freeze. And if I do
>> 	gdb>  attach<some-vmlinux-child-process>
>> (Try to attach to any but the top parent process)
>> Will return "access not permitted". I guess UML is a debugger of sorts and it can't be
>> double debugged.
> 
> e.g:
> $ gdb linux
> (gdb) handle SIGSEGV noprint nostop pass
> (gdb) set args <your kernel args>
> (gdb) run
> 
> UML "forks like mad" because it creates an thread for each process 
> within UML...
> 

OK then I have a problem because I get the "access not permitted" on attaching to any of these
forks but the top most parent. (as sudo)

> Thanks,
> //richard

Thanks for your reply
Boaz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AtWHs-0000xk-2c
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 10:19:08 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AtWD4-0000Fa-B5
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 10:14:10 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Diagnosed and repeatable kernel mode panic in schedule() for 2.6!
References: <200402151911.11890.blaisorblade_spam@yahoo.it> <20040216095335.GA27377@elte.hu>
In-Reply-To: <20040216095335.GA27377@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402171656.02895.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 17 Feb 2004 16:56:02 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 10:53, luned=EC 16 febbraio 2004, Ingo Molnar ha scritto:
> * BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
> > While searching the archives, I noticed that this command:
> >
> > while /bin/true ; do /bin/true ; done
> >
> > Kernel panic: Kernel mode fault at addr 0x1f, ip 0x400d1397
> > Kernel panic: kernel BUG at kernel/exit.c:793!
>
> can you reproduce this crash even if you boot up UML via init=3D/bin/bash?

Now, with 2.6.3-rc2-1um, I get this message (the command was while cat=20
/dev/null; do cat /dev/null; done; both with normal init and init=3D/bin/sh=
).=20
Note I did not press SysRq, nor did it with mconsole; it was done by Uml=20
itself (panic_exit...). However, the last time I remember that the notifier=
=20
chain was corrupted.

The decoding of part of the "Call stack" follows (but it is normal that mos=
t=20
calls are seriously screwed away? I.e. they are just values in the stack, n=
ot=20
actual calls).

Kernel panic: Kernel mode fault at addr 0x94, ip 0x40059923
Kernel panic: kernel BUG at kernel/exit.c:793!

 <6>SysRq : Show Regs

EIP: 0023:[<4005b476>] CPU: 0 Not tainted ESP: 002b:bffffd44 EFLAGS: 000002=
86
    Not tainted
EAX: ffffffda EBX: 00000000 ECX: 00000000 EDX: 000018c0
ESI: ffffffff EDI: 00000000 EBP: 00000000 DS: 002b ES: 002b
Call Trace: [<a00c4021>] [<a001991f>] [<a00836ed>] [<a0040186>] [<a003240d>]
   [<a0032498>] [<a003492c>] [<a0026000>] [<a0034ba4>] [<a001e298>]=20
[<a0017b7e>]
   [<a001e30d>] [<a001d445>] [<a001d723>] [<a001dfd4>] [<a001dfbc>]=20
[<a012de98>]
   [<a001df1b>] [<a0149cdd>]

(gdb) info line *0xa00c4021
Line 327 of "drivers/char/sysrq.c" starts at address 0xa00c4021=20
<handle_sysrq+49>
   and ends at 0xa00c4030 <__handle_sysrq_nolock>.
(gdb) info line *0xa001991f
Line 398 of "arch/um/kernel/um_arch.c" starts at address 0xa001991f=20
<panic_exit+31> and ends at 0xa0019924 <panic_exit+36>.

(gdb) info line *0xa00836ed
Line 467 of "fs/fs-writeback.c" starts at address 0xa00836db <sync_inodes+7=
5>=20
and ends at 0xa00836f3 <sync_inodes+99>.
(gdb) info line *0xa0040186
Line 169 of "kernel/sys.c" starts at address 0xa0040180=20
<notifier_call_chain+32>
   and ends at 0xa0040188 <notifier_call_chain+40>.
(gdb) info line *0xa003240d
Line 78 of "kernel/panic.c" starts at address 0xa003240d <panic+125> and en=
ds=20
at 0xa0032419 <panic+137>.
(gdb) info line *0xa0032498
Line 69 of "kernel/panic.c" starts at address 0xa0032493 <panic+259> and en=
ds=20
at 0xa00324a0 <print_tainted>.
(gdb) info line *0xa0018c19
Line 154 of "arch/um/kernel/trap_kern.c" starts at address 0xa0018c19=20
<segv+121> and ends at 0xa0018c1c <segv+124>.
(gdb) info line *0xa0018d28
Line 161 of "arch/um/kernel/trap_kern.c" starts at address 0xa0018d28=20
<segv+392> and ends at 0xa0018d3f <segv+415>.
(gdb) info line *0xa012e19a
Line 92 of "include/linux/slab.h" starts at address 0xa011fe16=20
<unix_seq_open+22> and ends at 0xa01c3632 <af_unix_exit+18>.
(gdb) info line *0xa012e19a
Line 92 of "include/linux/slab.h" starts at address 0xa011fe16=20
<unix_seq_open+22> and ends at 0xa01c3632 <af_unix_exit+18>.
(gdb) info line *0xa0016f1d
Line 69 of "arch/um/kernel/signal_user.c" starts at address 0xa0016f0e=20
<change_signals+62>
   and ends at 0xa0016f24 <change_signals+84>.
(gdb) info line *0xa00190f7
Line 67 of "arch/um/kernel/trap_user.c" starts at address 0xa00190c2=20
<segv_handler+306> and ends at 0xa00191b0 <usr2_handler>.
(gdb) info line *0xa001905f
Line 64 of "arch/um/kernel/trap_user.c" starts at address 0xa001905f=20
<segv_handler+207>
   and ends at 0xa0019065 <segv_handler+213>.
(gdb) info line *0xa001e7f3
Line 35 of "arch/um/kernel/skas/trap_user.c" starts at address 0xa001e7f3=20
<sig_handler_common_skas+115>
   and ends at 0xa001e7f8 <sig_handler_common_skas+120>.
(gdb) info line *0xa0019200
Line 103 of "arch/um/kernel/trap_user.c" starts at address 0xa00191f0=20
<sig_handler+32> and ends at 0xa0019210 <alarm_handler>.
(gdb) info line *0xa012de98
Line 92 of "include/linux/slab.h" starts at address 0xa011fe16=20
<unix_seq_open+22> and ends at 0xa01c3632 <af_unix_exit+18>.
(gdb) info line *0xa002ee65
Line 1680 of "kernel/sched.c" starts at address 0xa002ee65 <schedule+453> a=
nd=20
ends at 0xa002ee70 <schedule+464>.
(gdb) info line *0xa012e19a
Line 92 of "include/linux/slab.h" starts at address 0xa011fe16=20
<unix_seq_open+22> and ends at 0xa01c3632 <af_unix_exit+18>.
(gdb) info line *0xa00170a4
Line 127 of "arch/um/kernel/signal_user.c" starts at address 0xa0017099=20
<set_signals+105>
   and ends at 0xa00170ab <set_signals+123>.
(gdb) info line *0xa002e55a
Line 301 of "kernel/sched.c" starts at address 0xa002e555=20
<wake_up_forked_process+357>
   and ends at 0xa002e55d <wake_up_forked_process+365>.
(gdb) info line *0xa002e408
Line 780 of "kernel/sched.c" starts at address 0xa002e408=20
<wake_up_forked_process+24>
   and ends at 0xa002e412 <wake_up_forked_process+34>.
(gdb) info line *0xa0031e4f
Line 1138 of "kernel/fork.c" starts at address 0xa0031e4f <do_fork+63> and =

ends at 0xa0031e52 <do_fork+66>.
(gdb) info line *0xa0031f47
Line 1157 of "kernel/fork.c" starts at address 0xa0031f40 <do_fork+304> and=
=20
ends at 0xa0031f4c <do_fork+316>.
(gdb) info line *0xa0018a84
Line 90 of "arch/um/kernel/trap_kern.c" starts at address 0xa0018a7b=20
<handle_page_fault+331>
   and ends at 0xa0018a8c <handle_page_fault+348>.
(gdb) info line *0xa001898c
Line 93 of "arch/um/kernel/trap_kern.c" starts at address 0xa001898c=20
<handle_page_fault+92>
   and ends at 0xa0018997 <handle_page_fault+103>.

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

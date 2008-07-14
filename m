Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KIK1R-00049J-Fq for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jul 2008 02:07:05 -0700
Received: from smtp-out.google.com ([216.239.33.17])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KIK1P-0000vJ-ST
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jul 2008 02:07:05 -0700
Received: from spaceape11.eur.corp.google.com (spaceape11.eur.corp.google.com
	[172.28.16.145]) by smtp-out.google.com with ESMTP id m6E96oxY023834
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 14 Jul 2008 10:06:50 +0100
Received: from rv-out-0506.google.com (rvfb25.prod.google.com [10.140.179.25])
	by spaceape11.eur.corp.google.com with ESMTP id m6E96JnU029375
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 14 Jul 2008 10:06:49 +0100
Received: by rv-out-0506.google.com with SMTP id b25so4484351rvf.45
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 14 Jul 2008 02:06:49 -0700 (PDT)
Message-ID: <5df78e1d0807140206m43291128t32f1489177ad6e3d@mail.gmail.com>
Date: Mon, 14 Jul 2008 17:06:49 +0800
From: "Jiaying Zhang" <jiayingz@google.com>
In-Reply-To: <20080710170210.GB18429@c2.user-mode-linux.org>
MIME-Version: 1.0
References: <5df78e1d0807030053x8a9bfabo582ea78e74b2c65b@mail.gmail.com>
	<20080703135639.GA8262@c2.user-mode-linux.org>
	<5df78e1d0807031806s74c13c84idadc62c1d1e0e93b@mail.gmail.com>
	<5df78e1d0807091925q64c0121fk3d33c37df8d80d18@mail.gmail.com>
	<20080710170210.GB18429@c2.user-mode-linux.org>
Subject: Re: [uml-devel] 2.6.25 uml kernel crashes when it calls down() on a
	semaphore with zero counter
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1920485305=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============1920485305==
Content-Type: multipart/alternative; 
	boundary="----=_Part_54406_8557712.1216026409236"

------=_Part_54406_8557712.1216026409236
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, Jul 11, 2008 at 1:02 AM, Jeff Dike <jdike@addtoit.com> wrote:

> On Thu, Jul 10, 2008 at 10:25:29AM +0800, Jiaying Zhang wrote:
> > Do you have any thought about what the problem might be?
> > Thanks a lot!
>
> Yeah, my first thought is that your code is buggy.
>
> Since 2.6.25 seems OK, you can bisect between then and now to see
> either what caused the bug or what is triggering the crash on an
> existing bug.


The 2.6.24 kernels are OK, but I have seen this problem with all of the
2.6.25 kernels I have tried. There have been a lot of changes between
2.6.24 kernels and 2.6.25 kernels. I am not sure which one may lead
to this problem.


> The other thing you can do is gdb the UML and see if gdb gives you a
> better stack trace.
>

Here is the trace from gdb uml.

Program received signal SIGTERM, Terminated.
0xb7fff410 in ?? ()
(gdb) bt
#0  0xb7fff410 in ?? ()
#1  0x08323afc in cpu0_irqstack ()
#2  0xfffffffe in ?? ()
#3  0x0000000f in ?? ()
#4  0x464850c6 in kill () from /lib/tls/i686/cmov/libc.so.6
#5  0x0806624b in os_dump_core () at arch/um/os-Linux/util.c:92
#6  0x08059703 in panic_exit (self=0x83254f4, unused1=0, unused2=0x8340a80)
at arch/um/kernel/um_arch.c:233
#7  0x080849d0 in notifier_call_chain (nl=0x0, val=0, v=0x8340a80,
nr_to_call=0, nr_calls=0x0)
    at kernel/notifier.c:70
#8  0x08084a72 in __atomic_notifier_call_chain (nh=0x8340a60, val=0,
v=0x8340a80, nr_to_call=-1,
    nr_calls=0x0) at kernel/notifier.c:159
#9  0x08084a89 in atomic_notifier_call_chain (nh=0x8340a60, val=0,
v=0x8340a80) at kernel/notifier.c:168
#10 0x0807116f in panic (fmt=0x82d2039 "Kernel mode fault at addr 0x%lx, ip
0x%lx") at kernel/panic.c:101
#11 0x080594c1 in segv (fi={error_code = 6, cr2 = 98596, trap_no = 14},
ip=136845739, is_user=0,
    regs=0x8323c6c) at arch/um/kernel/trap.c:206
#12 0x080592a0 in segv_handler (sig=11, regs=0x8323c6c) at
arch/um/kernel/trap.c:152
#13 0x0806537b in sig_handler_common (sig=11, sc=0x8323d24) at
arch/um/os-Linux/signal.c:48
#14 0x080653b8 in sig_handler (sig=11, sc=0x8323d24) at
arch/um/os-Linux/signal.c:80
#15 0x080654dd in handle_signal (sig=<value optimized out>, sc=0x8323d24) at
arch/um/os-Linux/signal.c:157
#16 0x08066ebf in hard_handler (sig=11) at
arch/um/os-Linux/sys-i386/signal.c:12
#17 <signal handler called>
#18 __down_interruptible (sem=0x9f68978) at include/linux/list.h:50
#19 0x0828091a in __down_failed_interruptible () at
arch/um/sys-i386/../../x86/lib/semaphore_32.S:63
#20 0x08220a89 in ddsnap_create (target=0xa829080, argc=4, argv=0x9f6f290)
    at include/asm/arch/semaphore_32.h:120
#21 0x0821b160 in dm_table_add_target (t=0x9f6f178, type=0xa82414c "ddsnap",
start=165497564, len=204800,
    params=0xa82415c "/dev/ubdc") at drivers/md/dm-table.c:772

Looks like the problem happens when __down_interruptible is called.
I checked the semaphore passed to __down_interruptible under gdb
and found it was corrupted:
(gdb) f 18
#18 __down_interruptible (sem=0x9f68d08) at include/linux/list.h:50
50              prev->next = new;
(gdb) p sem
$15 = (struct semaphore *) 0x9f68d08
(gdb) p *sem
$16 = {count = {counter = -268435295}, sleepers = 4, wait = {lock =
{raw_lock = {<No data fields>}}, task_list = {
      next = 0x9f68d5c, prev = 0x18124}}}

But the semaphore looks correct before calling down_interruptible:
(gdb) f 20
#20 0x082209fd in ddsnap_create (target=0xa829080, argc=4, argv=0x9f733a8)
at include/asm/arch/semaphore_32.h:120
120             __asm__ __volatile__(
(gdb) p info->identify_sem
$28 = {count = {counter = -1}, sleepers = 0, wait = {lock = {raw_lock = {<No
data fields>}}, task_list = {
      next = 0x9f0ca14, prev = 0x9f0ca14}}}

I found from 2.6.25 kernel, the type of __down_failed_interruptible changed
from fastcall to extern asmregparm.
Can it be related to this problem?

Jiaying

------=_Part_54406_8557712.1216026409236
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Fri, Jul 11, 2008 at 1:02 AM, Jeff Dike &lt;<a href="mailto:jdike@addtoit.com">jdike@addtoit.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Thu, Jul 10, 2008 at 10:25:29AM +0800, Jiaying Zhang wrote:<br>
&gt; Do you have any thought about what the problem might be?<br>
&gt; Thanks a lot!<br>
<br>
</div>Yeah, my first thought is that your code is buggy.<br>
<br>
Since 2.6.25 seems OK, you can bisect between then and now to see<br>
either what caused the bug or what is triggering the crash on an<br>
existing bug.</blockquote><div><br>The 2.6.24 kernels are OK, but I have seen this problem with all of the<br>2.6.25 kernels I have tried. There have been a lot of changes between<br>2.6.24 kernels and 2.6.25 kernels. I am not sure which one may lead<br>
to this problem.<br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
The other thing you can do is gdb the UML and see if gdb gives you a<br>
better stack trace.<br>
<div><div></div><div class="Wj3C7c"></div></div></blockquote><div><br>Here is the trace from gdb uml.<br><br>Program received signal SIGTERM, Terminated.<br>0xb7fff410 in ?? ()<br>(gdb) bt<br>#0&nbsp; 0xb7fff410 in ?? ()<br>#1&nbsp; 0x08323afc in cpu0_irqstack ()<br>
#2&nbsp; 0xfffffffe in ?? ()<br>#3&nbsp; 0x0000000f in ?? ()<br>#4&nbsp; 0x464850c6 in kill () from /lib/tls/i686/cmov/libc.so.6<br>#5&nbsp; 0x0806624b in os_dump_core () at arch/um/os-Linux/util.c:92<br>#6&nbsp; 0x08059703 in panic_exit (self=0x83254f4, unused1=0, unused2=0x8340a80) at arch/um/kernel/um_arch.c:233<br>
#7&nbsp; 0x080849d0 in notifier_call_chain (nl=0x0, val=0, v=0x8340a80, nr_to_call=0, nr_calls=0x0)<br>&nbsp;&nbsp;&nbsp; at kernel/notifier.c:70<br>#8&nbsp; 0x08084a72 in __atomic_notifier_call_chain (nh=0x8340a60, val=0, v=0x8340a80, nr_to_call=-1,<br>
&nbsp;&nbsp;&nbsp; nr_calls=0x0) at kernel/notifier.c:159<br>#9&nbsp; 0x08084a89 in atomic_notifier_call_chain (nh=0x8340a60, val=0, v=0x8340a80) at kernel/notifier.c:168<br>#10 0x0807116f in panic (fmt=0x82d2039 &quot;Kernel mode fault at addr 0x%lx, ip 0x%lx&quot;) at kernel/panic.c:101<br>
#11 0x080594c1 in segv (fi={error_code = 6, cr2 = 98596, trap_no = 14}, ip=136845739, is_user=0,<br>&nbsp;&nbsp;&nbsp; regs=0x8323c6c) at arch/um/kernel/trap.c:206<br>#12 0x080592a0 in segv_handler (sig=11, regs=0x8323c6c) at arch/um/kernel/trap.c:152<br>
#13 0x0806537b in sig_handler_common (sig=11, sc=0x8323d24) at arch/um/os-Linux/signal.c:48<br>#14 0x080653b8 in sig_handler (sig=11, sc=0x8323d24) at arch/um/os-Linux/signal.c:80<br>#15 0x080654dd in handle_signal (sig=&lt;value optimized out&gt;, sc=0x8323d24) at arch/um/os-Linux/signal.c:157<br>
#16 0x08066ebf in hard_handler (sig=11) at arch/um/os-Linux/sys-i386/signal.c:12<br>#17 &lt;signal handler called&gt;<br>#18 __down_interruptible (sem=0x9f68978) at include/linux/list.h:50<br>#19 0x0828091a in __down_failed_interruptible () at arch/um/sys-i386/../../x86/lib/semaphore_32.S:63<br>
#20 0x08220a89 in ddsnap_create (target=0xa829080, argc=4, argv=0x9f6f290)<br>&nbsp;&nbsp;&nbsp; at include/asm/arch/semaphore_32.h:120<br>#21 0x0821b160 in dm_table_add_target (t=0x9f6f178, type=0xa82414c &quot;ddsnap&quot;, start=165497564, len=204800,<br>
&nbsp;&nbsp;&nbsp; params=0xa82415c &quot;/dev/ubdc&quot;) at drivers/md/dm-table.c:772<br><br>Looks like the problem happens when __down_interruptible is called.<br>I checked the semaphore passed to __down_interruptible under gdb<br>and found it was corrupted:<br>
(gdb) f 18<br>#18 __down_interruptible (sem=0x9f68d08) at include/linux/list.h:50<br>50&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prev-&gt;next = new;<br>(gdb) p sem<br>$15 = (struct semaphore *) 0x9f68d08<br>(gdb) p *sem<br>$16 = {count = {counter = -268435295}, sleepers = 4, wait = {lock = {raw_lock = {&lt;No data fields&gt;}}, task_list = {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next = 0x9f68d5c, prev = 0x18124}}}<br><br>But the semaphore looks correct before calling down_interruptible:<br>(gdb) f 20<br>#20 0x082209fd in ddsnap_create (target=0xa829080, argc=4, argv=0x9f733a8) at include/asm/arch/semaphore_32.h:120<br>
120&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __asm__ __volatile__(<br>(gdb) p info-&gt;identify_sem<br>$28 = {count = {counter = -1}, sleepers = 0, wait = {lock = {raw_lock = {&lt;No data fields&gt;}}, task_list = {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next = 0x9f0ca14, prev = 0x9f0ca14}}}<br>
<br>I found from 2.6.25 kernel, the type of __down_failed_interruptible changed from fastcall to extern asmregparm.<br>Can it be related to this problem?<br><br>Jiaying<br></div></div>

------=_Part_54406_8557712.1216026409236--


--===============1920485305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============1920485305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1920485305==--


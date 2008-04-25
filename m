Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JpU5M-0008Sw-2Q for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 12:59:56 -0700
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]
	helo=mail.esperi.org.uk)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JpU5K-0000RS-1b
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 12:59:55 -0700
From: Nix <nix@esperi.org.uk>
Date: Fri, 25 Apr 2008 20:59:38 +0100
Message-ID: <877iel7ljp.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: [uml-devel] actually useful backtrace from a CPU-chewing hang
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@linux.intel.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

I suspect this can go wrong anywhere, but it happens to have been a
CBQ-triggered gettimeofday() while sending an arp that did it. (My ADSL
router pretty much bombs the poor damn machine with ARP packets all the
time.)

#0  getnstimeofday (ts=3D0x8217d10) at include/linux/time.h:182
#1  0x080824b4 in ktime_get_ts (ts=3D0x8217d10) at kernel/hrtimer.c:122
#2  0x0808244b in ktime_get () at kernel/hrtimer.c:58
#3  0x08148d93 in cbq_dequeue (sch=3D0xdde3800) at include/net/pkt_sched.h:=
53
#4  0x08143355 in __qdisc_run (dev=3D0xded1800) at net/sched/sch_generic.c:=
85
#5  0x08137991 in dev_queue_xmit (skb=3D0xdc89380) at include/net/pkt_sched=
.h:89
#6  0x08185537 in arp_xmit (skb=3D0xdc89380) at net/ipv4/arp.c:668
#7  0x08185574 in arp_send (type=3D1, ptype=3D2054, dest_ip=3D3457507285, d=
ev=3D0xded1800, src_ip=3D2668538048, dest_hw=3D0xdd65244 "", src_hw=3D0xded=
192c "\002`\227y=E2=C1", target_hw=3D0x0) at net/ipv4/arp.c:694
#8  0x08184fb2 in arp_solicit (neigh=3D0xdd65220, skb=3D0x0) at net/ipv4/ar=
p.c:379
#9  0x0813c898 in neigh_timer_handler (arg=3D232149536) at net/core/neighbo=
ur.c:866
#10 0x08077afd in run_timer_softirq (h=3D0x823a3ec) at kernel/timer.c:664
#11 0x080740a4 in __do_softirq () at kernel/softirq.c:234
#12 0x0807412e in do_softirq () at kernel/softirq.c:271
#13 0x08074186 in irq_exit () at kernel/softirq.c:310
#14 0x080576fd in do_IRQ (irq=3D0, regs=3D0x8217ec4) at arch/um/kernel/irq.=
c:336
#15 0x080590a0 in timer_handler (sig=3D26, regs=3D0x8217ec4) at arch/um/ker=
nel/time.c:28
#16 0x08064c84 in real_alarm_handler (sc=3D0x0) at arch/um/os-Linux/signal.=
c:93
#17 0x08064cac in alarm_handler (sig=3D26, sc=3D0x0) at arch/um/os-Linux/si=
gnal.c:108
#18 0x080654a0 in deliver_alarm () at arch/um/os-Linux/time.c:117
#19 0x08065640 in idle_sleep (nsecs=3D<value optimized out>) at arch/um/os-=
Linux/time.c:181
#20 0x080580d4 in default_idle () at arch/um/kernel/process.c:248
#21 0x080580fe in cpu_idle () at arch/um/kernel/process.c:256
#22 0x081afdee in rest_init () at init/main.c:453
#23 0x0804953b in start_kernel () at init/main.c:650
#24 0x0804a7e1 in start_kernel_proc (unused=3D0x0) at arch/um/kernel/skas/p=
rocess.c:46
#25 0x08064261 in run_kernel_thread (fn=3D0x804a7b5 <start_kernel_proc>, ar=
g=3D0x0, jmp_ptr=3D0x821d184) at arch/um/os-Linux/process.c:267
#26 0x08057ee0 in new_thread_handler () at arch/um/kernel/process.c:151
#27 0x00000000 in ?? ()

(gdb) frame 1
#1  0x080824b4 in ktime_get_ts (ts=3D0x8217d10) at kernel/hrtimer.c:122
122                     getnstimeofday(ts);
(gdb) print *ts
$3 =3D {tv_sec =3D -1963377075, tv_nsec =3D 320917000}

It's stuck inside timespec_add_ns(), never leaving: this has been
inlined, so spying on its locals or parameters with GDB is pretty much a
no-hoper :/

Still, it's obvious enough to me that __get_nsec_offset() is returning a
negative value in getnstimeofday(), so timespec_add_ns() is looping,
well, not *forever*, but near enough, trying to push that u64 back down
to zero in units of NSEC_PER_SEC...

I hope this gives you a bit more of a clue.


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

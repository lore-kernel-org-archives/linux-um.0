Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JrKSP-00005e-FK for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Apr 2008 15:07:21 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user29703)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JrKSO-0002dz-K4
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Apr 2008 15:07:21 -0700
References: <877iel7ljp.fsf@hades.wkstn.nix> <87ve256146.fsf@hades.wkstn.nix>
	<871w4sqxgv.fsf@hades.wkstn.nix>
	<20080428164443.GB9628@c2.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
Date: Wed, 30 Apr 2008 22:49:27 +0100
In-Reply-To: <20080428164443.GB9628@c2.user-mode-linux.org> (Jeff Dike's
	message of "Mon, 28 Apr 2008 12:44:44 -0400")
Message-ID: <871w4n9fo8.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] actually useful backtrace from a CPU-chewing hang
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 28 Apr 2008, Jeff Dike told this:

> On Sat, Apr 26, 2008 at 07:31:44PM +0100, Nix wrote:
>> The cause of this is almost certainly time-skewing on the *host* via
>> adjtimex(). I stopped ntpd and there were no problems for half a day: I
>> restarted it, and as soon as ntpd had synched and begun slewing the time
>> (within a second of slewing beginning, probably less than that), *wham*:
>
> Can you try the patch below?  Time should definitely not go backwards
> - it's a bug if it happens.

I suspect that just a slowing of the rate of passing of time had nasty
negative consequences, because when ntpd is running resident all the
time, it should slew, not skew: yet we were getting loops on a regular
basis...

>                              If you want more a more definite
> indication about whether this is having an effect, stick a printk in
> that test and see if it shows up.

Done, and tested by stepping the time (five seconds --- five seconds per
day! I have pendulum clocks that keep better time than that!), and,
oops, instant loop as before, with this debugging patch applied, which
did not fire...

Index: i686-esperi/arch/um/os-Linux/time.c
===================================================================
--- i686-esperi.orig/arch/um/os-Linux/time.c    2008-04-29 19:34:07.000000000 +0100
+++ i686-esperi/arch/um/os-Linux/time.c 2008-04-29 20:08:50.000000000 +0100
@@ -108,7 +108,11 @@

        /* Protection against the host's time going backwards */
        if ((last_tick != 0) && (this_tick < last_tick))
+       {
+               printk(UM_KERN_ERR "Time went backwards: %llu -> %llu",
+                      last_tick, this_tick);
                this_tick = last_tick;
+       }

        if (last_tick == 0)
                last_tick = this_tick - one_tick;

getnstimeofday (ts=0x821ba2c) at include/linux/time.h:176
176             while(unlikely(ns >= NSEC_PER_SEC)) {
(gdb) bt
#0  getnstimeofday (ts=0x821ba2c) at include/linux/time.h:176
#1  0x080824e4 in ktime_get_ts (ts=0x821ba2c) at kernel/hrtimer.c:122
#2  0x0808247b in ktime_get () at kernel/hrtimer.c:58
#3  0x0814757c in tcf_act_police (skb=0xdc89800, a=0xded0e40, res=0x821bb68) at include/net/pkt_sched.h:53
#4  0x08146123 in tcf_action_exec (skb=0xdc89800, act=0xded0e40, res=0x821bb68) at net/sched/act_api.c:370
#5  0x08153779 in u32_classify (skb=0xdc89800, tp=0xde83f60, res=0x821bb68) at include/net/pkt_cls.h:127
#6  0x08144fed in tc_classify_compat (skb=0xdc89800, tp=0xde83f60, res=0x821bb68) at net/sched/sch_api.c:1203
#7  0x08145032 in tc_classify (skb=0xdc89800, tp=0xde83f60, res=0x821bb68) at net/sched/sch_api.c:1228
#8  0x08150a1a in ingress_enqueue (skb=0xdc89800, sch=0xdedc760) at net/sched/sch_ingress.c:77
#9  0x08137c31 in ing_filter (skb=0xfffffffe) at net/core/dev.c:1973
#10 0x08137db0 in netif_receive_skb (skb=0xdc89800) at net/core/dev.c:1994
#11 0x08137ecc in process_backlog (napi=0x8240650, quota=64) at net/core/dev.c:2132
#12 0x08137fc3 in net_rx_action (h=0x823a3fc) at net/core/dev.c:2202
#13 0x080740d4 in __do_softirq () at kernel/softirq.c:234
#14 0x0807415e in do_softirq () at kernel/softirq.c:271
#15 0x080741b6 in irq_exit () at kernel/softirq.c:310
#16 0x080576fd in do_IRQ (irq=5, regs=0x821bc6c) at arch/um/kernel/irq.c:336
#17 0x08057367 in sigio_handler (sig=29, regs=0x821bc6c) at arch/um/kernel/irq.c:95
#18 0x08064c07 in sig_handler_common (sig=29, sc=0x821bd24) at arch/um/os-Linux/signal.c:48
#19 0x08064c44 in sig_handler (sig=29, sc=0x821bd24) at arch/um/os-Linux/signal.c:80
#20 0x08064d67 in handle_signal (sig=-2, sc=0x821bd24) at arch/um/os-Linux/signal.c:157
#21 0x08066263 in hard_handler (sig=29) at arch/um/os-Linux/sys-i386/signal.c:12
#22 <signal handler called>
#23 getnstimeofday (ts=0xde3feec) at include/linux/time.h:182
#24 0x08084306 in do_gettimeofday (tv=0xde3ff04) at kernel/time/timekeeping.c:118
#25 0x0807396c in sys_gettimeofday (tv=0xbfdd7008, tz=0x0) at kernel/time.c:103
#26 0x0805a55c in handle_syscall (r=0xde78628) at arch/um/kernel/skas/syscall.c:35
#27 0x08066cdf in handle_trap (pid=26156, regs=0xde78628, local_using_sysemu=2) at arch/um/os-Linux/skas/process.c:202
#28 0x0806716b in userspace (regs=0xde78628) at arch/um/os-Linux/skas/process.c:418
#29 0x08057f5a in fork_handler () at arch/um/kernel/process.c:179
#30 0x00000000 in ?? ()

-- 
`If you are having a "ua luea luea le ua le" kind of day, I can only
 assume that you are doing no work due [to] incapacitating nausea caused 
 by numerous lazy demons.' --- Frossie

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

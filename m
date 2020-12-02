Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkQdL-0007hJ-HT
 for linux-um@lists.infradead.org; Wed, 02 Dec 2020 11:49:20 +0000
Message-ID: <1dfcecf63871aa26a3828f1e99227f719085fc8d.camel@sipsolutions.net>
Subject: Re: [PATCH 7/7] um: simplify IRQ handling code
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 02 Dec 2020 12:49:07 +0100
In-Reply-To: <96e31171-965d-c1d7-282e-b1b0bec6b73f@kot-begemot.co.uk>
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <20201123205446.6370687fa983.I811873233b8d71fbde9154b84c85b498521e3b12@changeid>
 <96e31171-965d-c1d7-282e-b1b0bec6b73f@kot-begemot.co.uk>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org


> run iperf -s in the UML with a vector network driver.

Btw, 'ip link set vec0 up' reports a lockdep issue.

Looks sort of legitimate, though we're not SMP, so ...


======================================================
WARNING: possible circular locking dependency detected
5.10.0-rc4-00392-gedc4ff2eb69b-dirty #147 Not tainted
------------------------------------------------------
swapper/0 is trying to acquire lock:
0000000063701138 (&result->tail_lock){+.-.}-{2:2}, at: vector_send.isra.0+0x1ba/0x280

but task is already holding lock:
00000000637010f0 (&result->head_lock){+.-.}-{2:2}, at: vector_send.isra.0+0x30/0x280

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&result->head_lock){+.-.}-{2:2}:
       save_stack_trace+0x2e/0x30
       stack_trace_save+0x34/0x39
       save_trace+0x8c/0x261
       __lock_acquire+0x1480/0x16b8
       lock_acquire+0x335/0x414
       _raw_spin_lock+0x31/0x85
       vector_net_start_xmit+0x164/0x340
       netdev_start_xmit+0x1f/0x47
       dev_hard_start_xmit+0x14b/0x230
       sch_direct_xmit+0xb0/0x248
       __qdisc_run+0x4f3/0x532
       qdisc_run+0x3d/0x51
       __dev_queue_xmit+0x2e0/0x6e8
       dev_queue_xmit+0x12/0x14
       neigh_resolve_output+0x13f/0x162
       ip6_finish_output2+0x642/0x713
       __ip6_finish_output+0xac/0xb5
       ip6_output+0xcf/0x113
       dst_output+0x72/0x7b
       NF_HOOK.constprop.0+0x115/0x124
       mld_sendpack+0x20e/0x2ba
       mld_ifc_timer_expire+0x259/0x2ab
       call_timer_fn+0x116/0x243
       __run_timers+0x207/0x246
       run_timer_softirq+0x1c/0x2c
       __do_softirq+0x1b9/0x43e
       irq_exit+0xc1/0x113
       do_IRQ+0x45/0x54
       timer_handler+0xce/0xed
       timer_real_alarm_handler+0x5c/0x5e
       unblock_signals+0x9c/0xd7
       arch_cpu_idle+0x5b/0x62
       default_idle_call+0x52/0x5e
       do_idle+0xd8/0x14b
       cpu_startup_entry+0x1e/0x20
       rest_init+0x135/0x141
       0x600016d2
       0x60001dfe
       0x60003845
       new_thread_handler+0x81/0xb2
       uml_finishsetup+0x54/0x59

-> #0 (&result->tail_lock){+.-.}-{2:2}:
       save_stack_trace+0x2e/0x30
       stack_trace_save+0x34/0x39
       save_trace+0x8c/0x261
       print_circular_bug+0x64/0x24b
       check_noncircular+0xd3/0xe3
       __lock_acquire+0x12ca/0x16b8
       lock_acquire+0x335/0x414
       _raw_spin_lock+0x31/0x85
       vector_send.isra.0+0x1ba/0x280
       vector_net_start_xmit+0x32b/0x340
       netdev_start_xmit+0x1f/0x47
       dev_hard_start_xmit+0x14b/0x230
       sch_direct_xmit+0xb0/0x248
       __qdisc_run+0x4f3/0x532
       qdisc_run+0x3d/0x51
       __dev_queue_xmit+0x2e0/0x6e8
       dev_queue_xmit+0x12/0x14
       neigh_resolve_output+0x13f/0x162
       ip6_finish_output2+0x642/0x713
       __ip6_finish_output+0xac/0xb5
       ip6_output+0xcf/0x113
       dst_output+0x72/0x7b
       NF_HOOK.constprop.0+0x115/0x124
       mld_sendpack+0x20e/0x2ba
       mld_ifc_timer_expire+0x259/0x2ab
       call_timer_fn+0x116/0x243
       __run_timers+0x207/0x246
       run_timer_softirq+0x1c/0x2c
       __do_softirq+0x1b9/0x43e
       irq_exit+0xc1/0x113
       do_IRQ+0x45/0x54
       timer_handler+0xce/0xed
       timer_real_alarm_handler+0x5c/0x5e
       unblock_signals+0x9c/0xd7
       arch_cpu_idle+0x5b/0x62
       default_idle_call+0x52/0x5e
       do_idle+0xd8/0x14b
       cpu_startup_entry+0x1e/0x20
       rest_init+0x135/0x141
       0x600016d2
       0x60001dfe
       0x60003845
       new_thread_handler+0x81/0xb2
       uml_finishsetup+0x54/0x59

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&result->head_lock);
                               lock(&result->tail_lock);
                               lock(&result->head_lock);
  lock(&result->tail_lock);

 *** DEADLOCK ***

8 locks held by swapper/0:
 #0: 0000000060687050 ((&idev->mc_ifc_timer)){+.-.}-{0:0}, at: call_timer_fn+0x0/0x243
 #1: 0000000060887e40 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire.constprop.0+0x0/0x39
 #2: 0000000060887e00 (rcu_read_lock_bh){....}-{1:2}, at: rcu_lock_acquire+0x0/0x2f
 #3: 0000000060887e00 (rcu_read_lock_bh){....}-{1:2}, at: rcu_lock_acquire+0x0/0x2f
 #4: 0000000063fa9258 (&sch->seqlock){+...}-{2:2}, at: qdisc_run_begin+0x22/0x76
 #5: 0000000063fa9140 (dev->qdisc_running_key ?: &qdisc_running_key){+...}-{0:0}, at: qdisc_run+0x16/0x51
 #6: 0000000063636e88 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x84/0x248
 #7: 00000000637010f0 (&result->head_lock){+.-.}-{2:2}, at: vector_send.isra.0+0x30/0x280

stack backtrace:
CPU: 0 PID: 0 Comm: swapper Not tainted 5.10.0-rc4-00392-gedc4ff2eb69b-dirty #147
Stack:
 605d20dd 60c14280 60686830 604765ed
 60475ac7 60c14280 60c14180 60c14280
 60686840 60477bcd 606868a0 6007f8e4
Call Trace:
 [<604765ed>] ? printk+0x0/0x94
 [<60025c1b>] show_stack+0x13e/0x14d
 [<604765ed>] ? printk+0x0/0x94
 [<60475ac7>] ? __print_lock_name+0x0/0x90
 [<60477bcd>] dump_stack+0x34/0x36
 [<6007f8e4>] print_circular_bug+0x23c/0x24b
 [<6007d8de>] ? save_trace+0x8c/0x261
 [<6007f9c6>] check_noncircular+0xd3/0xe3
 [<6007dda1>] ? hlock_class+0x1e/0x9e
 [<60080880>] ? mark_lock.part.0+0x0/0x410
 [<6007dd83>] ? hlock_class+0x0/0x9e
 [<6008304e>] __lock_acquire+0x12ca/0x16b8
 [<6003b4b5>] ? set_signals+0x37/0x3f
 [<6007dd83>] ? hlock_class+0x0/0x9e
 [<60081515>] lock_acquire+0x335/0x414
 [<6002db48>] ? vector_send.isra.0+0x1ba/0x280
 [<6047a506>] ? debug_lockdep_rcu_enabled+0x0/0x3b
 [<6047f337>] _raw_spin_lock+0x31/0x85
 [<6002db48>] ? vector_send.isra.0+0x1ba/0x280
 [<6047f306>] ? _raw_spin_lock+0x0/0x85
 [<6002db48>] vector_send.isra.0+0x1ba/0x280
 [<6047f7cb>] ? _raw_spin_unlock+0x0/0x32
 [<6002e06d>] vector_net_start_xmit+0x32b/0x340
 [<6032845a>] netdev_start_xmit+0x1f/0x47
 [<60479fa2>] ? match_held_lock+0x0/0x1de
 [<6047a506>] ? debug_lockdep_rcu_enabled+0x0/0x3b
 [<60330d44>] dev_hard_start_xmit+0x14b/0x230
 [<6047a506>] ? debug_lockdep_rcu_enabled+0x0/0x3b
 [<60367250>] sch_direct_xmit+0xb0/0x248
 [<60365ee5>] ? qdisc_qstats_cpu_qlen_dec+0x2a/0x2e
 [<60365ebb>] ? qdisc_qstats_cpu_qlen_dec+0x0/0x2e
 [<603678db>] __qdisc_run+0x4f3/0x532
 [<6047a506>] ? debug_lockdep_rcu_enabled+0x0/0x3b
 [<6032d233>] qdisc_run+0x3d/0x51
 [<603311af>] __dev_queue_xmit+0x2e0/0x6e8
 [<6047a506>] ? debug_lockdep_rcu_enabled+0x0/0x3b
 [<60338c91>] ? read_seqbegin+0x0/0xc9
 [<603315c9>] dev_queue_xmit+0x12/0x14
 [<6033d0d9>] neigh_resolve_output+0x13f/0x162
 [<6047a506>] ? debug_lockdep_rcu_enabled+0x0/0x3b
 [<603f8e94>] ip6_finish_output2+0x642/0x713
 [<603fa9ef>] __ip6_finish_output+0xac/0xb5
 [<603faad9>] ip6_output+0xcf/0x113
 [<60424cac>] ? dst_output+0x0/0x7b
 [<60424d1e>] dst_output+0x72/0x7b
 [<6042571a>] NF_HOOK.constprop.0+0x115/0x124
 [<6041058a>] ? icmp6_dst_alloc+0xea/0x103
 [<6003b47e>] ? set_signals+0x0/0x3f
 [<60425937>] mld_sendpack+0x20e/0x2ba
 [<60427902>] ? add_grec+0x0/0x3d0
 [<6047f493>] ? _raw_spin_lock_bh+0x0/0x9b
 [<60428340>] mld_ifc_timer_expire+0x259/0x2ab
 [<604280e7>] ? mld_ifc_timer_expire+0x0/0x2ab
 [<6047a506>] ? debug_lockdep_rcu_enabled+0x0/0x3b
 [<6009a795>] call_timer_fn+0x116/0x243
 [<6009a67f>] ? call_timer_fn+0x0/0x243
 [<6009b02e>] __run_timers+0x207/0x246
 [<604280e7>] ? mld_ifc_timer_expire+0x0/0x2ab
 [<6047f52e>] ? _raw_spin_lock_irq+0x0/0xb2
 [<6003b4a7>] ? set_signals+0x29/0x3f
 [<6047a4f4>] ? lock_is_held_type+0x135/0x147
 [<6047a362>] ? lockdep_hardirqs_on+0x1e2/0x23f
 [<6009ae27>] ? __run_timers+0x0/0x246
 [<6009b089>] run_timer_softirq+0x1c/0x2c
 [<60480331>] __do_softirq+0x1b9/0x43e
 [<600953e3>] ? unmask_irq+0x0/0x37
 [<6047f7cb>] ? _raw_spin_unlock+0x0/0x32
 [<60022c6b>] ? rcu_lock_acquire.constprop.0+0x0/0x39
 [<600492c8>] irq_exit+0xc1/0x113
 [<60049205>] ? irq_enter+0x10/0x12
 [<60024138>] do_IRQ+0x45/0x54
 [<6003b47e>] ? set_signals+0x0/0x3f
 [<60026ba5>] timer_handler+0xce/0xed
 [<600838e7>] ? lock_release+0x0/0x36c
 [<60061e0a>] ? find_task_by_pid_ns+0x0/0x97
 [<6003b03a>] timer_real_alarm_handler+0x5c/0x5e
 [<6003b439>] unblock_signals+0x9c/0xd7
 [<60024dac>] arch_cpu_idle+0x5b/0x62
 [<60097200>] ? rcu_read_lock_sched_held+0x2d/0x34
 [<600709f6>] ? trace_cpu_idle.constprop.0+0x0/0xa1
 [<6047f2aa>] default_idle_call+0x52/0x5e
 [<600838e7>] ? lock_release+0x0/0x36c
 [<60061e0a>] ? find_task_by_pid_ns+0x0/0x97
 [<6003b474>] ? get_signals+0x0/0xa
 [<60070c21>] do_idle+0xd8/0x14b
 [<6047ba87>] ? schedule+0x95/0xd6
 [<60070b49>] ? do_idle+0x0/0x14b
 [<6007101f>] cpu_startup_entry+0x1e/0x20
 [<60071001>] ? cpu_startup_entry+0x0/0x20
 [<6047a506>] ? debug_lockdep_rcu_enabled+0x0/0x3b
 [<6047a6c5>] rest_init+0x135/0x141
 [<6047a590>] ? rest_init+0x0/0x141
 [<6003b474>] ? get_signals+0x0/0xa
 [<604765ed>] ? printk+0x0/0x94
 [<602b569e>] ? strlen+0x0/0x11
 [<600016d2>] 0x600016d2
 [<60001dfe>] 0x60001dfe
 [<6003b38c>] ? block_signals+0x0/0x11
 [<60003845>] 0x60003845
 [<60024816>] new_thread_handler+0x81/0xb2
 [<600037fa>] ? 0x600037fa
 [<600284b7>] uml_finishsetup+0x54/0x59

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


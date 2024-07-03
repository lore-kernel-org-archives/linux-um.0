Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69843C2BD09
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 16:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Date:Cc:To:From:Subject:Message-ID:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZiMS0qQI5jg+CMgMmDD/9HNb1t9HoA9+IbxjKA3RcE4=; b=xV/X1ABPcswiBAfNDHqxRCN/yG
	z6zhDis1l93q9NqV+2vz7B4PGsBw+TFPpYccqK7Iq7h3RB9rPyZUi3K7J84orVjiOuuYgE4gBYZM6
	x0KDx7KwxYkB4+HI8CJ+iklUty2waBX/GfIky+g13T8tMYaWnYIMuxTuzcAQ9HgB+MNZDjGq9bd7I
	OgELHZ7k80+QMxNsSKjlaIwDjrPnmCLbP8mC1XX1y+vyCTyDfpcz0AKlH0SL8b8ouB29cy0zWeZhE
	Pgj1o06ZCobpE3+Rqanq1fIt5+TdqfDLspKjzDoLNHZhU2NSiQHCXM0tb+/j3jtVG9dAyNzKe1yuF
	chjOEWMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP2oH-0000000AqwV-3qKR;
	Wed, 03 Jul 2024 16:26:21 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP2oF-0000000Aqw3-2ycY
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 16:26:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ZiMS0qQI5jg+CMgMmDD/9HNb1t9HoA9+IbxjKA3RcE4=; t=1720023978; x=1721233578; 
	b=DkFXOC6ZxbeSBnPqv2c+Ift8bOE63mGEHu97izMMj07wp2Vf0xEbwMkLMUbvFJaR4yRRAky3jCL
	4qt+K3OkAkcTPGCQDGBnJf6Ty1aK7jbjKx/w2cyFVK2YrX35lLVVJRQQka6N546qR2t+e1gyJzWft
	+hgZF2vT2JroBTKGdOfU3nNm4kpkE308fpfdkUbOu5bR2/OR6B/ie/rHlYpr48lv/PgZz/UgaeYzv
	3/MVN85nKrHufwrgs+YuX7IBBPJ5kEyHZW1hSPvJ9WRFN4OZTCe36ShKt71IL/K1hRKU5C9ReU11J
	mO0pHh12XQMaKzZdHaj4cJRpfPNn5Cb4/7oQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sP2oA-00000009YYM-3hzu;
	Wed, 03 Jul 2024 18:26:15 +0200
Message-ID: <5ed84d2486ebdb7b992eff37a8c6956d573dddb3.camel@sipsolutions.net>
Subject: vector: spinlock ordering problems
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Date: Wed, 03 Jul 2024 18:26:14 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_092619_772905_58B2B648 
X-CRM114-Status: UNSURE (   3.51  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Lockdep reports a spinlock ordering problem: sometimes we take head_lock
first, sometimes tail_lock, so there's a classic ABBA deadlock possible.
It may not happen now because of UML being single-CPU and all that, but
perhaps with preempt?

Report:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
6.10.0-rc6-00036-gcd01672d64a3 #26 Not tainted
------------------------------------------------------
systemd-network/105 is trying to acquire lock:
00000000622bd8b0 (&result->tail_lock){+...}-{2:2}, at: vector_send+0x1c5/0x=
266

but task is already holding lock:
00000000622bd870 (&result->head_lock){+...}-{2:2}, at: vector_send+0x3b/0x2=
66

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&result->head_lock){+...}-{2:2}:
       save_stack_trace+0x32/0x34
       stack_trace_save+0x38/0x3d
       save_trace+0x90/0x268
       __lock_acquire+0x146c/0x15a4
       lock_acquire+0x2e1/0x38d
       _raw_spin_lock+0x43/0x5a
       vector_net_start_xmit+0x1ef/0x3bd
       netdev_start_xmit+0x51/0x80
       dev_hard_start_xmit+0x137/0x22f
       sch_direct_xmit+0xc6/0x2a3
       __dev_queue_xmit+0x3da/0x877
       packet_xmit+0x3c/0xf2
       packet_sendmsg+0x106a/0x10d0
       sock_sendmsg_nosec+0x1c/0x98
       __sys_sendto+0x113/0x147
       sys_sendto+0x14/0x18
       handle_syscall+0xa8/0xd8
       userspace+0x323/0x4e5
       fork_handler+0x8c/0x8e

-> #0 (&result->tail_lock){+...}-{2:2}:
       save_stack_trace+0x32/0x34
       stack_trace_save+0x38/0x3d
       save_trace+0x90/0x268
       print_circular_bug+0x68/0x2b5
       check_noncircular+0x11c/0x12c
       __lock_acquire+0x12a4/0x15a4
       lock_acquire+0x2e1/0x38d
       _raw_spin_lock+0x43/0x5a
       vector_send+0x1c5/0x266
       vector_net_start_xmit+0x394/0x3bd
       netdev_start_xmit+0x51/0x80
       dev_hard_start_xmit+0x137/0x22f
       sch_direct_xmit+0xc6/0x2a3
       __dev_queue_xmit+0x3da/0x877
       packet_xmit+0x3c/0xf2
       packet_sendmsg+0x106a/0x10d0
       sock_sendmsg_nosec+0x1c/0x98
       __sys_sendto+0x113/0x147
       sys_sendto+0x14/0x18
       handle_syscall+0xa8/0xd8
       userspace+0x323/0x4e5
       fork_handler+0x8c/0x8e

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&result->head_lock);
                               lock(&result->tail_lock);
                               lock(&result->head_lock);
  lock(&result->tail_lock);

 *** DEADLOCK ***

4 locks held by systemd-network/105:
 #0: 0000000060749920 (rcu_read_lock_bh){....}-{1:2}, at: rcu_lock_acquire+=
0x16/0x30
 #1: 0000000066a47210 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-=
{2:2}, at: qdisc_run_begin+0x2e/0x66
 #2: 000000006227f690 (_xmit_ETHER#2){+...}-{2:2}, at: sch_direct_xmit+0x9b=
/0x2a3
 #3: 00000000622bd870 (&result->head_lock){+...}-{2:2}, at: vector_send+0x3=
b/0x266

stack backtrace:
CPU: 0 PID: 105 Comm: systemd-network Not tainted 6.10.0-rc6-00036-gcd01672=
d64a3 #26
Stack:
 812c7710 604c0e3b 000000ea 00000000
 ffffff00 6064f6f1 604de3a0 6063beda
 812c7740 604e8b7c 000000ec 604df56f
Call Trace:
 [<604df56f>] ? _printk+0x0/0x98
 [<6002b386>] show_stack+0x141/0x150
 [<604c0e3b>] ? dump_stack_print_info+0xe2/0xf1
 [<604de3a0>] ? __print_lock_name+0x0/0xbd
 [<604e8b7c>] dump_stack_lvl+0x71/0xb8
 [<604df56f>] ? _printk+0x0/0x98
 [<604e8be1>] dump_stack+0x1e/0x20
 [<6009348a>] print_circular_bug+0x2a6/0x2b5
 [<600c8e7d>] ? stack_trace_save+0x38/0x3d
 [<60090fbf>] ? save_trace+0x90/0x268
 [<600935b5>] check_noncircular+0x11c/0x12c
 [<600acb42>] ? rcu_read_lock_any_held+0x40/0x9c
 [<604ea4ec>] ? __this_cpu_preempt_check+0x14/0x16
 [<60091cc6>] ? lookup_chain_cache+0x4e/0x130
 [<60090d22>] ? hlock_class+0x0/0xa3
 [<600963be>] __lock_acquire+0x12a4/0x15a4
 [<604ea4d8>] ? __this_cpu_preempt_check+0x0/0x16
 [<60095034>] lock_acquire+0x2e1/0x38d
 [<60034e49>] ? vector_send+0x1c5/0x266
 [<604e9cf7>] ? debug_lockdep_rcu_enabled+0x0/0x3f
 [<604e9cf7>] ? debug_lockdep_rcu_enabled+0x0/0x3f
 [<604f2532>] _raw_spin_lock+0x43/0x5a
 [<60034e49>] ? vector_send+0x1c5/0x266
 [<604f24ef>] ? _raw_spin_lock+0x0/0x5a
 [<60034e49>] vector_send+0x1c5/0x266
 [<604f28bb>] ? _raw_spin_unlock+0x0/0x7c
 [<6003538c>] vector_net_start_xmit+0x394/0x3bd
 [<604ea4d8>] ? __this_cpu_preempt_check+0x0/0x16
 [<603d0711>] netdev_start_xmit+0x51/0x80
 [<600b09cd>] ? rcu_is_watching+0x0/0x6f
 [<603d79f9>] dev_hard_start_xmit+0x137/0x22f
 [<6041a35b>] sch_direct_xmit+0xc6/0x2a3
 [<603d15a7>] ? qdisc_run_end+0x0/0x52
 [<603d7f6b>] __dev_queue_xmit+0x3da/0x877
 [<603b3f55>] ? skb_set_owner_w+0x96/0x9b
 [<604ba1b5>] packet_xmit+0x3c/0xf2
 [<604bfbc2>] packet_sendmsg+0x106a/0x10d0
 [<6002e30a>] ? copy_chunk_from_user+0x26/0x30
 [<6002e2e4>] ? copy_chunk_from_user+0x0/0x30
 [<6002e592>] ? do_op_one_page+0x9d/0xa9
 [<60150008>] ? __gup_longterm_locked+0x39b/0x618
 [<603af0f0>] sock_sendmsg_nosec+0x1c/0x98
 [<603b13ca>] __sys_sendto+0x113/0x147
 [<600f8264>] ? __seccomp_filter+0xa9/0x3c7
 [<6004682f>] ? switch_threads+0x28/0x57
 [<603b1412>] sys_sendto+0x14/0x18
 [<6002e252>] handle_syscall+0xa8/0xd8
 [<60046631>] userspace+0x323/0x4e5
 [<6002a494>] ? interrupt_end+0x0/0xe4
 [<6002a3c3>] fork_handler+0x8c/0x8e



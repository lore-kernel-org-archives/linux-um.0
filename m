Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76A6CD4F35
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 09:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ofCE0+FLiGKdJneGGlfrLqFlgQdvy8FZ71w5qVn7T/k=; b=Q1fyue+PtvTo9J
	h4fRpNR0bT4+6H58lSfD1max47G1n5hRdYXdfALDH7+zRec0d9r5TszObzRtioVXou5zOG+aX633T
	a84FrNePM/JBpJZoYd7TLvjOpBFIqXJfIsVs98Lb6NuIB4s9+8hs58QZMGUpLos/lg6+Waqqh2KJa
	Cw7WiCO1Q1Q/w8Y6LUDY1yfLO72JrvlvIb5B0vR6xlKWhy09C7xpo7l78BffvcapMr3P5bOyN1bfK
	nIOeFam/msTx4/m4AGRDf3heHJpCix4qS0gbE2t/s8GlWLroKzfVVH/dwp/7TcudyzRNU1DjQyJ9V
	C3JKM8x2L5KwfYt1cdWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjcBJ-008WOc-2t;
	Fri, 22 Sep 2023 09:10:37 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjcBH-008WNw-2D
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 09:10:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vN1SPF6uCSM985h4WTMNaVG48p6COndEGgfYpYJeqqg=;
	t=1695373835; x=1696583435; b=AIDZYlFiH9/VdDih1ATC2bDlprWDdCBnC+EpQpTT3/H1zUx
	wisQljEKFeZd4z1enVpRiRN317P45PUwzZLD/X4kgbv85oIpZRyR4xhUBxotBhjVp9m/Y57Z83VX6
	isYwrgdnXhRPItY5CwGe3ti0b25UuqzcVw+RiGqbR4V1+HCC2sKfm93jOrMxp3FXvF6nYXp20wfPD
	fn8ydi3/AzW5EDDo09bAEVj3PzEK36Auh0V54Yz9IDt593S7SqqCNlyEHifCQhxy8enVvaO5Fi7OV
	wbbtpCczPghAYNyUrwEcu9fxF1Yzsssc3NrgEkgVRFGap6DUIl4NEEQBLXOThDEA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjcBF-00F5ce-1M;
	Fri, 22 Sep 2023 11:10:33 +0200
Message-ID: <efaa802bcd0369665b3dbc10030c9ca88aa2cb30.camel@sipsolutions.net>
Subject: Re: [PATCH v5] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Fri, 22 Sep 2023 11:10:32 +0200
In-Reply-To: <40babfb4-ed65-dd0e-23aa-abdfaa9c7149@cambridgegreys.com>
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
	 <fae1103161cf8c7bac8a138b267d2288ebb32a08.camel@sipsolutions.net>
	 <fa4069f1-e026-7672-4f71-9319cdd683a2@cambridgegreys.com>
	 <2de07f54b33dc060b75d982d4d8189f12e0d4c45.camel@sipsolutions.net>
	 <28f0be57-829b-9ddf-7b0d-a6c84932cbda@cambridgegreys.com>
	 <423e8ee5126e1dffda5f8877d07611a21972eea7.camel@sipsolutions.net>
	 <210bd25b2dcd9e4424923f55053086f67e219cc4.camel@sipsolutions.net>
	 <40babfb4-ed65-dd0e-23aa-abdfaa9c7149@cambridgegreys.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_021035_722567_0DBB7497 
X-CRM114-Status: GOOD (  16.48  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, 2023-09-22 at 10:06 +0100, Anton Ivanov wrote:
> On 22/09/2023 09:41, Johannes Berg wrote:
> > > Yes, but when does the fork actually happen?
> > > 
> > Looking further at this, now I'm confused as to why it doesn't happen
> > _all_ the time.
> > 
> > I think this has pretty much always been wrong, just now we actually
> > notice it?
> > 
> > Basically, when we create a new thread (really just mm I think), we say
> > the first thing that has to run there is fork_handler(), which
> > initialises things the first time around. This calls force_flush_all()
> > 
> > But of course it's called from __schedule(), which has
> > preemption/interrupts disabled. So you can't do mmap_read_lock()?
> 
> Stupid question.
> 
> If we have preemption and interrupts disabled and we are UP do we really need to lock it at this point?

Heh.

Functionally, I guess not. But lockdep gets really unhappy about stuff
in there:

=============================
WARNING: suspicious RCU usage
6.6.0-rc1 #159 Not tainted
-----------------------------
lib/maple_tree.c:840 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by startup.sh/282.

stack backtrace:
CPU: 0 PID: 282 Comm: startup.sh Not tainted 6.6.0-rc1 #159
Stack:
 71a9bdd0 605001f3 00000000 6003cf40
 606bd782 00000000 60b3e968 00000000
 71a9be10 60526292 00000082 6051cb2a
Call Trace:
 [<6051cb2a>] ? _printk+0x0/0x94
 [<6002a5b4>] show_stack+0x13d/0x14c
 [<605001f3>] ? dump_stack_print_info+0xde/0xed
 [<6003cf40>] ? um_set_signals+0x0/0x3f
 [<60526292>] dump_stack_lvl+0x62/0x96
 [<6051cb2a>] ? _printk+0x0/0x94
 [<605262e0>] dump_stack+0x1a/0x1c
 [<6008865e>] lockdep_rcu_suspicious+0x10d/0x11c
 [<6052721b>] ? debug_lockdep_rcu_enabled+0x0/0x3b
 [<6052721b>] ? debug_lockdep_rcu_enabled+0x0/0x3b
 [<605085cd>] mas_root+0x86/0x91
 [<60508547>] ? mas_root+0x0/0x91
 [<60508611>] mas_start+0x39/0x9c
 [<60508875>] ? mas_state_walk+0x0/0x3e
 [<6050888d>] mas_state_walk+0x18/0x3e
 [<605088f1>] mas_walk+0x3e/0x96
 [<60508a03>] mas_find_setup+0xba/0xcd
 [<60509d49>] ? mas_find+0x0/0x4a
 [<60509d71>] mas_find+0x28/0x4a
 [<6002c92b>] force_flush_all+0x51/0x7c
 [<6002926e>] fork_handler+0x14/0x96


johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

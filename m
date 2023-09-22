Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4213CD4F2B
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 07:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vN5IxfCPqgByJ8FyqKruqSdxvqCM5koE6CiHp4ENJtM=; b=yppDTaQpCYDUHB
	nTGiI73B8NTZYSOODhGT5cPPpCG3ZmpiHzhhKco//WIk4vYG5zzCihIA390R0dSxlr1ZG6GTmGdYW
	/yH53/tTBD4e8aFTpRub0BMK8s4aHRelgERylFRqdEYhcQGKZ8t4CQsKQPitCLj8EPytjKXazGDbl
	M1JeNaFRTU55ohPxiJW3EfnIZ2zOwPBXq3svdlBPqdpVGCaxLoRbJlhY4dYYpNjSBFLnxtP1hkIVP
	h0IbAeYCGW0jOmJslIFlwS8xc8qLp5Chjub/0tHnuUihIQ4hDuzp2LSmJI1Ab5sC4q50d1cNGPXai
	HfTDVIYN1zVMC4sr1ZWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjacL-008CAv-1r;
	Fri, 22 Sep 2023 07:30:25 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjacI-008C9e-28
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 07:30:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=N/RU0YqUWyxSd6EqRw/UtQflXSNEVrxouvr7i19/kFU=;
	t=1695367813; x=1696577413; b=UhZSHE+mIPvkMbkbm7wCUupgQEInrv2Ia+n0bQLOJ1UGeVp
	+eXASiZf2CgKXZpVGW8yP3f+EQUUSbejGFlGcZ+LfiaN9V4RqejHNC5M7tKcoeW42TPu5tkEv1Nfe
	RVKymN+SZa5MpNPKM/xON3ocRPXmGUiPnTsRsx+J4kMu19l27L2keetTDSg7abQXlDBvVC85C+fMG
	oWbUL2IUA68xdF7f8GgxMHHPGTWN/9cuA7d03w7usFNBHkN4T8OS67ElIBUsuK5LQVq6KVvp6LfCp
	ZiWvKEe+vLcwaEj1k+LNrkku7kg0JdEATf9X+dgFKI7exRugWsEszBhnyGNUij/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjac6-00EyzY-1t;
	Fri, 22 Sep 2023 09:30:10 +0200
Message-ID: <fae1103161cf8c7bac8a138b267d2288ebb32a08.camel@sipsolutions.net>
Subject: Re: [PATCH v5] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Fri, 22 Sep 2023 09:30:09 +0200
In-Reply-To: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_003023_203992_527A1C8D 
X-CRM114-Status: GOOD (  13.46  )
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

On Fri, 2023-09-22 at 07:52 +0100, anton.ivanov@cambridgegreys.com
wrote:
> 
> +++ b/arch/um/include/asm/processor-generic.h
> @@ -44,6 +44,9 @@ struct thread_struct {
>  			} cb;
>  		} u;
>  	} request;
> +#if defined(CONFIG_PREEMPT) || defined(CONFIG_PREEMPT_VOLUNTARY)
> +    u8 fpu[2048] __aligned(64); /* Intel docs require xsave/xrestore area to be aligned to 64 bytes */
> +#endif

Looks like you used spaces instead of tabs in a few places such as here.

> +#ifdef CONFIG_64BIT
> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
> +		__builtin_ia32_xsaveopt64(&current->thread.fpu, KNOWN_387_FEATURES);
> +	else {
> +		if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
> +			__builtin_ia32_xsave64(&current->thread.fpu, KNOWN_387_FEATURES);
> +		else
> +			__builtin_ia32_fxsave64(&current->thread.fpu);
> +	}

Still think the else if chains would look better, but it also doesn't
matter much.

>  	mm = &init_mm;
>  	hvc = INIT_HVC(mm, force, userspace);
> +
> +    preempt_disable();


Also here spaces instead of tabs. Interesting you display tabs as 4
spaces when the kernel really does everything with tabs being 8 spaces
wide :)

But anyway that's all nitpicking, the real problem I found when running
this now was this:

BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1519
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 282, name: startup.sh
preempt_count: 2, expected: 0
no locks held by startup.sh/282.
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<0000000060044b82>] copy_process+0xa02/0x244e
softirqs last  enabled at (0): [<0000000060044b82>] copy_process+0xa02/0x244e
softirqs last disabled at (0): [<0000000000000000>] 0x0
CPU: 0 PID: 282 Comm: startup.sh Not tainted 6.6.0-rc1 #147
Stack:
 7229be60 60500273 00000002 6003cfc9
 606bd782 00000000 60b3e968 00000000
 7229bea0 60526312 00000081 00000000
Call Trace:
 [<6051cbaa>] ? _printk+0x0/0x94
 [<6002a5b4>] show_stack+0x13d/0x14c
 [<60500273>] ? dump_stack_print_info+0xde/0xed
 [<6003cfc9>] ? um_set_signals+0x0/0x3f
 [<60526312>] dump_stack_lvl+0x62/0x96
 [<6051cbaa>] ? _printk+0x0/0x94
 [<6052729b>] ? debug_lockdep_rcu_enabled+0x0/0x3b
 [<60526360>] dump_stack+0x1a/0x1c
 [<60073561>] __might_resched+0x2bb/0x2d9
 [<60073640>] __might_sleep+0xc1/0xcb
 [<6052bad8>] down_read+0x32/0x1c3
 [<6002c94e>] force_flush_all+0x74/0x105
 [<6002926e>] fork_handler+0x14/0x96


I had enabled CONFIG_DEBUG_ATOMIC_SLEEP because that's actually
something I'd really like to have in our testing.

But with that issue I don't even know how we get there really. It
doesn't even happen every time we fork?

I'll dig a little bit, but did you try enabling
CONFIG_DEBUG_ATOMIC_SLEEP also?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

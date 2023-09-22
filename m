Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA44ECD4F2B
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 07:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YnNxw3kqbptg2NdoZS86E1+bz8PikGCTHNLXNRlYYsE=; b=448HffbS+NaamS
	4Ed0WB7peIJNBKWLFBMKK1VwcI7EtMx9FdRx41YLeEdOn8oaRDFCgjK97FYeUh48K4nrGQnJTmAFr
	eUQ+XiJwY59wGHFWA72Q5jnr8Qbf5j8YXACxA5chWYhaTUNgCz5LH0lpmo9CDLIU5WDHFVkXy+HHa
	bqdorj7FJqSp1+74vDFVdoqRDLjGOBB+eM3dd1gNcEFXfvK4Ep0RiQmHmctF0uA5CZLH53LrQLcEs
	tUk5Az6Yk4h5un75e7HtuAdI9u93YBlmWFIh4RVBHfS2T2xiWxqAVG/rRPM5ymuzWwyvXUUeZ0rUZ
	0XTc17qs/MRm8sFCmWXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjakZ-008Dfj-2D;
	Fri, 22 Sep 2023 07:38:55 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjakV-008DeG-36
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 07:38:53 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjakS-002b5R-0h; Fri, 22 Sep 2023 07:38:48 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjakP-00254d-AX; Fri, 22 Sep 2023 08:38:47 +0100
Message-ID: <fa4069f1-e026-7672-4f71-9319cdd683a2@cambridgegreys.com>
Date: Fri, 22 Sep 2023 08:38:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5] um: Enable preemption in UML
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
 <fae1103161cf8c7bac8a138b267d2288ebb32a08.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <fae1103161cf8c7bac8a138b267d2288ebb32a08.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_003851_998536_DA650A9D 
X-CRM114-Status: GOOD (  23.33  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org


On 22/09/2023 08:30, Johannes Berg wrote:
> On Fri, 2023-09-22 at 07:52 +0100, anton.ivanov@cambridgegreys.com
> wrote:
>> +++ b/arch/um/include/asm/processor-generic.h
>> @@ -44,6 +44,9 @@ struct thread_struct {
>>   			} cb;
>>   		} u;
>>   	} request;
>> +#if defined(CONFIG_PREEMPT) || defined(CONFIG_PREEMPT_VOLUNTARY)
>> +    u8 fpu[2048] __aligned(64); /* Intel docs require xsave/xrestore area to be aligned to 64 bytes */
>> +#endif
> Looks like you used spaces instead of tabs in a few places such as here.

Ack. I am not sure how they got there.

My environment is configured to use tabs when working on the kernel tree.

>
>> +#ifdef CONFIG_64BIT
>> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
>> +		__builtin_ia32_xsaveopt64(&current->thread.fpu, KNOWN_387_FEATURES);
>> +	else {
>> +		if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
>> +			__builtin_ia32_xsave64(&current->thread.fpu, KNOWN_387_FEATURES);
>> +		else
>> +			__builtin_ia32_fxsave64(&current->thread.fpu);
>> +	}
> Still think the else if chains would look better, but it also doesn't
> matter much.
>
>>   	mm = &init_mm;
>>   	hvc = INIT_HVC(mm, force, userspace);
>> +
>> +    preempt_disable();
>
> Also here spaces instead of tabs. Interesting you display tabs as 4
> spaces when the kernel really does everything with tabs being 8 spaces
> wide :)
>
> But anyway that's all nitpicking, the real problem I found when running
> this now was this:
>
> BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1519
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 282, name: startup.sh
> preempt_count: 2, expected: 0
> no locks held by startup.sh/282.
> irq event stamp: 0
> hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> hardirqs last disabled at (0): [<0000000060044b82>] copy_process+0xa02/0x244e
> softirqs last  enabled at (0): [<0000000060044b82>] copy_process+0xa02/0x244e
> softirqs last disabled at (0): [<0000000000000000>] 0x0
> CPU: 0 PID: 282 Comm: startup.sh Not tainted 6.6.0-rc1 #147
> Stack:
>   7229be60 60500273 00000002 6003cfc9
>   606bd782 00000000 60b3e968 00000000
>   7229bea0 60526312 00000081 00000000
> Call Trace:
>   [<6051cbaa>] ? _printk+0x0/0x94
>   [<6002a5b4>] show_stack+0x13d/0x14c
>   [<60500273>] ? dump_stack_print_info+0xde/0xed
>   [<6003cfc9>] ? um_set_signals+0x0/0x3f
>   [<60526312>] dump_stack_lvl+0x62/0x96
>   [<6051cbaa>] ? _printk+0x0/0x94
>   [<6052729b>] ? debug_lockdep_rcu_enabled+0x0/0x3b
>   [<60526360>] dump_stack+0x1a/0x1c
>   [<60073561>] __might_resched+0x2bb/0x2d9
>   [<60073640>] __might_sleep+0xc1/0xcb
>   [<6052bad8>] down_read+0x32/0x1c3
>   [<6002c94e>] force_flush_all+0x74/0x105
TLB once again by the look of it.
>   [<6002926e>] fork_handler+0x14/0x96
>
>
> I had enabled CONFIG_DEBUG_ATOMIC_SLEEP because that's actually
> something I'd really like to have in our testing.
>
> But with that issue I don't even know how we get there really. It
> doesn't even happen every time we fork?
>
> I'll dig a little bit, but did you try enabling
> CONFIG_DEBUG_ATOMIC_SLEEP also?

Will do. I have no crashes over here so I need to trigger this one first.

Though, frankly, if it is a race in a tlb flush it may be subject to local conditions. So it will be difficult to reproduce.

>
> johannes
>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

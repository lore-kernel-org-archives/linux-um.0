Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA19D74EE2
	for <linux-um@archiver.kernel.org>; Fri, 23 Jan 2026 15:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bZOD1qxujIU3XqsrT9Q0is3A3LXGMfjZia6aaXxikQM=; b=0FlW+7qXI09lxyQ1q0p8ySvZbz
	1DTvUWRwIHIryWUiXdV5qthy5TaPW+G/g3rPiHtix8PeZmt2pBZCIggdLzgvGx3oRafvoISErBq7m
	UO/x64esUv+gU/S4C1OJ5g5fPF0pZTWlCMrRhNs2IiOp1RLuTwwrVXOvTNVA0bworXjOY1oa9jwEb
	1cgBSfBKweTWvP8XN2+1yOyQ8JYunuSSP0n9b0pce4U/86ifZH3DZovaoPMyo+5EeWdGGwmVYGYNc
	rbRBLGJIh/+tms+tEugmjLlKt8uyN56frF+i+PqhoGZoZ36E7Ve5ddk4v8fM0zo2hrjApBK4ty4qE
	KAD6rOug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjItK-000000095Gu-1XfY;
	Fri, 23 Jan 2026 15:16:06 +0000
Received: from smtp-out3.simply.com ([94.231.106.210])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjItG-000000095GH-0fRy
	for linux-um@lists.infradead.org;
	Fri, 23 Jan 2026 15:16:04 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dyM2M6CZPz1DHVR;
	Fri, 23 Jan 2026 16:15:55 +0100 (CET)
Received: from [10.10.15.21] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4dyM2M10Vkz1FDXX;
	Fri, 23 Jan 2026 16:15:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769181355;
	bh=bZOD1qxujIU3XqsrT9Q0is3A3LXGMfjZia6aaXxikQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ag1WRAWJtsN0/+CXBOsevJVeLpSL3/UnOj7eGnW5g7r2ql6jKEN6uMQEFz39jpWTj
	 70hB6mp8Ve1s6Wp5eFrGmiH/PwtssmQd+OO1x2dJ25+zQ8YZn2M7a8oa0nbx1j6rlf
	 1jVZ+eG2KhetS8xTd2rubzhycPTOvv5H3QVv5BOpKDJUbmQFZnHbjmifqmRJK+rcmN
	 m8LMVMH5b3JJXy0dqOhyCLj8N4ZpFxTGlppCWijPb5T9bTpg9tndXUgxZ+8Iusk4Vm
	 o7IvTCBgZd7VuKCb0Zw5Xn08LvlpLoHpw8Ts3iS9q1RU+69VDDLKM0eepskCzawiEl
	 rXuEIPQaRFOug==
Message-ID: <9199f28e-e2b7-48c8-b61f-0b787e322443@gaisler.com>
Date: Fri, 23 Jan 2026 16:15:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] mm: make PT_RECLAIM depends on
 MMU_GATHER_RCU_TABLE_FREE
To: Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
 akpm@linux-foundation.org, david@kernel.org, ioworker0@gmail.com,
 linmag7@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>,
 sparclinux <sparclinux@vger.kernel.org>
References: <cover.1765963770.git.zhengqi.arch@bytedance.com>
 <ac2bdb2a66da1edb24f60d1da1099e2a0b734880.1765963770.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <ac2bdb2a66da1edb24f60d1da1099e2a0b734880.1765963770.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260123_071602_570425_CCB8F491 
X-CRM114-Status: GOOD (  17.33  )
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

On 2025-12-17 10:45, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> The PT_RECLAIM can work on all architectures that support
> MMU_GATHER_RCU_TABLE_FREE, so make PT_RECLAIM depends on
> MMU_GATHER_RCU_TABLE_FREE.
> 
> BTW, change PT_RECLAIM to be enabled by default, since nobody should want
> to turn it off.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  arch/x86/Kconfig | 1 -
>  mm/Kconfig       | 9 ++-------
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 80527299f859a..0d22da56a71b0 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -331,7 +331,6 @@ config X86
>  	select FUNCTION_ALIGNMENT_4B
>  	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>  	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> -	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
>  	select ARCH_SUPPORTS_SCHED_SMT		if SMP
>  	select SCHED_SMT			if SMP
>  	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
> diff --git a/mm/Kconfig b/mm/Kconfig
> index bd0ea5454af82..fc00b429b7129 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1447,14 +1447,9 @@ config ARCH_HAS_USER_SHADOW_STACK
>  	  The architecture has hardware support for userspace shadow call
>            stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>  
> -config ARCH_SUPPORTS_PT_RECLAIM
> -	def_bool n
> -
>  config PT_RECLAIM
> -	bool "reclaim empty user page table pages"
> -	default y
> -	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
> -	select MMU_GATHER_RCU_TABLE_FREE
> +	def_bool y
> +	depends on MMU_GATHER_RCU_TABLE_FREE
>  	help
>  	  Try to reclaim empty user page table pages in paths other than munmap
>  	  and exit_mmap path.

Hi,

This patch unfortunately results in a WARN_ON_ONCE and unaligned
accesses on sparc64:

$ stress-ng --mmaphuge 20 -t 60
stress-ng: info:  [559] setting to a 1 min run per stressor
stress-ng: info:  [559] dispatching hogs: 20 mmaphuge
[  560.592569] ------------[ cut here ]------------
[  560.592663] WARNING: kernel/rcu/tree.c:3098 at __call_rcu_common.constprop.0+0x200/0x760, CPU#4: stress-ng-mmaph/568
[  560.592777] CPU: 4 UID: 1000 PID: 568 Comm: stress-ng-mmaph Not tainted 6.19.0-rc5-00127-g62fc9f6ccb97 #8 VOLUNTARY
[  560.592805] Call Trace:
[  560.592812] [<00000000004368b8>] dump_stack+0x8/0x60
[  560.592844] [<0000000000482a60>] __warn+0xe0/0x140
[  560.592878] [<0000000000482b64>] warn_slowpath_fmt+0xa4/0x120
[  560.592901] [<0000000000526a40>] __call_rcu_common.constprop.0+0x200/0x760
[  560.592931] [<0000000000526fd0>] call_rcu+0x10/0x20
[  560.592954] [<0000000000730838>] tlb_remove_table+0x98/0xc0
[  560.592986] [<000000000071bec4>] free_pgd_range+0x224/0x4c0
[  560.593021] [<000000000071c35c>] free_pgtables+0x1fc/0x240
[  560.593042] [<000000000074a6f0>] vms_clear_ptes+0x110/0x140
[  560.593068] [<000000000074c3dc>] vms_complete_munmap_vmas+0x5c/0x280
[  560.593094] [<000000000074de5c>] do_vmi_align_munmap+0x1dc/0x260
[  560.593117] [<000000000074df80>] do_vmi_munmap+0xa0/0x140
[  560.593142] [<000000000074fb2c>] __vm_munmap+0x8c/0x160
[  560.593168] [<000000000072cfd4>] vm_munmap+0x14/0x40
[  560.593190] [<00000000004402a8>] sys_64_munmap+0x88/0xa0
[  560.593221] [<0000000000406274>] linux_sparc_syscall+0x34/0x44
[  560.593274] ---[ end trace 0000000000000000 ]---
[  560.593960] log_unaligned: 209 callbacks suppressed
[  560.593979] Kernel unaligned access at TPC[526a4c] __call_rcu_common.constprop.0+0x20c/0x760
[  560.594121] Kernel unaligned access at TPC[526864] __call_rcu_common.constprop.0+0x24/0x760
[  560.594198] Kernel unaligned access at TPC[52b3c4] rcu_segcblist_enqueue+0x24/0x40
[  560.594275] Kernel unaligned access at TPC[526860] __call_rcu_common.constprop.0+0x20/0x760
[  560.594360] Kernel unaligned access at TPC[526864] __call_rcu_common.constprop.0+0x24/0x760
[  567.054127] log_unaligned: 1105 callbacks suppressed
[  567.054167] Kernel unaligned access at TPC[526860] __call_rcu_common.constprop.0+0x20/0x760
[  567.054331] Kernel unaligned access at TPC[526864] __call_rcu_common.constprop.0+0x24/0x760
[  567.054410] Kernel unaligned access at TPC[52b3c4] rcu_segcblist_enqueue+0x24/0x40
...

I bisected to this one on mm-unstable from approximately 2026-01-12.

The warning is from 

	/* Misaligned rcu_head! */
	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));

in __call_rcu_common() and the unaligned accesses follows from there.

Regards,
Andreas



Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB1BC88E58
	for <linux-um@archiver.kernel.org>; Mon, 26 Jan 2026 07:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hybAGJDtwUTQyBJLSE6cgT3x4CprzyvIGdy1i62DoMg=; b=T6cDqljOw3Cl3dusmO0s7FoiKE
	a25PoTvKmQCC/CwPgBPH4pBVOqT/53Jui8lFuJ3N2uuu2hZaocy2QV2kwqVWnPtV+HRi8c8laLx+B
	ENzECViOFRvdodiFYwMAtRblebTWMkY6K3wu7H5ENCDkwBC1VDeHuk/gffbcST8iV2gfBzrRhT9SJ
	hRhNvutoUnTpfj7so6JY9Iykd8GRSEfHr57e1ogglpZIXAJK+Bz/U1/0EoFOpZdTATEtmWSmmCQvS
	wJoQuqke/N0s2VtnLC38eChDZe/c9kmHboCar+sVL1SuXBAaC+QcLfqp5RgzmFkYUS+4ZN4DcInMr
	6zULl+tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkGaD-0000000C0zk-0U4z;
	Mon, 26 Jan 2026 07:00:21 +0000
Received: from out-182.mta0.migadu.com ([91.218.175.182])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkGaA-0000000C0yW-0VxA
	for linux-um@lists.infradead.org;
	Mon, 26 Jan 2026 07:00:19 +0000
Message-ID: <646d9b5c-453c-4db8-b578-0f343e170379@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769410802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hybAGJDtwUTQyBJLSE6cgT3x4CprzyvIGdy1i62DoMg=;
	b=io0Jn+3NajuPHPI4XjqNt9sYHPn2FyPfP/1eLMYG5oEK9p8YQ2ayv0ii4eZsQi7AY5Kxh/
	8bRt82NClUXSKr1V31d6I/GqCfQd+DB4Ux8EDoCg31zgpyKNNatRAU/WP75QWfFgYjHG7n
	Oc4aJiIqhIpd+iDcwrxRH5wDMzgILbU=
Date: Mon, 26 Jan 2026 14:59:43 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 7/7] mm: make PT_RECLAIM depends on
 MMU_GATHER_RCU_TABLE_FREE
To: Andreas Larsson <andreas@gaisler.com>, david@kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>,
 sparclinux <sparclinux@vger.kernel.org>, will@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, dev.jain@arm.com, ioworker0@gmail.com, linmag7@gmail.com
References: <cover.1765963770.git.zhengqi.arch@bytedance.com>
 <ac2bdb2a66da1edb24f60d1da1099e2a0b734880.1765963770.git.zhengqi.arch@bytedance.com>
 <9199f28e-e2b7-48c8-b61f-0b787e322443@gaisler.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <9199f28e-e2b7-48c8-b61f-0b787e322443@gaisler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260125_230018_469077_DA895077 
X-CRM114-Status: GOOD (  19.53  )
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



On 1/23/26 11:15 PM, Andreas Larsson wrote:
> On 2025-12-17 10:45, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> The PT_RECLAIM can work on all architectures that support
>> MMU_GATHER_RCU_TABLE_FREE, so make PT_RECLAIM depends on
>> MMU_GATHER_RCU_TABLE_FREE.
>>
>> BTW, change PT_RECLAIM to be enabled by default, since nobody should want
>> to turn it off.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   arch/x86/Kconfig | 1 -
>>   mm/Kconfig       | 9 ++-------
>>   2 files changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 80527299f859a..0d22da56a71b0 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -331,7 +331,6 @@ config X86
>>   	select FUNCTION_ALIGNMENT_4B
>>   	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>>   	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>> -	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
>>   	select ARCH_SUPPORTS_SCHED_SMT		if SMP
>>   	select SCHED_SMT			if SMP
>>   	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index bd0ea5454af82..fc00b429b7129 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1447,14 +1447,9 @@ config ARCH_HAS_USER_SHADOW_STACK
>>   	  The architecture has hardware support for userspace shadow call
>>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>>   
>> -config ARCH_SUPPORTS_PT_RECLAIM
>> -	def_bool n
>> -
>>   config PT_RECLAIM
>> -	bool "reclaim empty user page table pages"
>> -	default y
>> -	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>> -	select MMU_GATHER_RCU_TABLE_FREE
>> +	def_bool y
>> +	depends on MMU_GATHER_RCU_TABLE_FREE
>>   	help
>>   	  Try to reclaim empty user page table pages in paths other than munmap
>>   	  and exit_mmap path.
> 
> Hi,
> 
> This patch unfortunately results in a WARN_ON_ONCE and unaligned
> accesses on sparc64:
> 
> $ stress-ng --mmaphuge 20 -t 60
> stress-ng: info:  [559] setting to a 1 min run per stressor
> stress-ng: info:  [559] dispatching hogs: 20 mmaphuge
> [  560.592569] ------------[ cut here ]------------
> [  560.592663] WARNING: kernel/rcu/tree.c:3098 at __call_rcu_common.constprop.0+0x200/0x760, CPU#4: stress-ng-mmaph/568
> [  560.592777] CPU: 4 UID: 1000 PID: 568 Comm: stress-ng-mmaph Not tainted 6.19.0-rc5-00127-g62fc9f6ccb97 #8 VOLUNTARY
> [  560.592805] Call Trace:
> [  560.592812] [<00000000004368b8>] dump_stack+0x8/0x60
> [  560.592844] [<0000000000482a60>] __warn+0xe0/0x140
> [  560.592878] [<0000000000482b64>] warn_slowpath_fmt+0xa4/0x120
> [  560.592901] [<0000000000526a40>] __call_rcu_common.constprop.0+0x200/0x760
> [  560.592931] [<0000000000526fd0>] call_rcu+0x10/0x20
> [  560.592954] [<0000000000730838>] tlb_remove_table+0x98/0xc0
> [  560.592986] [<000000000071bec4>] free_pgd_range+0x224/0x4c0
> [  560.593021] [<000000000071c35c>] free_pgtables+0x1fc/0x240
> [  560.593042] [<000000000074a6f0>] vms_clear_ptes+0x110/0x140
> [  560.593068] [<000000000074c3dc>] vms_complete_munmap_vmas+0x5c/0x280
> [  560.593094] [<000000000074de5c>] do_vmi_align_munmap+0x1dc/0x260
> [  560.593117] [<000000000074df80>] do_vmi_munmap+0xa0/0x140
> [  560.593142] [<000000000074fb2c>] __vm_munmap+0x8c/0x160
> [  560.593168] [<000000000072cfd4>] vm_munmap+0x14/0x40
> [  560.593190] [<00000000004402a8>] sys_64_munmap+0x88/0xa0
> [  560.593221] [<0000000000406274>] linux_sparc_syscall+0x34/0x44
> [  560.593274] ---[ end trace 0000000000000000 ]---
> [  560.593960] log_unaligned: 209 callbacks suppressed
> [  560.593979] Kernel unaligned access at TPC[526a4c] __call_rcu_common.constprop.0+0x20c/0x760
> [  560.594121] Kernel unaligned access at TPC[526864] __call_rcu_common.constprop.0+0x24/0x760
> [  560.594198] Kernel unaligned access at TPC[52b3c4] rcu_segcblist_enqueue+0x24/0x40
> [  560.594275] Kernel unaligned access at TPC[526860] __call_rcu_common.constprop.0+0x20/0x760
> [  560.594360] Kernel unaligned access at TPC[526864] __call_rcu_common.constprop.0+0x24/0x760
> [  567.054127] log_unaligned: 1105 callbacks suppressed
> [  567.054167] Kernel unaligned access at TPC[526860] __call_rcu_common.constprop.0+0x20/0x760
> [  567.054331] Kernel unaligned access at TPC[526864] __call_rcu_common.constprop.0+0x24/0x760
> [  567.054410] Kernel unaligned access at TPC[52b3c4] rcu_segcblist_enqueue+0x24/0x40

Thanks for your report!

On sparc64, pmd and pud levels are not of struct page:

__pmd_free_tlb/__pud_free_tlb
--> pgtable_free_tlb(tlb, pud/pmd, false). <=== is_page == false
     --> tlb_remove_table

So in __tlb_remove_table_one(), the table cannot be treated as
ptdesc because it does not have an pt_rcu_head member.

Hi David, it seems we still need to keep ARCH_SUPPORTS_PT_RECLAIM?

Thanks,
Qi

> ...
> 
> I bisected to this one on mm-unstable from approximately 2026-01-12.
> 
> The warning is from
> 
> 	/* Misaligned rcu_head! */
> 	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> 
> in __call_rcu_common() and the unaligned accesses follows from there.
> 
> Regards,
> Andreas
> 



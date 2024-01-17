Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5003C47258
	for <linux-um@archiver.kernel.org>; Wed, 17 Jan 2024 20:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WOzo8QDfWxyuP1tjwSDkYI/bEpLEXBfoE9dV0/eFjb8=; b=pzTRJF1l1GTmOO0mNRuxqb1TvY
	3WmGTr7lfrcj7ZjQP+IpOt15pAoDnadc0+tzCsh28A/NbRyUQ8Q2soYVNc/HDxqnLePgBF4jRV/U2
	5/VFawd5P5n1xDShWvRMUG6oNibsgcj2hjIoeuC2UGP//sx90FNrX7RNxEpznkj+fADBXAfnbpX/U
	Ltu3w7HgypjweVpEP8KkAww3OiHQuAKM40TjS8/EagjAwS602WiWkkuvde1/JKH7LrvpIIGz1TGt+
	c6nAkLFZ01akeQxSWBKWwzRKTQEa7gtLHT4wUxWm4zSPgDt+fz5T0iW8xqE+jprLQGRjG6qKlCNZm
	NU3XeZUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQCOx-000dtV-19;
	Wed, 17 Jan 2024 20:20:43 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQCOt-000drF-19
	for linux-um@lists.infradead.org;
	Wed, 17 Jan 2024 20:20:41 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1rQBqq-00A5bo-5f; Wed, 17 Jan 2024 19:45:28 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1rQBqi-000xO2-2O;
	Wed, 17 Jan 2024 19:45:27 +0000
Message-ID: <57c2ec52-29a6-4ce7-9334-e0ee436ba630@cambridgegreys.com>
Date: Wed, 17 Jan 2024 19:45:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] um: clean up mm creation - another attempt
To: Benjamin Berg <benjamin@sipsolutions.net>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <20230922223737.1206223-4-johannes@sipsolutions.net>
 <bcc1170b-89b9-7c5e-d047-7055f97c1716@cambridgegreys.com>
 <4f79b781db6d5892c86e103733c7c30cda78afdf.camel@sipsolutions.net>
 <4b5764f0-d2c0-12ce-56bb-73c07ab59ebc@cambridgegreys.com>
 <d6ac37b196ebc0443997a942f8efb16a69e424fc.camel@sipsolutions.net>
 <18290c11-2d97-3aec-3fd7-b3dd0d33a88b@cambridgegreys.com>
 <2d041a80-0ba4-d48b-07b1-b1bc835b3e0d@cambridgegreys.com>
 <4d772184b2b39944de8444b0a6f437581297e1d4.camel@sipsolutions.net>
 <300c0b28952b2837efbb5c59f38944b02b7722f2.camel@sipsolutions.net>
 <820dc103cce16124a195c490ecc80dab4a9af96c.camel@sipsolutions.net>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <820dc103cce16124a195c490ecc80dab4a9af96c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_122039_394574_87B92029 
X-CRM114-Status: GOOD (  28.44  )
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

On 17/01/2024 17:17, Benjamin Berg wrote:
> Hi,
> 
> On Wed, 2023-09-27 at 11:52 +0200, Benjamin Berg wrote:
>> [SNIP]
>> Once we are there, we can look for optimizations. The fundamental
>> problem is that page faults (even minor ones) are extremely expensive
>> for us.
>>
>> Just throwing out ideas on what we could do:
>>     1. SECCOMP as that reduces the amount of context switches.
>>        (Yes, I know I should resubmit the patchset)
>>     2. Maybe we can disable/cripple page access tracking? If we assume
>>        initially mark all pages as accessed by userspace (i.e.
>>        pte_mkyoung), then we avoid a minor page fault on first access.
>>        Doing that will mess with page eviction though.
>>     3. Do DAX (direct_access) for files. i.e. mmap files directly in the
>>        host kernel rather than through UM.
>>        With a hostfs like file system, one should be able to add an
>>        intermediate block device that maps host files to physical pages,
>>        then do DAX in the FS.
>>        For disk images, the existing iomem infrastructure should be
>>        usable, this should work with any DAX enabled filesystems (ext2,
>>        ext4, xfs, virtiofs, erofs).
> 
> So, I experimented quite a bit over Christmas (including getting DAX to
> work with virtiofs). At the end of all this my conclusion is that
> insufficient page table synchronization is our main problem.
> 
> Basically, right now we rely on the flush_tlb_* functions from the
> kernel, but these are only called when TLB entries are removed, *not*
> when new PTEs are added (there is also update_mmu_cache, but it isn't
> enough either). Effectively this means that new page table entries will
> often only be synced because the userspace code runs into an
> unnecessary segfright now we rely on the flush_tlb_* functions from the
> kernel, but these are only called when TLB entries are removed, *not*
> when new PTEs are added (there is also update_mmu_cache, but it isn't
> enough either). Effectively this means that new page table entries will
> often only be synced because the userspace code runs into an
> unnecessary segfaultault.
>   
> Really, what we need is a set_pte_at() implementation that marks the
> memory range for synchronization. Then we can make sure we sync it
> before switching to the userspace process (the equivalent of running
> flush_tlb_mm_range right now).
> 
> I think we should:
>   * Rewrite the userspace syscall code
>     - Support delaying the execution of syscalls
>     - Only support mmap/munmap/mprotect and LDT
>     - Do simple compression of consecutive syscalls here
>     - Drop the hand-written assembler
>   * Improve the tlb.c code
>     - remove the HVC abstraction

Cool. That was not working particularly well. I tried to improve it a 
few times, but ripping it out and replacing it is probably a better idea.

>     - never force immediate syscall execution
>   * Let set_pte_at() track which memory ranges that need syncing
>   * At that point we should be able to:
>     - drop copy_context_skas0
>     - make flush_tlb_* no-ops
>     - drop flush_tlb_page from handle_page_fault
>     - move unmap() from flush_thread to init_new_context
>       (or do it as part of start_userspace)
> 
> So, I did try this using nasty hacks and IIRC one of my runs was going
> from 21s to 16s and another from 63s to 56s. Which seems like a nice
> improvement.

Excellent. I assume you were using hostfs as usual, right? If so, the 
difference is likely to be even more noticeable on ubd.

> 
> Benjamin
> 
> 
> PS: As for DAX, it doesn't really seem to help performance. It didn't
> seem to lower the amount of page faults in UML. And, from my
> perspective, it isn't really worth just for the memory sharing.
> 
> PPS: dirty/young tracking seemed to be only cause a small amount of
> page faults in the grand scheme. So probably not something worth
> following up on.
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/



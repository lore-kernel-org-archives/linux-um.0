Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDC4C4345F
	for <linux-um@archiver.kernel.org>; Mon, 22 Apr 2024 07:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Aef5TGx8Oo2eM6kseAqeo4/AJVg4+wxx4UI84gFqCw=; b=ibV4PpAYWg6aQpYXS5VAGJbrYi
	VhjlVUoLOWTRrjwm0oVrDyGJnA+MF+8FwHurwVQxvNKB62IpZlEkcAa15hXAMcxM4UmQrGlnSQWte
	GU1x50PEMnTXIhpa7wYakOtbZj45G6vKGc17GFtrsvVjWsFmwW8ob+Bb2RLCzF3OrvcRTMQxXmg4p
	6SubJ8sE3J3o+rDRgb8NvKpS2hX2xXwN5GJiyrOPhl2aLfUfynEaAUBKB7yi/u9Ise4jk9PUo11vE
	Y71G7z6XkcVZuHHMoG7nnByosH3qoVivF2dODAoEYNeHR7hhv4Ib/WWj5qC4mS2TJqZ8N17JPH2Ax
	D4KA0zwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryoTJ-0000000CW8H-2uVW;
	Mon, 22 Apr 2024 07:52:17 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryoTG-0000000CW6Z-1qPb
	for linux-um@lists.infradead.org;
	Mon, 22 Apr 2024 07:52:16 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1ryoT1-000QWp-CU; Mon, 22 Apr 2024 07:51:59 +0000
Received: from sleer.kot-begemot.co.uk ([192.168.3.72])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1ryoSy-00A1MV-18;
	Mon, 22 Apr 2024 08:51:59 +0100
Message-ID: <93a4518b-3b8f-48c8-bbae-ada08f879647@kot-begemot.co.uk>
Date: Mon, 22 Apr 2024 08:51:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] um: refactor TLB update handling
To: Benjamin Berg <benjamin@sipsolutions.net>,
 Tiwei Bie <tiwei.btw@antgroup.com>, linux-um@lists.infradead.org
References: <20240418092327.860135-1-benjamin@sipsolutions.net>
 <20240418092327.860135-13-benjamin@sipsolutions.net>
 <995da796-4c8b-41e7-8cb1-d22472933711@antgroup.com>
 <8c8b672eb813784747428a490af9934a48661286.camel@sipsolutions.net>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <8c8b672eb813784747428a490af9934a48661286.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_005214_502530_39112273 
X-CRM114-Status: GOOD (  25.63  )
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



On 22/04/2024 08:22, Benjamin Berg wrote:
> On Mon, 2024-04-22 at 10:51 +0800, Tiwei Bie wrote:
>> On 4/18/24 5:23 PM, benjamin@sipsolutions.net wrote:
>>> diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
>>> index 37eb6e89e79a..bf8da736609c 100644
>>> --- a/arch/um/include/asm/mmu.h
>>> +++ b/arch/um/include/asm/mmu.h
>>> @@ -10,6 +10,10 @@
>>>   
>>>   typedef struct mm_context {
>>>   	struct mm_id id;
>>> +
>>> +	/* Address range in need of a TLB sync */
>>> +	long int sync_tlb_range_from;
>>> +	long int sync_tlb_range_to;
>>
>> Why not "unsigned long"?
> 
> Oops, yes, it should be "unsigned long".
> 
>>
>>>   } mm_context_t;
>>>   
>>>   extern void __switch_mm(struct mm_id * mm_idp);
>>> diff --git a/arch/um/include/asm/pgtable.h
>>> b/arch/um/include/asm/pgtable.h
>>> index e1ece21dbe3f..5bb397b65efb 100644
>>> --- a/arch/um/include/asm/pgtable.h
>>> +++ b/arch/um/include/asm/pgtable.h
>>> @@ -244,6 +244,38 @@ static inline void set_pte(pte_t *pteptr,
>>> pte_t pteval)
>>>   
>>>   #define PFN_PTE_SHIFT		PAGE_SHIFT
>>>   
>>> +static inline void um_tlb_mark_sync(struct mm_struct *mm, unsigned
>>> long start,
>>> +				    unsigned long end)
>>> +{
>>> +	if (!mm->context.sync_tlb_range_to) {
>>> +		mm->context.sync_tlb_range_from = start;
>>> +		mm->context.sync_tlb_range_to = end;
>>> +	} else {
>>> +		if (start < mm->context.sync_tlb_range_from)
>>> +			mm->context.sync_tlb_range_from = start;
>>> +		if (end > mm->context.sync_tlb_range_to)
>>> +			mm->context.sync_tlb_range_to = end;
>>> +	}
>>> +}
>>
>> IIUC, in some cases, the range [sync_tlb_range_from, sync_tlb_range_to)
>> might become very large when merging non-adjacent ranges? Could that
>> be an issue?
> 
> I figured it is not a big problem. It will result in scanning the
> entire page table once to check whether the NEW_PAGE bit is set on any
> PTE. I am assuming that this will happen almost never and scanning the
> page table (but not doing syscalls) is reasonably cheap at the end.
> 
>>> diff --git a/arch/um/include/asm/tlbflush.h b/arch/um/include/asm/tlbflush.h
>>> index d7cf82023b74..62816f6f1c91 100644
>>> --- a/arch/um/include/asm/tlbflush.h
>>> +++ b/arch/um/include/asm/tlbflush.h
>>> @@ -9,24 +9,50 @@
>>>   #include <linux/mm.h>
>>>   
>>>   /*
>>> - * TLB flushing:
>>> + * In UML, we need to sync the TLB over by using mmap/munmap/mprotect syscalls
>>> + * from the process handling the MM (which can be the kernel itself).
>>> + *
>>> + * To track updates, we can hook into set_ptes and flush_tlb_*. With set_ptes
>>> + * we catch all PTE transitions where memory that was unusable becomes usable.
>>> + * While with flush_tlb_* we can track any memory that becomes unusable and
>>> + * even if a higher layer of the page table was modified.
>>> + *
>>> + * So, we simply track updates using both methods and mark the memory area to
>>> + * be synced later on. The only special case is that flush_tlb_kern_* needs to
>>> + * be executed immediately as there is no good synchronization point in that
>>> + * case. In contrast, in the set_ptes case we can wait for the next kernel
>>> + * segfault before we do the synchornization.
>>>    *
>>> - *  - flush_tlb() flushes the current mm struct TLBs
>>>    *  - flush_tlb_all() flushes all processes TLBs
>>>    *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
>>>    *  - flush_tlb_page(vma, vmaddr) flushes one page
>>> - *  - flush_tlb_kernel_vm() flushes the kernel vm area
>>>    *  - flush_tlb_range(vma, start, end) flushes a range of pages
>>> + *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
>>>    */
>>>   
>>> +extern int um_tlb_sync(struct mm_struct *mm);
>>> +
>>>   extern void flush_tlb_all(void);
>>>   extern void flush_tlb_mm(struct mm_struct *mm);
>>> -extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>>> -			    unsigned long end);
>>> -extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long address);
>>> -extern void flush_tlb_kernel_vm(void);
>>> -extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
>>> -extern void __flush_tlb_one(unsigned long addr);
>>> +
>>> +static void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
>>> +{
>>> +	um_tlb_mark_sync(vma->vm_mm, address, address + PAGE_SIZE);
>>> +}
>>> +
>>> +static void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>>> +			    unsigned long end)
>>> +{
>>> +	um_tlb_mark_sync(vma->vm_mm, start, end);
>>> +}
>>> +
>>> +static void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>>> +{
>>> +	um_tlb_mark_sync(&init_mm, start, end);
>>> +
>>> +	/* Kernel needs to be synced immediately */
>>> +	um_tlb_sync(&init_mm);
>>> +}
>>
>> Nit: this is a header file, these functions should be defined as inline functions.
> 
> Yup, thanks!
> 
>>> diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
>>> index c137ff6f84dd..232aa7601d5d 100644
>>> --- a/arch/um/kernel/tlb.c
>>> +++ b/arch/um/kernel/tlb.c
>> [...]
>>>   
>>> -void flush_tlb_kernel_range(unsigned long start, unsigned long
>>> end)
>>> -{
>>> -	flush_tlb_kernel_range_common(start, end);
>>> -}
>>> -
>>> -void flush_tlb_kernel_vm(void)
>>> -{
>>> -	flush_tlb_kernel_range_common(start_vm, end_vm);
>>> -}
>>
>> The build breaks with this change, as there is still a call to
>> flush_tlb_kernel_vm() in ubd.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/um/drivers/ubd_kern.c?id=fb5d1d389c9e78d68f1f71f926d6251017579f5b#n774
> 
> Oh, thanks for the pointer!
> 
> I do not see a good reason for that call to even exist. My best theory
> right now is that it existed to avoid later pagefaults for new memory
> regions (the vmalloc?). So a workaround that is not needed anymore with
> this patch.

It is there since prehistoric times.

No idea why and what it's doing. IMHO it is not needed.

> 
> Benjamin
> 
> 
> 
> 

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/


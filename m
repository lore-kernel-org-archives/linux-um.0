Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8523C4345F
	for <linux-um@archiver.kernel.org>; Mon, 22 Apr 2024 02:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=22kx0cT9TcJfzmQVfy5SlQ7DLyfRKuz96BJb1/04Nkw=; b=Lu1fFbawBO71ysZIMLFCyiGOJs
	22Nek6VWXBWjIvOeJvqrU54rjfBAUax1C3RtvlGfGGY1sA0b2g9LXKN+6FJlRq0bvKw388h7ABXIR
	A+mQl0NCnD2dMCsuxLkiDSne7dEDeDX9LJWvHwffkXe/8YpYzWbxWEC+O6nTiONaMkptt01y29bHS
	letIpBjt4CXxdIvncLzV88mXqXljGGhTfKbM17WEV0gFXtZHsyJIlyc0yFVKawbDce4Bt+NzskxyZ
	8clgNc318Dcbuc5FWT6eeXWzeFkgIkdO45/aB6bpeT0p7yC1AZd2olanXO/sRgY/C0xGOFqXG3h0+
	P+DEWSYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryjm1-0000000BnVO-2BPT;
	Mon, 22 Apr 2024 02:51:17 +0000
Received: from out0-213.mail.aliyun.com ([140.205.0.213])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryjlx-0000000BnU8-18ib
	for linux-um@lists.infradead.org;
	Mon, 22 Apr 2024 02:51:15 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047187;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---.XIAsIrH_1713754266;
Received: from 30.230.85.101(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XIAsIrH_1713754266)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 10:51:06 +0800
Message-ID: <995da796-4c8b-41e7-8cb1-d22472933711@antgroup.com>
Date: Mon, 22 Apr 2024 10:51:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] um: refactor TLB update handling
To: benjamin@sipsolutions.net, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
References: <20240418092327.860135-1-benjamin@sipsolutions.net>
 <20240418092327.860135-13-benjamin@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20240418092327.860135-13-benjamin@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240421_195113_509871_248F13F3 
X-CRM114-Status: GOOD (  20.80  )
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

On 4/18/24 5:23 PM, benjamin@sipsolutions.net wrote:
> diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
> index 37eb6e89e79a..bf8da736609c 100644
> --- a/arch/um/include/asm/mmu.h
> +++ b/arch/um/include/asm/mmu.h
> @@ -10,6 +10,10 @@
>  
>  typedef struct mm_context {
>  	struct mm_id id;
> +
> +	/* Address range in need of a TLB sync */
> +	long int sync_tlb_range_from;
> +	long int sync_tlb_range_to;

Why not "unsigned long"?

>  } mm_context_t;
>  
>  extern void __switch_mm(struct mm_id * mm_idp);
> diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
> index e1ece21dbe3f..5bb397b65efb 100644
> --- a/arch/um/include/asm/pgtable.h
> +++ b/arch/um/include/asm/pgtable.h
> @@ -244,6 +244,38 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
>  
>  #define PFN_PTE_SHIFT		PAGE_SHIFT
>  
> +static inline void um_tlb_mark_sync(struct mm_struct *mm, unsigned long start,
> +				    unsigned long end)
> +{
> +	if (!mm->context.sync_tlb_range_to) {
> +		mm->context.sync_tlb_range_from = start;
> +		mm->context.sync_tlb_range_to = end;
> +	} else {
> +		if (start < mm->context.sync_tlb_range_from)
> +			mm->context.sync_tlb_range_from = start;
> +		if (end > mm->context.sync_tlb_range_to)
> +			mm->context.sync_tlb_range_to = end;
> +	}
> +}

IIUC, in some cases, the range [sync_tlb_range_from, sync_tlb_range_to)
might become very large when merging non-adjacent ranges? Could that
be an issue?

> diff --git a/arch/um/include/asm/tlbflush.h b/arch/um/include/asm/tlbflush.h
> index d7cf82023b74..62816f6f1c91 100644
> --- a/arch/um/include/asm/tlbflush.h
> +++ b/arch/um/include/asm/tlbflush.h
> @@ -9,24 +9,50 @@
>  #include <linux/mm.h>
>  
>  /*
> - * TLB flushing:
> + * In UML, we need to sync the TLB over by using mmap/munmap/mprotect syscalls
> + * from the process handling the MM (which can be the kernel itself).
> + *
> + * To track updates, we can hook into set_ptes and flush_tlb_*. With set_ptes
> + * we catch all PTE transitions where memory that was unusable becomes usable.
> + * While with flush_tlb_* we can track any memory that becomes unusable and
> + * even if a higher layer of the page table was modified.
> + *
> + * So, we simply track updates using both methods and mark the memory area to
> + * be synced later on. The only special case is that flush_tlb_kern_* needs to
> + * be executed immediately as there is no good synchronization point in that
> + * case. In contrast, in the set_ptes case we can wait for the next kernel
> + * segfault before we do the synchornization.
>   *
> - *  - flush_tlb() flushes the current mm struct TLBs
>   *  - flush_tlb_all() flushes all processes TLBs
>   *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
>   *  - flush_tlb_page(vma, vmaddr) flushes one page
> - *  - flush_tlb_kernel_vm() flushes the kernel vm area
>   *  - flush_tlb_range(vma, start, end) flushes a range of pages
> + *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
>   */
>  
> +extern int um_tlb_sync(struct mm_struct *mm);
> +
>  extern void flush_tlb_all(void);
>  extern void flush_tlb_mm(struct mm_struct *mm);
> -extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, 
> -			    unsigned long end);
> -extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long address);
> -extern void flush_tlb_kernel_vm(void);
> -extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
> -extern void __flush_tlb_one(unsigned long addr);
> +
> +static void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
> +{
> +	um_tlb_mark_sync(vma->vm_mm, address, address + PAGE_SIZE);
> +}
> +
> +static void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
> +			    unsigned long end)
> +{
> +	um_tlb_mark_sync(vma->vm_mm, start, end);
> +}
> +
> +static void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> +{
> +	um_tlb_mark_sync(&init_mm, start, end);
> +
> +	/* Kernel needs to be synced immediately */
> +	um_tlb_sync(&init_mm);
> +}

Nit: this is a header file, these functions should be defined as inline functions.

> diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
> index c137ff6f84dd..232aa7601d5d 100644
> --- a/arch/um/kernel/tlb.c
> +++ b/arch/um/kernel/tlb.c
[...]
>  
> -void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> -{
> -	flush_tlb_kernel_range_common(start, end);
> -}
> -
> -void flush_tlb_kernel_vm(void)
> -{
> -	flush_tlb_kernel_range_common(start_vm, end_vm);
> -}

The build breaks with this change, as there is still a call to
flush_tlb_kernel_vm() in ubd.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/um/drivers/ubd_kern.c?id=fb5d1d389c9e78d68f1f71f926d6251017579f5b#n774

Regards,
Tiwei



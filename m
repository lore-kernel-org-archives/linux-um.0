Return-Path: <linux-sh-owner@vger.kernel.org>
Subject: Re: [PATCH 3/3] memblock: cleanup memblock_free interface
References: <20210923074335.12583-1-rppt@kernel.org>
 <20210923074335.12583-4-rppt@kernel.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <1101e3c7-fcb7-a632-8e22-47f4a01ea02e@csgroup.eu>
Date: Thu, 23 Sep 2021 11:47:48 +0200
MIME-Version: 1.0
In-Reply-To: <20210923074335.12583-4-rppt@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
To: Mike Rapoport <rppt@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: devicetree@vger.kernel.org, linux-efi@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mips@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>, linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>



Le 23/09/2021 à 09:43, Mike Rapoport a écrit :
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> For ages memblock_free() interface dealt with physical addresses even
> despite the existence of memblock_alloc_xx() functions that return a
> virtual pointer.
> 
> Introduce memblock_phys_free() for freeing physical ranges and repurpose
> memblock_free() to free virtual pointers to make the following pairing
> abundantly clear:
> 
> 	int memblock_phys_free(phys_addr_t base, phys_addr_t size);
> 	phys_addr_t memblock_phys_alloc(phys_addr_t base, phys_addr_t size);
> 
> 	void *memblock_alloc(phys_addr_t size, phys_addr_t align);
> 	void memblock_free(void *ptr, size_t size);
> 
> Replace intermediate memblock_free_ptr() with memblock_free() and drop
> unnecessary aliases memblock_free_early() and memblock_free_early_nid().
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---

> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index 1a04e5bdf655..37826d8c4f74 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -723,7 +723,7 @@ void __init smp_save_dump_cpus(void)
>   			/* Get the CPU registers */
>   			smp_save_cpu_regs(sa, addr, is_boot_cpu, page);
>   	}
> -	memblock_free(page, PAGE_SIZE);
> +	memblock_phys_free(page, PAGE_SIZE);
>   	diag_amode31_ops.diag308_reset();
>   	pcpu_set_smt(0);
>   }
> @@ -880,7 +880,7 @@ void __init smp_detect_cpus(void)
>   
>   	/* Add CPUs present at boot */
>   	__smp_rescan_cpus(info, true);
> -	memblock_free_early((unsigned long)info, sizeof(*info));
> +	memblock_free(info, sizeof(*info));
>   }
>   
>   /*

I'm a bit lost. IIUC memblock_free_early() and memblock_free() where 
identical.

In the first hunk memblock_free() gets replaced by memblock_phys_free()
In the second hunk memblock_free_early() gets replaced by memblock_free()

I think it would be easier to follow if you could split it in several 
patches:
- First patch: Create memblock_phys_free() and change all relevant 
memblock_free() to memblock_phys_free() - Or change memblock_free() to 
memblock_phys_free() and make memblock_free() an alias of it.
- Second patch: Make memblock_free_ptr() become memblock_free() and 
change all remaining callers to the new semantics (IIUC 
memblock_free(__pa(ptr)) becomes memblock_free(ptr) and make 
memblock_free_ptr() an alias of memblock_free()
- Fourth patch: Replace and drop memblock_free_ptr()
- Fifth patch: Drop memblock_free_early() and memblock_free_early_nid() 
(All users should have been upgraded to memblock_free_phys() in patch 1 
or memblock_free() in patch 2)

Christophe


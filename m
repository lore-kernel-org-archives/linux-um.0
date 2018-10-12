Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gArnu-0004BQ-LF
 for linux-um@lists.infradead.org; Fri, 12 Oct 2018 07:24:12 +0000
Received: from [192.168.17.6] (helo=smaug.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1gAr80-00010E-Ks
 for linux-um@lists.infradead.org; Fri, 12 Oct 2018 06:40:52 +0000
Received: from wyvern.kot-begemot.co.uk ([192.168.3.72])
 by smaug.kot-begemot.co.uk with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1gAr80-0002qS-4p
 for linux-um@lists.infradead.org; Fri, 12 Oct 2018 07:40:52 +0100
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <ab053cc0-ab55-7eb1-7f65-d00da2751bab@kot-begemot.co.uk>
Date: Fri, 12 Oct 2018 07:40:51 +0100
MIME-Version: 1.0
In-Reply-To: <20181012013756.11285-2-joel@joelfernandes.org>
Content-Language: en-US
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

On 12/10/2018 02:37, Joel Fernandes (Google) wrote:
> Android needs to mremap large regions of memory during memory management
> related operations. The mremap system call can be really slow if THP is
> not enabled. The bottleneck is move_page_tables, which is copying each
> pte at a time, and can be really slow across a large map. Turning on THP
> may not be a viable option, and is not for us. This patch speeds up the
> performance for non-THP system by copying at the PMD level when possible.
>
> The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> completion times drops from 160-250 millesconds to 380-400 microseconds.
>
> Before:
> Total mremap time for 1GB data: 242321014 nanoseconds.
> Total mremap time for 1GB data: 196842467 nanoseconds.
> Total mremap time for 1GB data: 167051162 nanoseconds.
>
> After:
> Total mremap time for 1GB data: 385781 nanoseconds.
> Total mremap time for 1GB data: 388959 nanoseconds.
> Total mremap time for 1GB data: 402813 nanoseconds.
>
> Incase THP is enabled, the optimization is skipped. I also flush the
> tlb every time we do this optimization since I couldn't find a way to
> determine if the low-level PTEs are dirty. It is seen that the cost of

That is a fairly high cost operation on UML. In fact, I suspect it 
results in zero gain or even worse.

I will try to find some time to look into this one today or over the 
weekend.

A.

> doing so is not much compared the improvement, on both x86-64 and arm64.
>
> Cc: minchan@kernel.org
> Cc: pantin@google.com
> Cc: hughd@google.com
> Cc: lokeshgidra@google.com
> Cc: dancol@google.com
> Cc: mhocko@kernel.org
> Cc: kirill@shutemov.name
> Cc: akpm@linux-foundation.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>   mm/mremap.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 9e68a02a52b1..d82c485822ef 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
>   		drop_rmap_locks(vma);
>   }
>   
> +static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> +		  unsigned long new_addr, unsigned long old_end,
> +		  pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
> +{
> +	spinlock_t *old_ptl, *new_ptl;
> +	struct mm_struct *mm = vma->vm_mm;
> +
> +	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> +	    || old_end - old_addr < PMD_SIZE)
> +		return false;
> +
> +	/*
> +	 * The destination pmd shouldn't be established, free_pgtables()
> +	 * should have release it.
> +	 */
> +	if (WARN_ON(!pmd_none(*new_pmd)))
> +		return false;
> +
> +	/*
> +	 * We don't have to worry about the ordering of src and dst
> +	 * ptlocks because exclusive mmap_sem prevents deadlock.
> +	 */
> +	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
> +	if (old_ptl) {
> +		pmd_t pmd;
> +
> +		new_ptl = pmd_lockptr(mm, new_pmd);
> +		if (new_ptl != old_ptl)
> +			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> +
> +		/* Clear the pmd */
> +		pmd = *old_pmd;
> +		pmd_clear(old_pmd);
> +
> +		VM_BUG_ON(!pmd_none(*new_pmd));
> +
> +		/* Set the new pmd */
> +		set_pmd_at(mm, new_addr, new_pmd, pmd);
> +		if (new_ptl != old_ptl)
> +			spin_unlock(new_ptl);
> +		spin_unlock(old_ptl);
> +
> +		*need_flush = true;
> +		return true;
> +	}
> +	return false;
> +}
> +
>   unsigned long move_page_tables(struct vm_area_struct *vma,
>   		unsigned long old_addr, struct vm_area_struct *new_vma,
>   		unsigned long new_addr, unsigned long len,
> @@ -239,7 +287,21 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>   			split_huge_pmd(vma, old_pmd, old_addr);
>   			if (pmd_trans_unstable(old_pmd))
>   				continue;
> +		} else if (extent == PMD_SIZE) {
> +			bool moved;
> +
> +			/* See comment in move_ptes() */
> +			if (need_rmap_locks)
> +				take_rmap_locks(vma);
> +			moved = move_normal_pmd(vma, old_addr, new_addr,
> +					old_end, old_pmd, new_pmd,
> +					&need_flush);
> +			if (need_rmap_locks)
> +				drop_rmap_locks(vma);
> +			if (moved)
> +				continue;
>   		}
> +
>   		if (pte_alloc(new_vma->vm_mm, new_pmd))
>   			break;
>   		next = (new_addr + PMD_SIZE) & PMD_MASK;



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


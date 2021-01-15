Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0NuW-0006ls-RS
 for linux-um@lists.infradead.org; Fri, 15 Jan 2021 12:09:01 +0000
Message-ID: <9e989a0274d7e55038b37ab1b9e6ab7553bb3488.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] um: remove process stub VMA
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 15 Jan 2021 13:08:58 +0100
In-Reply-To: <20210113220944.ba020fe73c75.Ia71e6fe697af9b196278084a9f730c30e20773c9@changeid>
References: <20210113220944.7732f6bfd3bb.Ib87c91b49d57d27314cf444696273da6d8463e9c@changeid>
 <20210113220944.ba020fe73c75.Ia71e6fe697af9b196278084a9f730c30e20773c9@changeid>
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: linux-arch@vger.kernel.org

On Wed, 2021-01-13 at 22:09 +0100, Johannes Berg wrote:
> 
> +++ b/arch/um/include/asm/mmu_context.h
> @@ -9,34 +9,9 @@
>  #include <linux/sched.h>
>  #include <linux/mm_types.h>
>  #include <linux/mmap_lock.h>
> -
> +#include <asm/mm_hooks.h>
>  #include <asm/mmu.h>
>  
> -extern void uml_setup_stubs(struct mm_struct *mm);
> -/*
> - * Needed since we do not use the asm-generic/mm_hooks.h:
> - */
> -static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
> -{
> -	uml_setup_stubs(mm);
> -	return 0;
> -}
> -extern void arch_exit_mmap(struct mm_struct *mm);
> -static inline void arch_unmap(struct mm_struct *mm,
> -			unsigned long start, unsigned long end)
> -{
> -}
> -static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
> -		bool write, bool execute, bool foreign)
> -{
> -	/* by default, allow everything */
> -	return true;
> -}
> -
> -/*
> - * end asm-generic/mm_hooks.h functions
> - */
> -
>  #define deactivate_mm(tsk,mm)	do { } while (0)


Just saw there's a small conflict since in the meantime, deactivate_mm()
has been removed. Just take neither code.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


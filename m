Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH] um: asm/page.h: zero out a pte's high value in set_pte_val()
References: <871t91i7gf.fsf@gmail.com> <56AAB5ED.7020200@nod.at>
	<87wpqtgogb.fsf@gmail.com> <56AB2730.5020009@nod.at>
Date: Fri, 29 Jan 2016 15:31:08 +0100
In-Reply-To: <56AB2730.5020009@nod.at> (Richard Weinberger's message of "Fri,
	29 Jan 2016 09:47:44 +0100")
Message-ID: <87bn845ufn.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Nicolai Stange <nicstange@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Richard Weinberger <richard@nod.at> writes:

> Am 29.01.2016 um 02:32 schrieb Nicolai Stange:
>> Richard Weinberger <richard@nod.at> writes:
>> 
>>> Am 29.01.2016 um 00:56 schrieb Nicolai Stange:
>>>> Commit 16da306849d0 ("um: kill pfn_t")
>>>> introduced a compile warning for defconfig:
>>>>
>>>>   arch/um/kernel/skas/mmu.c:38:206: warning: right shift count >= width of type
>>>>                                     [-Wshift-count-overflow]
>>>>
>>>> Aforementioned patch changes the definition of the phys_to_pfn() macro from
>>>>
>>>>   ((pfn_t) ((p) >> PAGE_SHIFT))
>>>>
>>>> to
>>>>
>>>>   ((p) >> PAGE_SHIFT)
>>>>
>>>> This effectively changes the phys_to_pfn() expansion's type from
>>>> unsigned long long to unsigned long.
>>>>
>>>> Through the callchain init_stub_pte()->mk_pte(), the expansion of
>>>> phys_to_pfn() is (indirectly) fed into the 'phys' argument of the
>>>> pte_set_val(pte, phys, prot) macro, eventually leading to
>>>>
>>>>   (pte).pte_high = (phys) >> 32;
>>>>
>>>> This results in the warning from above.
>>>>
>>>> Since UML only deals with 32 bit addresses, the upper 32 bits from 'phys'
>>>> used to be zero anyway.
>>>>
>>>> Zero out the pte value's high part in pte_set_val() in order to get rid
>>>> of the offending shift.
>>>>
>>>> Fixes: 16da306849d0 ("um: kill pfn_t")
>>>> Signed-off-by: Nicolai Stange <nicstange@gmail.com>
>>>> ---
>>>>  arch/um/include/asm/page.h | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
>>>> index e13d41c..61e235f 100644
>>>> --- a/arch/um/include/asm/page.h
>>>> +++ b/arch/um/include/asm/page.h
>>>> @@ -46,8 +46,8 @@ typedef struct { unsigned long pgd; } pgd_t;
>>>>  			      smp_wmb(); \
>>>>  			      (to).pte_low = (from).pte_low; })
>>>>  #define pte_is_zero(pte) (!((pte).pte_low & ~_PAGE_NEWPAGE) && !(pte).pte_high)
>>>> -#define pte_set_val(pte, phys, prot) \
>>>> -	({ (pte).pte_high = (phys) >> 32; \
>>>> +#define pte_set_val(pte, phys, prot)				\
>>>> +	({ (pte).pte_high = 0;					\
>>>>  	   (pte).pte_low = (phys) | pgprot_val(prot); })
>>>
>>> I think we can completely kill .pte_high.
>>>
>> 
>> I did a quick test with ->pte_high purged and this doesn't introduce any
>> new warnings.
>> 
>> Booting w/o a rootfs works up to mount_root.
>> 
>> 
>> Note that an implication of getting rid of ->pte_high would be that the
>> type of pte_val() would get changed from unsigned long long to unsigned
>> long. However, outside of arch/um, pte_val() is only used here:
>> - drivers/gpu/drm/drm_vm.c
>> - include/trace/events/xen.h
>> - mm/gup.c
>> - mm/memory.c
>> All these uses and the ones in arch/um itself look compatible with this
>> change (if relevant at all for UML).
>> 
>> 
>> I'll post a follow up patch for this tomorrow.
>> 
>> Question 1: now that ->pte_high will be gone, do you want to have
>>             ->pte_low renamed to e.g. ->pte_val?
>
> So, with a freshly booted brain the story looks a bit different.
> All this code needs a cleanup and we need to check what other archs do
> before we change pte_val(). Are you ready for some research? :)

So this is what arch/x86 does:

1.) typedef a pteval_t to a type matching the underlying hardware's
    native PTE size.
    Examples:
    - x86: arch/x86/include/asm/pgtable-2level_types.h -- unsigned long
    - x86(PAE): arch/x86/include/asm/pgtable-3level_types.h -- u64
    - x86_64: arch/x86/include/asm/pgtable_64_types.h -- unsigned long

2.) pte_t is typedefed to either a struct or union like this:

      typedef struct { pteval_t pte; } pte_t;

    In the case of a union (x86 and x86 w/ PAE), an additional member
    'pte_low' is introduced, aliasing the low half of ->pte.

Now, all three x86-arch cases define typedef a pgprotval_t matching their
respective pteval_t type and have a common then

  typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;

Basically, mk_pte(page, pgprot) shifts the page's physical address to
some architecturally defined point (PAGE_SHIFT) within pteval_t and ors
the architecturally defined protection flags (_PAGE_*) in.

Of course, the protection flags are defined such that hardware
eventually finds them at the expected place within the final PTE
(c.f. arch/x86/include/asm/pgtable_types.h).


Summarizing:
The content of pteval_t is completely architecture dependent.  The only
semantics on pte values defined for out-of-arch users, e.g. mm/gup.c
seems to be equality on a pte_val(pte).


Finally, the page protection flags defined for UML do not have any bit
at a position greater than 9 assigned to them
(c.g. arch/um/include/asm/pgtable.h). (If that had been the case, we had
been in trouble already because protection flags are only or'ed into
->pte_low).


Thus, under the assumption that with UML, physical addresses are always
32 bits, I would say that it is safe to change pte_t.


Proposal:
Introduce pteval_t and pgprotval_t like x86 does and do

  typedef struct { pteval_t pte; } pte_t;
  typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;

Change the pte macros accordingly.

What about pgd_t and pmd_t?


>> Question 2: what is the smp_wmb() in pte_copy() paired with/good for?
>
> AFACT to make sure that a write to pte_high is complete before we write pte_low.
> 100% copy&pasted from arch/i386 15 years ago. ;-)
>
> Thanks,
> //richard


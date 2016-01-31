Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1aPo2y-0000ar-VR
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jan 2016 09:11:52 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aPo2x-000812-Mr
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jan 2016 09:11:52 +0000
References: <871t91i7gf.fsf@gmail.com> <56AAB5ED.7020200@nod.at>
	<87wpqtgogb.fsf@gmail.com> <56AB2730.5020009@nod.at>
	<87bn845ufn.fsf@gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56ADCFCC.4030207@nod.at>
Date: Sun, 31 Jan 2016 10:11:40 +0100
MIME-Version: 1.0
In-Reply-To: <87bn845ufn.fsf@gmail.com>
Subject: Re: [uml-devel] [PATCH] um: asm/page.h: zero out a pte's high value
 in set_pte_val()
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Nicolai Stange <nicstange@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, user-mode-linux-user@lists.sourceforge.net, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>

Am 29.01.2016 um 15:31 schrieb Nicolai Stange:
>>> Question 1: now that ->pte_high will be gone, do you want to have
>>>             ->pte_low renamed to e.g. ->pte_val?
>>
>> So, with a freshly booted brain the story looks a bit different.
>> All this code needs a cleanup and we need to check what other archs do
>> before we change pte_val(). Are you ready for some research? :)
> 
> So this is what arch/x86 does:
> 
> 1.) typedef a pteval_t to a type matching the underlying hardware's
>     native PTE size.
>     Examples:
>     - x86: arch/x86/include/asm/pgtable-2level_types.h -- unsigned long
>     - x86(PAE): arch/x86/include/asm/pgtable-3level_types.h -- u64
>     - x86_64: arch/x86/include/asm/pgtable_64_types.h -- unsigned long
> 
> 2.) pte_t is typedefed to either a struct or union like this:
> 
>       typedef struct { pteval_t pte; } pte_t;
> 
>     In the case of a union (x86 and x86 w/ PAE), an additional member
>     'pte_low' is introduced, aliasing the low half of ->pte.
> 
> Now, all three x86-arch cases define typedef a pgprotval_t matching their
> respective pteval_t type and have a common then
> 
>   typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
> 
> Basically, mk_pte(page, pgprot) shifts the page's physical address to
> some architecturally defined point (PAGE_SHIFT) within pteval_t and ors
> the architecturally defined protection flags (_PAGE_*) in.
> 
> Of course, the protection flags are defined such that hardware
> eventually finds them at the expected place within the final PTE
> (c.f. arch/x86/include/asm/pgtable_types.h).
> 
> 
> Summarizing:
> The content of pteval_t is completely architecture dependent.  The only
> semantics on pte values defined for out-of-arch users, e.g. mm/gup.c
> seems to be equality on a pte_val(pte).
> 

Thanks for doing the research!

> Finally, the page protection flags defined for UML do not have any bit
> at a position greater than 9 assigned to them
> (c.g. arch/um/include/asm/pgtable.h). (If that had been the case, we had
> been in trouble already because protection flags are only or'ed into
> ->pte_low).
> 
> 
> Thus, under the assumption that with UML, physical addresses are always
> 32 bits, I would say that it is safe to change pte_t.
> 
> 
> Proposal:
> Introduce pteval_t and pgprotval_t like x86 does and do
> 
>   typedef struct { pteval_t pte; } pte_t;
>   typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
> 
> Change the pte macros accordingly.

Makes sense.

> What about pgd_t and pmd_t?

What do you mean? AFAICT we can keep them as-is.

So, please redo your patch such that we can merge it as soon as possible
to have the build warning fixed.

Thanks,
//richard

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


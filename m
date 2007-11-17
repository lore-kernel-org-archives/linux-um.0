Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ItLFq-00053q-2S for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Nov 2007 02:50:26 -0800
Received: from smtp-out3.tiscali.nl ([195.241.79.178])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ItLFo-0008GO-Fm
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Nov 2007 02:50:26 -0800
Message-ID: <473EC75F.5020208@tiscali.nl>
Date: Sat, 17 Nov 2007 11:50:07 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
References: <20071116214227.GA13877@c2.user-mode-linux.org>
In-Reply-To: <20071116214227.GA13877@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH 7/8] UML - add virt_to_pte
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Jeff Dike wrote:
> Turn um_virt_to_phys into virt_to_pte, cleaning up a horrid interface.
> 
> It's also made non-static and declared in pgtable.h because it'll be
> needed when the stubs get a vma.
> 
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>
> ---
>  arch/um/kernel/skas/uaccess.c |   56 +++++++++++++++++-------------------------
>  include/asm-um/pgtable.h      |    3 ++
>  2 files changed, 26 insertions(+), 33 deletions(-)
> 
> Index: linux-2.6.22/arch/um/kernel/skas/uaccess.c
> ===================================================================
> --- linux-2.6.22.orig/arch/um/kernel/skas/uaccess.c	2007-11-16 15:16:54.000000000 -0500
> +++ linux-2.6.22/arch/um/kernel/skas/uaccess.c	2007-11-16 15:40:25.000000000 -0500
> @@ -13,70 +13,60 @@
>  #include "kern_util.h"
>  #include "os.h"
>  
> -static void *um_virt_to_phys(struct task_struct *task, unsigned long addr,
> -			     pte_t *pte_out)
> +pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr)
>  {
>  	pgd_t *pgd;
>  	pud_t *pud;
>  	pmd_t *pmd;
> -	pte_t *pte;
> -	pte_t ptent;
>  
> -	if (task->mm == NULL)
> -		return ERR_PTR(-EINVAL);
> -	pgd = pgd_offset(task->mm, addr);
> +	if (mm == NULL)
> +		return NULL;
> +
> +	pgd = pgd_offset(mm, addr);
>  	if (!pgd_present(*pgd))
> -		return ERR_PTR(-EINVAL);
> +		return NULL;
>  
>  	pud = pud_offset(pgd, addr);
>  	if (!pud_present(*pud))
> -		return ERR_PTR(-EINVAL);
> +		return NULL;
>  
>  	pmd = pmd_offset(pud, addr);
>  	if (!pmd_present(*pmd))
> -		return ERR_PTR(-EINVAL);
> -
> -	pte = pte_offset_kernel(pmd, addr);
> -	ptent = *pte;
> -	if (!pte_present(ptent))
> -		return ERR_PTR(-EINVAL);
> +		return NULL;
>  
> -	if (pte_out != NULL)
> -		*pte_out = ptent;
> -	return (void *) (pte_val(ptent) & PAGE_MASK) + (addr & ~PAGE_MASK);
> +	return pte_offset_kernel(pmd, addr);
>  }
>  
> -static unsigned long maybe_map(unsigned long virt, int is_write)
> +static pte_t *maybe_map(unsigned long virt, int is_write)
>  {
> -	pte_t pte;
> -	int err;
> +	pte_t *pte = virt_to_pte(current->mm, virt);
> +	int err, dummy_code;
>  
> -	void *phys = um_virt_to_phys(current, virt, &pte);
> -	int dummy_code;
> -
> -	if (IS_ERR(phys) || (is_write && !pte_write(pte))) {
> +	if ((pte == NULL) || !pte_present(*pte) ||
> +	    (is_write && !pte_write(*pte))) {
>  		err = handle_page_fault(virt, 0, is_write, 1, &dummy_code);
>  		if (err)
> -			return -1UL;
> -		phys = um_virt_to_phys(current, virt, NULL);
> +			return NULL;
> +		pte = virt_to_pte(current->mm, virt);
>  	}
> -	if (IS_ERR(phys))
> -		phys = (void *) -1;
> +	if (!pte_present(*pte))
> +		pte = NULL;

shouldn't you check again for (pte == NULL)?

>  
> -	return (unsigned long) phys;
> +	return pte;
>  }

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

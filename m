Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389DCCFC60D
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 07:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+08wgX1e861sgSH/F9mHPoEt1THIiXUKLgterN2sqLU=; b=iuvTZUlQNzH5lAXVc6dHtekikc
	aYHnXOWbyTqmz9Kq10Cc11xIvX0Z+kLmqGRueKWsyfJifigWfPGiBV10fqV/hezPYMpSsskex7EpF
	s8PSMWycnwk3lafmHc+h9HBYnVKhRFlouaLE0rf1l0C1zMgl1ka0ZspV+TztVRMCh+Mbqn+c6Tvcc
	cc/iM5kSxGSRtZmV3t9KLOtc3cgTfG2b6EUJpQi6r7yvnfNDUoPCx5zTlJl3xzQGWY5dJdlSRAeh1
	83dsQ1ySUMgBnB6ah5ptMfQH3qgBM90jK+Z34F2J7w0OIwJqdW0L6tNxSVwVjwKcm+bRZN3RW+9aX
	wCidb2xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szAFJ-0000000FZfd-3WTE;
	Fri, 11 Oct 2024 07:39:33 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szAFH-0000000FZes-1IFu
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 07:39:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+08wgX1e861sgSH/F9mHPoEt1THIiXUKLgterN2sqLU=;
	t=1728632371; x=1729841971; b=DvHFCQc2NOHdjajtCVMadThY5ltFDw33GklzXjBzQZnv0PH
	d5GkTtv3Q4t/cPHltU+q3d8F19N4ARrK7oCHTz+hWG8ulfdXz4UQ8+2T09SanWJRqfY5kqUwTYhwY
	JexoWbh7G4lKASqe+xDmZbWcYWS5gV66kPp41G6I9tAxZPsFUHI6NKgDxiekmzrqeZ7IzZaI7LISK
	D3ULZKohVqz9VKNMrX3KY+OekoQ+aU3iVTVzOKPMYUu4iYLWHhk0pP3i0+dQcZKg/9Q8wW6YgtMuL
	ePVldBmvNLKb3LwUnu1/DacbX1562dpbYkj4hm9XNSXEhtUKWoYVn7Zo1uc0LIGQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1szAFC-00000006ziv-346n;
	Fri, 11 Oct 2024 09:39:26 +0200
Message-ID: <6abc79186ace90cd2abe202a4abe0eaf17eebb5f.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Abandon the _PAGE_NEWPROT bit
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Oct 2024 09:39:24 +0200
In-Reply-To: <20241011053843.1623089-1-tiwei.btw@antgroup.com>
References: <20241011053843.1623089-1-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_003931_550671_950C87B6 
X-CRM114-Status: GOOD (  25.69  )
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

Hi,

On Fri, 2024-10-11 at 13:38 +0800, Tiwei Bie wrote:
> When a PTE is updated in the page table, the _PAGE_NEWPAGE bit will
> always be set. And the corresponding page will always be mapped or
> unmapped depending on whether the PTE is present or not. The check
> on the _PAGE_NEWPROT bit is not really reachable. Abandoning it will
> allow us to simplify the code and remove the unreachable code.

Oh, nice cleanup!

And I like that mprotect is gone as I don't want it in SECCOMP mode :-)

Maybe we should rename _PAGE_NEWPAGE to something like _PAGE_NEEDSYNC?
I think that might make it more clear how everything ties together.

Anyway, the change looks good to me.

Benjamin

Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>

> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
> =C2=A0arch/um/include/asm/pgtable.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 40 ++++-----------
> =C2=A0arch/um/include/shared/os.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 -
> =C2=A0arch/um/include/shared/skas/stub-data.h |=C2=A0 1 -
> =C2=A0arch/um/kernel/skas/stub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ----
> =C2=A0arch/um/kernel/tlb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 66 =
+++++++++++------------
> --
> =C2=A0arch/um/os-Linux/skas/mem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 21 --------
> =C2=A06 files changed, 37 insertions(+), 103 deletions(-)
>=20
> diff --git a/arch/um/include/asm/pgtable.h
> b/arch/um/include/asm/pgtable.h
> index bd7a9593705f..a32424cfe792 100644
> --- a/arch/um/include/asm/pgtable.h
> +++ b/arch/um/include/asm/pgtable.h
> @@ -12,7 +12,6 @@
> =C2=A0
> =C2=A0#define _PAGE_PRESENT	0x001
> =C2=A0#define _PAGE_NEWPAGE	0x002
> -#define _PAGE_NEWPROT	0x004
> =C2=A0#define _PAGE_RW	0x020
> =C2=A0#define _PAGE_USER	0x040
> =C2=A0#define _PAGE_ACCESSED	0x080
> @@ -151,23 +150,12 @@ static inline int pte_newpage(pte_t pte)
> =C2=A0	return pte_get_bits(pte, _PAGE_NEWPAGE);
> =C2=A0}
> =C2=A0
> -static inline int pte_newprot(pte_t pte)
> -{
> -	return(pte_present(pte) && (pte_get_bits(pte,
> _PAGE_NEWPROT)));
> -}
> -
> =C2=A0/*
> =C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0 * Flags setting section.
> =C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0 */
> =C2=A0
> -static inline pte_t pte_mknewprot(pte_t pte)
> -{
> -	pte_set_bits(pte, _PAGE_NEWPROT);
> -	return(pte);
> -}
> -
> =C2=A0static inline pte_t pte_mkclean(pte_t pte)
> =C2=A0{
> =C2=A0	pte_clear_bits(pte, _PAGE_DIRTY);
> @@ -184,17 +172,14 @@ static inline pte_t pte_wrprotect(pte_t pte)
> =C2=A0{
> =C2=A0	if (likely(pte_get_bits(pte, _PAGE_RW)))
> =C2=A0		pte_clear_bits(pte, _PAGE_RW);
> -	else
> -		return pte;
> -	return(pte_mknewprot(pte));
> +	return pte;
> =C2=A0}
> =C2=A0
> =C2=A0static inline pte_t pte_mkread(pte_t pte)
> =C2=A0{
> -	if (unlikely(pte_get_bits(pte, _PAGE_USER)))
> -		return pte;
> -	pte_set_bits(pte, _PAGE_USER);
> -	return(pte_mknewprot(pte));
> +	if (likely(!pte_get_bits(pte, _PAGE_USER)))
> +		pte_set_bits(pte, _PAGE_USER);
> +	return pte;
> =C2=A0}
> =C2=A0
> =C2=A0static inline pte_t pte_mkdirty(pte_t pte)
> @@ -211,18 +196,15 @@ static inline pte_t pte_mkyoung(pte_t pte)
> =C2=A0
> =C2=A0static inline pte_t pte_mkwrite_novma(pte_t pte)
> =C2=A0{
> -	if (unlikely(pte_get_bits(pte,=C2=A0 _PAGE_RW)))
> -		return pte;
> -	pte_set_bits(pte, _PAGE_RW);
> -	return(pte_mknewprot(pte));
> +	if (likely(!pte_get_bits(pte, _PAGE_RW)))
> +		pte_set_bits(pte, _PAGE_RW);
> +	return pte;
> =C2=A0}
> =C2=A0
> =C2=A0static inline pte_t pte_mkuptodate(pte_t pte)
> =C2=A0{
> =C2=A0	pte_clear_bits(pte, _PAGE_NEWPAGE);
> -	if(pte_present(pte))
> -		pte_clear_bits(pte, _PAGE_NEWPROT);
> -	return(pte);
> +	return pte;
> =C2=A0}
> =C2=A0
> =C2=A0static inline pte_t pte_mknewpage(pte_t pte)
> @@ -236,12 +218,10 @@ static inline void set_pte(pte_t *pteptr, pte_t
> pteval)
> =C2=A0	pte_copy(*pteptr, pteval);
> =C2=A0
> =C2=A0	/* If it's a swap entry, it needs to be marked _PAGE_NEWPAGE
> so
> -	 * fix_range knows to unmap it.=C2=A0 _PAGE_NEWPROT is specific
> to
> -	 * mapped pages.
> +	 * update_pte_range knows to unmap it.
> =C2=A0	 */
> =C2=A0
> =C2=A0	*pteptr =3D pte_mknewpage(*pteptr);
> -	if(pte_present(*pteptr)) *pteptr =3D pte_mknewprot(*pteptr);
> =C2=A0}
> =C2=A0
> =C2=A0#define PFN_PTE_SHIFT		PAGE_SHIFT
> @@ -298,8 +278,6 @@ static inline int pte_same(pte_t pte_a, pte_t
> pte_b)
> =C2=A0	({ pte_t pte;					\
> =C2=A0							\
> =C2=A0	pte_set_val(pte, page_to_phys(page), (pgprot));	\
> -	if (pte_present(pte))				\
> -		pte_mknewprot(pte_mknewpage(pte));	\
> =C2=A0	pte;})
> =C2=A0
> =C2=A0static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> diff --git a/arch/um/include/shared/os.h
> b/arch/um/include/shared/os.h
> index bf539fee7831..09f8201de5db 100644
> --- a/arch/um/include/shared/os.h
> +++ b/arch/um/include/shared/os.h
> @@ -279,8 +279,6 @@ int map(struct mm_id *mm_idp, unsigned long virt,
> =C2=A0	unsigned long len, int prot, int phys_fd,
> =C2=A0	unsigned long long offset);
> =C2=A0int unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long
> len);
> -int protect(struct mm_id *mm_idp, unsigned long addr,
> -	=C2=A0=C2=A0=C2=A0 unsigned long len, unsigned int prot);
> =C2=A0
> =C2=A0/* skas/process.c */
> =C2=A0extern int is_skas_winch(int pid, int fd, void *data);
> diff --git a/arch/um/include/shared/skas/stub-data.h
> b/arch/um/include/shared/skas/stub-data.h
> index 3fbdda727373..81a4cace032c 100644
> --- a/arch/um/include/shared/skas/stub-data.h
> +++ b/arch/um/include/shared/skas/stub-data.h
> @@ -30,7 +30,6 @@ enum stub_syscall_type {
> =C2=A0	STUB_SYSCALL_UNSET =3D 0,
> =C2=A0	STUB_SYSCALL_MMAP,
> =C2=A0	STUB_SYSCALL_MUNMAP,
> -	STUB_SYSCALL_MPROTECT,
> =C2=A0};
> =C2=A0
> =C2=A0struct stub_syscall {
> diff --git a/arch/um/kernel/skas/stub.c b/arch/um/kernel/skas/stub.c
> index 5d52ffa682dc..796fc266d3bb 100644
> --- a/arch/um/kernel/skas/stub.c
> +++ b/arch/um/kernel/skas/stub.c
> @@ -35,16 +35,6 @@ static __always_inline int syscall_handler(struct
> stub_data *d)
> =C2=A0				return -1;
> =C2=A0			}
> =C2=A0			break;
> -		case STUB_SYSCALL_MPROTECT:
> -			res =3D stub_syscall3(__NR_mprotect,
> -					=C2=A0=C2=A0=C2=A0 sc->mem.addr, sc-
> >mem.length,
> -					=C2=A0=C2=A0=C2=A0 sc->mem.prot);
> -			if (res) {
> -				d->err =3D res;
> -				d->syscall_data_len =3D i;
> -				return -1;
> -			}
> -			break;
> =C2=A0		default:
> =C2=A0			d->err =3D -95; /* EOPNOTSUPP */
> =C2=A0			d->syscall_data_len =3D i;
> diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
> index 548af31d4111..23c1f550cd7c 100644
> --- a/arch/um/kernel/tlb.c
> +++ b/arch/um/kernel/tlb.c
> @@ -23,9 +23,6 @@ struct vm_ops {
> =C2=A0		=C2=A0=C2=A0=C2=A0 int phys_fd, unsigned long long offset);
> =C2=A0	int (*unmap)(struct mm_id *mm_idp,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long virt, unsigned long len);
> -	int (*mprotect)(struct mm_id *mm_idp,
> -			unsigned long virt, unsigned long len,
> -			unsigned int prot);
> =C2=A0};
> =C2=A0
> =C2=A0static int kern_map(struct mm_id *mm_idp,
> @@ -44,15 +41,6 @@ static int kern_unmap(struct mm_id *mm_idp,
> =C2=A0	return os_unmap_memory((void *)virt, len);
> =C2=A0}
> =C2=A0
> -static int kern_mprotect(struct mm_id *mm_idp,
> -			 unsigned long virt, unsigned long len,
> -			 unsigned int prot)
> -{
> -	return os_protect_memory((void *)virt, len,
> -				 prot & UM_PROT_READ, prot &
> UM_PROT_WRITE,
> -				 1);
> -}
> -
> =C2=A0void report_enomem(void)
> =C2=A0{
> =C2=A0	printk(KERN_ERR "UML ran out of memory on the host side! "
> @@ -65,33 +53,37 @@ static inline int update_pte_range(pmd_t *pmd,
> unsigned long addr,
> =C2=A0				=C2=A0=C2=A0 struct vm_ops *ops)
> =C2=A0{
> =C2=A0	pte_t *pte;
> -	int r, w, x, prot, ret =3D 0;
> +	int ret =3D 0;
> =C2=A0
> =C2=A0	pte =3D pte_offset_kernel(pmd, addr);
> =C2=A0	do {
> -		r =3D pte_read(*pte);
> -		w =3D pte_write(*pte);
> -		x =3D pte_exec(*pte);
> -		if (!pte_young(*pte)) {
> -			r =3D 0;
> -			w =3D 0;
> -		} else if (!pte_dirty(*pte))
> -			w =3D 0;
> -
> -		prot =3D ((r ? UM_PROT_READ : 0) | (w ? UM_PROT_WRITE
> : 0) |
> -			(x ? UM_PROT_EXEC : 0));
> -		if (pte_newpage(*pte)) {
> -			if (pte_present(*pte)) {
> -				__u64 offset;
> -				unsigned long phys =3D pte_val(*pte) &
> PAGE_MASK;
> -				int fd =3D phys_mapping(phys,
> &offset);
> -
> -				ret =3D ops->mmap(ops->mm_idp, addr,
> PAGE_SIZE,
> -						prot, fd, offset);
> -			} else
> -				ret =3D ops->unmap(ops->mm_idp, addr,
> PAGE_SIZE);
> -		} else if (pte_newprot(*pte))
> -			ret =3D ops->mprotect(ops->mm_idp, addr,
> PAGE_SIZE, prot);
> +		if (!pte_newpage(*pte))
> +			continue;
> +
> +		if (pte_present(*pte)) {
> +			__u64 offset;
> +			unsigned long phys =3D pte_val(*pte) &
> PAGE_MASK;
> +			int fd =3D phys_mapping(phys, &offset);
> +			int r, w, x, prot;
> +
> +			r =3D pte_read(*pte);
> +			w =3D pte_write(*pte);
> +			x =3D pte_exec(*pte);
> +			if (!pte_young(*pte)) {
> +				r =3D 0;
> +				w =3D 0;
> +			} else if (!pte_dirty(*pte))
> +				w =3D 0;
> +
> +			prot =3D (r ? UM_PROT_READ : 0) |
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (w ? UM_PROT_WRITE : 0) |
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (x ? UM_PROT_EXEC : 0);
> +
> +			ret =3D ops->mmap(ops->mm_idp, addr,
> PAGE_SIZE,
> +					prot, fd, offset);
> +		} else
> +			ret =3D ops->unmap(ops->mm_idp, addr,
> PAGE_SIZE);
> +
> =C2=A0		*pte =3D pte_mkuptodate(*pte);
> =C2=A0	} while (pte++, addr +=3D PAGE_SIZE, ((addr < end) && !ret));
> =C2=A0	return ret;
> @@ -180,11 +172,9 @@ int um_tlb_sync(struct mm_struct *mm)
> =C2=A0	if (mm =3D=3D &init_mm) {
> =C2=A0		ops.mmap =3D kern_map;
> =C2=A0		ops.unmap =3D kern_unmap;
> -		ops.mprotect =3D kern_mprotect;
> =C2=A0	} else {
> =C2=A0		ops.mmap =3D map;
> =C2=A0		ops.unmap =3D unmap;
> -		ops.mprotect =3D protect;
> =C2=A0	}
> =C2=A0
> =C2=A0	pgd =3D pgd_offset(mm, addr);
> diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-
> Linux/skas/mem.c
> index 9a13ac23c606..d7f1814b0e5a 100644
> --- a/arch/um/os-Linux/skas/mem.c
> +++ b/arch/um/os-Linux/skas/mem.c
> @@ -217,24 +217,3 @@ int unmap(struct mm_id *mm_idp, unsigned long
> addr, unsigned long len)
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> -
> -int protect(struct mm_id *mm_idp, unsigned long addr, unsigned long
> len,
> -	=C2=A0=C2=A0=C2=A0 unsigned int prot)
> -{
> -	struct stub_syscall *sc;
> -
> -	/* Compress with previous syscall if that is possible */
> -	sc =3D syscall_stub_get_previous(mm_idp,
> STUB_SYSCALL_MPROTECT, addr);
> -	if (sc && sc->mem.prot =3D=3D prot) {
> -		sc->mem.length +=3D len;
> -		return 0;
> -	}
> -
> -	sc =3D syscall_stub_alloc(mm_idp);
> -	sc->syscall =3D STUB_SYSCALL_MPROTECT;
> -	sc->mem.addr =3D addr;
> -	sc->mem.length =3D len;
> -	sc->mem.prot =3D prot;
> -
> -	return 0;
> -}



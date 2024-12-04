Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD8DE77170
	for <linux-um@archiver.kernel.org>; Wed,  4 Dec 2024 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cAc2mHghz6bytXScf879htgXZRAiHw3UuX8OHpvD+RI=; b=wJBsqQnv/LlXEsBnlgI5iVewYq
	JVJrDp+Bm9e1062WjXdDwHmkCgKPWOLVfudmLzN7bQMYblayu2H5eXfDT+9sMj/1tzDbja0dXWoOl
	/pCxEdXkFSogU+95RnoDEZBxOz8hWQ7ido53FtofxOLC0RZcyQglmMaE+vey1l43actkZhtYB78WT
	TCKOcgWsUhcwuf8vDrU9Ics6yGu8UC1D40X9OueSpbybNEmxqrN17cEAEzbxdDQbZa5VniPXym98q
	eOVKD6dixPcqt8H2Q5s6+ZmD4LscRWxqw497wcVLRwh/m2gSqQMUvNBJyHnlEs/9J1JvU0UF6qo+k
	4WTBlQqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIsL1-0000000DCsv-0Lro;
	Wed, 04 Dec 2024 16:34:55 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIsKy-0000000DCsK-3vJq
	for linux-um@lists.infradead.org;
	Wed, 04 Dec 2024 16:34:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cAc2mHghz6bytXScf879htgXZRAiHw3UuX8OHpvD+RI=;
	t=1733330092; x=1734539692; b=F1Iuhxd1q34LYp+FUo6ZFAWqLQrr3DkOPEyiIrD/2+jbTuJ
	3kvWsPuUPk/TbHrGe96Jq256QThheGiCy5W9n6CORQA4SXUEzG0xbIPQUA3SheBF0flpebhmJRwXP
	gf0zZ4Domp825M/35JpE3LH+s4RkJttWIsMZBut/Ic56uCR4oCG06nQc2RY4/wHtSEtUb7DuU2c3B
	W+Q93m5vp6FYYDOI3P2HnKe2qfPBzBRUKtlQ808ZdPEJETxPG4IJCBcvB20FQFDUup40spjof6vHA
	VGhh3/tWTPDEiOEcOVZgBq38hm3htWCUkK7DNubQoowCSAzhrwr96sMNyld9YeVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tIsKw-000000076UU-03YS;
	Wed, 04 Dec 2024 17:34:50 +0100
Message-ID: <d6c80b918b3febd0eb572b4a945dfc200f6890ee.camel@sipsolutions.net>
Subject: Re: [PATCH v3 03/13] um: nommu: memory handling
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com
Date: Wed, 04 Dec 2024 17:34:49 +0100
In-Reply-To: <1400de8bca3dc72df563156fcbc6eaaf54e2e58a.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
	 <1400de8bca3dc72df563156fcbc6eaaf54e2e58a.1733199769.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_083452_971710_92026F2A 
X-CRM114-Status: GOOD (  22.31  )
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

On Tue, 2024-12-03 at 13:23 +0900, Hajime Tazaki wrote:
>=20
> +++ b/arch/um/include/asm/futex.h
> @@ -8,7 +8,11 @@
> =20
> =20
>  int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user=
 *uaddr);
> +#ifdef CONFIG_MMU
>  int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  			      u32 oldval, u32 newval);
> +#else
> +#include <asm-generic/futex.h>
> +#endif

That seems somewhat problematic since it also defines
arch_futex_atomic_op_inuser ...

> +++ b/arch/um/include/shared/os.h
> @@ -195,7 +195,13 @@ extern void get_host_cpu_features(
>  extern int create_mem_file(unsigned long long len);
> =20
>  /* tlb.c */
> +#ifdef CONFIG_MMU
>  extern void report_enomem(void);
> +#else
> +static inline void report_enomem(void)
> +{
> +}
> +#endif

That still seems simply wrong? Why is that even called, and why should
it do *nothing*?

I'm thinking you might just have patch sequence issues here - I can't
really see why this would be called at all, eventually.

> @@ -78,6 +79,7 @@ void __init mem_init(void)
>   * Create a page table and place a pointer to it in a middle page
>   * directory entry.
>   */
> +#ifdef CONFIG_MMU
>  static void __init one_page_table_init(pmd_t *pmd)
>  {
>  	if (pmd_none(*pmd)) {
> @@ -149,6 +151,12 @@ static void __init fixrange_init(unsigned long start=
, unsigned long end,
>  		j =3D 0;
>  	}
>  }
> +#else
> +static void __init fixrange_init(unsigned long start, unsigned long end,
> +				 pgd_t *pgd_base)
> +{
> +}
> +#endif

Really not a fan of all these randomly placed ifdefs ...

> +#ifdef CONFIG_MMU
>  static const pgprot_t protection_map[16] =3D {
>  	[VM_NONE]					=3D PAGE_NONE,
>  	[VM_READ]					=3D PAGE_READONLY,
> @@ -249,3 +258,4 @@ static const pgprot_t protection_map[16] =3D {
>  	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	=3D PAGE_SHARED
>  };
>  DECLARE_VM_GET_PAGE_PROT
> +#endif

Same here.

I think we can do better - perhaps move some code to mmu.c and nommu.c
or something like that.

> diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
> index a74f17b033c4..f55d46dbe173 100644
> --- a/arch/um/kernel/physmem.c
> +++ b/arch/um/kernel/physmem.c
> @@ -84,7 +84,11 @@ void __init setup_physmem(unsigned long start, unsigne=
d long reserve_end,
>  		exit(1);
>  	}
> =20
> +#ifdef CONFIG_MMU
>  	physmem_fd =3D create_mem_file(len);
> +#else
> +	physmem_fd =3D -1;
> +#endif

same here, create_mem_file() can just be in a file only built for mmu,
and otherwise be an inline that returns -1?

> +#ifdef CONFIG_MMU
>  	/*
>  	 * Special kludge - This page will be mapped in to userspace processes
>  	 * from physmem_fd, so it needs to be written out there.
>  	 */
>  	os_seek_file(physmem_fd, __pa(__syscall_stub_start));
>  	os_write_file(physmem_fd, __syscall_stub_start, PAGE_SIZE);
> +#endif

That doesn't even do anything if the fd is -1, do we need the ifdef? ;-)

Still better as "if (IS_ENABLED())" or something anyway though.

> +++ b/arch/um/kernel/trap.c
> @@ -24,6 +24,7 @@
>  int handle_page_fault(unsigned long address, unsigned long ip,
>  		      int is_write, int is_user, int *code_out)
>  {
> +#ifdef CONFIG_MMU
>  	struct mm_struct *mm =3D current->mm;
>  	struct vm_area_struct *vma;
>  	pmd_t *pmd;
> @@ -129,6 +130,9 @@ int handle_page_fault(unsigned long address, unsigned=
 long ip,
>  		goto out_nosemaphore;
>  	pagefault_out_of_memory();
>  	return 0;
> +#else
> +	return -EFAULT;
> +#endif
>  }

same comments here ... try not to sprinkle ifdefs everywhere.

johannes


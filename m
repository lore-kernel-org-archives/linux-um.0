Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0073DC4345F
	for <linux-um@archiver.kernel.org>; Mon, 22 Apr 2024 07:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Dnof2nGMPfdSBM3NlfuO/k+v555Yf817aMzzS76Cko=; b=n47mITIqme0ENjaBp3RNsoFpeC
	SU4drHMeVjdrPxCjffjQzLASj1ImVJ6yVz9UfuArv1LKZ3zfSNdvv09/puTrB0eROog6VtqFps9CP
	t5RtEPWeWoQtjo2EokMbkr3+ybhXXgtstRD34f6GViroLYf7eS4j7o4IZ4PPXJfI3q/he1XTMXpzY
	ikVAy/QdmBAz18Y8gjQbLrOqed/p9s52mRE1Jen3iWBxibYxlVg/4yL4+lYt/7pxL3LZ8bglAJNNx
	1M4OOgITwn3GNLWbmlk3a1ICh3io+AfkL10NcyT05S0bZNBDFXpCobGcxXntttoybUEYnCvdmKm/2
	y6I5i2SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryo0a-0000000CQHu-1HxQ;
	Mon, 22 Apr 2024 07:22:36 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryo0W-0000000CQF3-0n3N
	for linux-um@lists.infradead.org;
	Mon, 22 Apr 2024 07:22:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9Dnof2nGMPfdSBM3NlfuO/k+v555Yf817aMzzS76Cko=;
	t=1713770547; x=1714980147; b=DKqZ2AAoqDxGLLbWweY6cQmKgvpcE66TN1ByRJBjBj5Rddu
	wgmhLt3DovV+US8gyTz97UCuKsU9JbWdIppIuTj5uTOVCYPn6Ls0M3vgBBMPnVhR2nUv4Iy1eH9do
	13E3MNh1pJW+XLR8Ip0olRUxCEqCrbNSGjI3svEySQEXd/ibFv2P/oQibmPq16kPmUar2PczlarSf
	cyTRnDpPnQZAkngmUjK0PlFGMCoxdXwNVB9soosFUg+IqnBmdL8my9eyOEobZ1jdftxaaU4T9eE+M
	BnTqmll63juRnnXV+O9hxb98S4hoeuUtxSD52e6FX00Z2ifsRvkD7Xhwl9Dp+O4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1ryo0O-00000000Zs3-1kku;
	Mon, 22 Apr 2024 09:22:24 +0200
Message-ID: <8c8b672eb813784747428a490af9934a48661286.camel@sipsolutions.net>
Subject: Re: [PATCH 12/12] um: refactor TLB update handling
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, linux-um@lists.infradead.org
Date: Mon, 22 Apr 2024 09:22:22 +0200
In-Reply-To: <995da796-4c8b-41e7-8cb1-d22472933711@antgroup.com>
References: <20240418092327.860135-1-benjamin@sipsolutions.net>
	 <20240418092327.860135-13-benjamin@sipsolutions.net>
	 <995da796-4c8b-41e7-8cb1-d22472933711@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_002232_614596_9D197015 
X-CRM114-Status: GOOD (  26.76  )
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

On Mon, 2024-04-22 at 10:51 +0800, Tiwei Bie wrote:
> On 4/18/24 5:23 PM, benjamin@sipsolutions.net=C2=A0wrote:
> > diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
> > index 37eb6e89e79a..bf8da736609c 100644
> > --- a/arch/um/include/asm/mmu.h
> > +++ b/arch/um/include/asm/mmu.h
> > @@ -10,6 +10,10 @@
> > =C2=A0
> > =C2=A0typedef struct mm_context {
> > =C2=A0	struct mm_id id;
> > +
> > +	/* Address range in need of a TLB sync */
> > +	long int sync_tlb_range_from;
> > +	long int sync_tlb_range_to;
>=20
> Why not "unsigned long"?

Oops, yes, it should be "unsigned long".

>=20
> > =C2=A0} mm_context_t;
> > =C2=A0
> > =C2=A0extern void __switch_mm(struct mm_id * mm_idp);
> > diff --git a/arch/um/include/asm/pgtable.h
> > b/arch/um/include/asm/pgtable.h
> > index e1ece21dbe3f..5bb397b65efb 100644
> > --- a/arch/um/include/asm/pgtable.h
> > +++ b/arch/um/include/asm/pgtable.h
> > @@ -244,6 +244,38 @@ static inline void set_pte(pte_t *pteptr,
> > pte_t pteval)
> > =C2=A0
> > =C2=A0#define PFN_PTE_SHIFT		PAGE_SHIFT
> > =C2=A0
> > +static inline void um_tlb_mark_sync(struct mm_struct *mm, unsigned
> > long start,
> > +				=C2=A0=C2=A0=C2=A0 unsigned long end)
> > +{
> > +	if (!mm->context.sync_tlb_range_to) {
> > +		mm->context.sync_tlb_range_from =3D start;
> > +		mm->context.sync_tlb_range_to =3D end;
> > +	} else {
> > +		if (start < mm->context.sync_tlb_range_from)
> > +			mm->context.sync_tlb_range_from =3D start;
> > +		if (end > mm->context.sync_tlb_range_to)
> > +			mm->context.sync_tlb_range_to =3D end;
> > +	}
> > +}
>=20
> IIUC, in some cases, the range [sync_tlb_range_from, sync_tlb_range_to)
> might become very large when merging non-adjacent ranges? Could that
> be an issue?

I figured it is not a big problem. It will result in scanning the
entire page table once to check whether the NEW_PAGE bit is set on any
PTE. I am assuming that this will happen almost never and scanning the
page table (but not doing syscalls) is reasonably cheap at the end.

> > diff --git a/arch/um/include/asm/tlbflush.h b/arch/um/include/asm/tlbfl=
ush.h
> > index d7cf82023b74..62816f6f1c91 100644
> > --- a/arch/um/include/asm/tlbflush.h
> > +++ b/arch/um/include/asm/tlbflush.h
> > @@ -9,24 +9,50 @@
> > =C2=A0#include <linux/mm.h>
> > =C2=A0
> > =C2=A0/*
> > - * TLB flushing:
> > + * In UML, we need to sync the TLB over by using mmap/munmap/mprotect =
syscalls
> > + * from the process handling the MM (which can be the kernel itself).
> > + *
> > + * To track updates, we can hook into set_ptes and flush_tlb_*. With s=
et_ptes
> > + * we catch all PTE transitions where memory that was unusable becomes=
 usable.
> > + * While with flush_tlb_* we can track any memory that becomes unusabl=
e and
> > + * even if a higher layer of the page table was modified.
> > + *
> > + * So, we simply track updates using both methods and mark the memory =
area to
> > + * be synced later on. The only special case is that flush_tlb_kern_* =
needs to
> > + * be executed immediately as there is no good synchronization point i=
n that
> > + * case. In contrast, in the set_ptes case we can wait for the next ke=
rnel
> > + * segfault before we do the synchornization.
> > =C2=A0 *
> > - *=C2=A0 - flush_tlb() flushes the current mm struct TLBs
> > =C2=A0 *=C2=A0 - flush_tlb_all() flushes all processes TLBs
> > =C2=A0 *=C2=A0 - flush_tlb_mm(mm) flushes the specified mm context TLB'=
s
> > =C2=A0 *=C2=A0 - flush_tlb_page(vma, vmaddr) flushes one page
> > - *=C2=A0 - flush_tlb_kernel_vm() flushes the kernel vm area
> > =C2=A0 *=C2=A0 - flush_tlb_range(vma, start, end) flushes a range of pa=
ges
> > + *=C2=A0 - flush_tlb_kernel_range(start, end) flushes a range of kerne=
l pages
> > =C2=A0 */
> > =C2=A0
> > +extern int um_tlb_sync(struct mm_struct *mm);
> > +
> > =C2=A0extern void flush_tlb_all(void);
> > =C2=A0extern void flush_tlb_mm(struct mm_struct *mm);
> > -extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long =
start,=20
> > -			=C2=A0=C2=A0=C2=A0 unsigned long end);
> > -extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long a=
ddress);
> > -extern void flush_tlb_kernel_vm(void);
> > -extern void flush_tlb_kernel_range(unsigned long start, unsigned long =
end);
> > -extern void __flush_tlb_one(unsigned long addr);
> > +
> > +static void flush_tlb_page(struct vm_area_struct *vma, unsigned long a=
ddress)
> > +{
> > +	um_tlb_mark_sync(vma->vm_mm, address, address + PAGE_SIZE);
> > +}
> > +
> > +static void flush_tlb_range(struct vm_area_struct *vma, unsigned long =
start,
> > +			=C2=A0=C2=A0=C2=A0 unsigned long end)
> > +{
> > +	um_tlb_mark_sync(vma->vm_mm, start, end);
> > +}
> > +
> > +static void flush_tlb_kernel_range(unsigned long start, unsigned long =
end)
> > +{
> > +	um_tlb_mark_sync(&init_mm, start, end);
> > +
> > +	/* Kernel needs to be synced immediately */
> > +	um_tlb_sync(&init_mm);
> > +}
>=20
> Nit: this is a header file, these functions should be defined as inline f=
unctions.

Yup, thanks!

> > diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
> > index c137ff6f84dd..232aa7601d5d 100644
> > --- a/arch/um/kernel/tlb.c
> > +++ b/arch/um/kernel/tlb.c
> [...]
> > =C2=A0
> > -void flush_tlb_kernel_range(unsigned long start, unsigned long
> > end)
> > -{
> > -	flush_tlb_kernel_range_common(start, end);
> > -}
> > -
> > -void flush_tlb_kernel_vm(void)
> > -{
> > -	flush_tlb_kernel_range_common(start_vm, end_vm);
> > -}
>=20
> The build breaks with this change, as there is still a call to
> flush_tlb_kernel_vm() in ubd.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/um/drivers/ubd_kern.c?id=3Dfb5d1d389c9e78d68f1f71f926d6251017579f5b#n77=
4

Oh, thanks for the pointer!

I do not see a good reason for that call to even exist. My best theory
right now is that it existed to avoid later pagefaults for new memory
regions (the vmalloc?). So a workaround that is not needed anymore with
this patch.

Benjamin




Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2049AC47258
	for <linux-um@archiver.kernel.org>; Wed, 17 Jan 2024 19:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I/LmWIlxznd9bDjzzRVTID684Rc0Ke4HzmPh7mJgV3A=; b=m2jdTM/tUuRhe3pSLBf+Dt/bs4
	aD7sc/xWHdM0YapGHwBbFbmigEdonj1w/rG5TESoxSYPh7eTffagzD32c/7qJ10HseYyfxKxn2YPB
	95+2362sDuLjHC1hsyNpOemb/LUTClUSMmgxi+jwEkPTdNOeCBcFdM1muOmDjhaFIUNisafuK8yty
	Yco+cX2D2SOdqVBmuVqryEdIPcBG8etpIKEd9AVyED+UkENBfq2acw2RbxHMNIy7hH/bNl+YUG13J
	RFtzLkLIFx0AOhtwK7jSqf735Oksq9OIbA1Eyoa9EShDShaBxI1E+YgdD4GbYJr8GFVbC5CFvdl2b
	MsYvD22A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQBzr-000YCK-1s;
	Wed, 17 Jan 2024 19:54:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQBzo-000YBN-13
	for linux-um@lists.infradead.org;
	Wed, 17 Jan 2024 19:54:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=I/LmWIlxznd9bDjzzRVTID684Rc0Ke4HzmPh7mJgV3A=;
	t=1705521281; x=1706730881; b=P7xfCtf7XXLMqlOVzkctJbveDhAddM0rGGDDeWQj3qE88wh
	g+PNMG6F4ejdtQAe3A5Kcz2mdKGiFw31p08ZjbkxAXBfeV1aPWaWNlH97d5hCIZpYSOJK2ffUxr1U
	YV/HW3l7+YlIknPh5iepK6h/MvKefGIpRa0SVphFL5MmA54P5Qgw8gDxi+EVMqLvwicVZc+FGVe+N
	qOut8MNaSYZxbZJ2zQdnktXnMy9z5tLPbUs2dFx4aEqK86B6libx3CJf+ozc5QZjcmI3rkimlq9Va
	bsswhhk6VgDgIesvjif8bMw+13Ui8eV7MxArKSFVHQUJvIQ+FgTuyLdHfhYE7JDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rQBzg-00000006kjm-23Du;
	Wed, 17 Jan 2024 20:54:36 +0100
Message-ID: <478ac27fd53fa20b4f735b1d792639cd61d5eda4.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 0/3] um: clean up mm creation - another attempt
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
	 <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Date: Wed, 17 Jan 2024 20:54:35 +0100
In-Reply-To: <57c2ec52-29a6-4ce7-9334-e0ee436ba630@cambridgegreys.com>
References: <20230922223737.1206223-4-johannes@sipsolutions.net>
	 <bcc1170b-89b9-7c5e-d047-7055f97c1716@cambridgegreys.com>
	 <4f79b781db6d5892c86e103733c7c30cda78afdf.camel@sipsolutions.net>
	 <4b5764f0-d2c0-12ce-56bb-73c07ab59ebc@cambridgegreys.com>
	 <d6ac37b196ebc0443997a942f8efb16a69e424fc.camel@sipsolutions.net>
	 <18290c11-2d97-3aec-3fd7-b3dd0d33a88b@cambridgegreys.com>
	 <2d041a80-0ba4-d48b-07b1-b1bc835b3e0d@cambridgegreys.com>
	 <4d772184b2b39944de8444b0a6f437581297e1d4.camel@sipsolutions.net>
	 <300c0b28952b2837efbb5c59f38944b02b7722f2.camel@sipsolutions.net>
	 <820dc103cce16124a195c490ecc80dab4a9af96c.camel@sipsolutions.net>
	 <57c2ec52-29a6-4ce7-9334-e0ee436ba630@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_115444_364126_B154231D 
X-CRM114-Status: GOOD (  34.59  )
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

On Wed, 2024-01-17 at 19:45 +0000, Anton Ivanov wrote:
> On 17/01/2024 17:17, Benjamin Berg wrote:
> > Hi,
> >=20
> > On Wed, 2023-09-27 at 11:52 +0200, Benjamin Berg wrote:
> > > [SNIP]
> > > Once we are there, we can look for optimizations. The fundamental
> > > problem is that page faults (even minor ones) are extremely expensive
> > > for us.
> > >=20
> > > Just throwing out ideas on what we could do:
> > > =C2=A0=C2=A0=C2=A0 1. SECCOMP as that reduces the amount of context s=
witches.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Yes, I know I should resubmit t=
he patchset)
> > > =C2=A0=C2=A0=C2=A0 2. Maybe we can disable/cripple page access tracki=
ng? If we assume
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initially mark all pages as acce=
ssed by userspace (i.e.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pte_mkyoung), then we avoid a mi=
nor page fault on first access.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Doing that will mess with page e=
viction though.
> > > =C2=A0=C2=A0=C2=A0 3. Do DAX (direct_access) for files. i.e. mmap fil=
es directly in the
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host kernel rather than through =
UM.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 With a hostfs like file system, =
one should be able to add an
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 intermediate block device that m=
aps host files to physical pages,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 then do DAX in the FS.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For disk images, the existing io=
mem infrastructure should be
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usable, this should work with an=
y DAX enabled filesystems (ext2,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ext4, xfs, virtiofs, erofs).
> >=20
> > So, I experimented quite a bit over Christmas (including getting DAX to
> > work with virtiofs). At the end of all this my conclusion is that
> > insufficient page table synchronization is our main problem.
> >=20
> > Basically, right now we rely on the flush_tlb_* functions from the
> > kernel, but these are only called when TLB entries are removed, *not*
> > when new PTEs are added (there is also update_mmu_cache, but it isn't
> > enough either). Effectively this means that new page table entries will
> > often only be synced because the userspace code runs into an
> > unnecessary segfright now we rely on the flush_tlb_* functions from the
> > kernel, but these are only called when TLB entries are removed, *not*
> > when new PTEs are added (there is also update_mmu_cache, but it isn't
> > enough either). Effectively this means that new page table entries will
> > often only be synced because the userspace code runs into an
> > unnecessary segfaultault.
> > =C2=A0=20
> > Really, what we need is a set_pte_at() implementation that marks the
> > memory range for synchronization. Then we can make sure we sync it
> > before switching to the userspace process (the equivalent of running
> > flush_tlb_mm_range right now).
> >=20
> > I think we should:
> > =C2=A0 * Rewrite the userspace syscall code
> > =C2=A0=C2=A0=C2=A0 - Support delaying the execution of syscalls
> > =C2=A0=C2=A0=C2=A0 - Only support mmap/munmap/mprotect and LDT
> > =C2=A0=C2=A0=C2=A0 - Do simple compression of consecutive syscalls here
> > =C2=A0=C2=A0=C2=A0 - Drop the hand-written assembler
> > =C2=A0 * Improve the tlb.c code
> > =C2=A0=C2=A0=C2=A0 - remove the HVC abstraction
>=20
> Cool. That was not working particularly well. I tried to improve it a
> few times, but ripping it out and replacing it is probably a better idea.

Hm, now I realise that we still want mmap() syscall compression for the
kernel itself in tlb.c.

> > =C2=A0=C2=A0=C2=A0 - never force immediate syscall execution
> > =C2=A0 * Let set_pte_at() track which memory ranges that need syncing
> > =C2=A0 * At that point we should be able to:
> > =C2=A0=C2=A0=C2=A0 - drop copy_context_skas0
> > =C2=A0=C2=A0=C2=A0 - make flush_tlb_* no-ops
> > =C2=A0=C2=A0=C2=A0 - drop flush_tlb_page from handle_page_fault
> > =C2=A0=C2=A0=C2=A0 - move unmap() from flush_thread to init_new_context
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (or do it as part of start_userspace)
> >=20
> > So, I did try this using nasty hacks and IIRC one of my runs was going
> > from 21s to 16s and another from 63s to 56s. Which seems like a nice
> > improvement.
>=20
> Excellent. I assume you were using hostfs as usual, right? If so, the
> difference is likely to be even more noticeable on ubd.

Yes, I was mostly testing hostfs. Initially also virtiofs with DAX, but
I went back as that didn't result in a pagefault count improvement once
I made some other adjustments.

Benjamin

>=20
> >=20
> > Benjamin
> >=20
> >=20
> > PS: As for DAX, it doesn't really seem to help performance. It didn't
> > seem to lower the amount of page faults in UML. And, from my
> > perspective, it isn't really worth just for the memory sharing.
> >=20
> > PPS: dirty/young tracking seemed to be only cause a small amount of
> > page faults in the grand scheme. So probably not something worth
> > following up on.
> >=20
>=20



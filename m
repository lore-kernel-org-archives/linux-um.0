Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF59C47258
	for <linux-um@archiver.kernel.org>; Wed, 17 Jan 2024 17:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=66hUf+kqJAuqvNRFKaRnYvTc4CYNxUX/msZWcifrBjI=; b=2ETl2I+R3uVWpSDvrC/ZojOA5C
	Jo9/2Li3py2gKoNTxWD0Hg4YzOwHnrEbVPdC0/b4chDhLrMXuVYiXo4qovlIoLl1g/bgRbJz5NZy0
	5qRasdbyS2N0d3feUQYGPWKrEaysPH4Db3rEWCnpGN9sgQ7WDn94DiYkpewFfmy+D6kkyqbX3MD02
	5QxEDMA7TN2+jBtPNx590tgKu2OkdL2KPd/YU7M/airnMlZacfBEOsJjYgla1KYe9EsMYOz9ScWpD
	yy+SvSozedBZDRReDtxNS1MpnYsuNmDE1VN+HTL0r9lHG0qcKz1bVOdnJCRIyo5BLzPiDNBSeUhIf
	WNSUX8Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ9Y8-000CdB-2d;
	Wed, 17 Jan 2024 17:18:00 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ9Y5-000CYh-1L
	for linux-um@lists.infradead.org;
	Wed, 17 Jan 2024 17:17:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=66hUf+kqJAuqvNRFKaRnYvTc4CYNxUX/msZWcifrBjI=;
	t=1705511874; x=1706721474; b=UxZ/Qrhp8JOGTmr0FIcxnwL3QgdF1MoN51XME+NM+dkb7iZ
	fcf+tvGB3wj6naZlfh19z4xi3E/LhoCekFwpT4a+SJnnply5v0KTLGOdVC1N38wwm1BWyRIKQFe6m
	+TgALYD5vplH6fjtkqFqJgwkY+AgHVaIuPbvEaCaaNiU6K0Q22t5FMuRDD4DzvwwqQN0F6RYmu6bb
	ADP3DEyuzC/us6SESPY/pCGLpXCU7980KtLZjzlGDTB+7Kbco5vbuq4cm2XHiEtRwLfFzciLT+5cD
	u7ccibRPWbrRzVUrePVD+Y33TxTtTS0qxpD4ajEOvaxjyE3IXRfvIu6mtzf/ihlA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rQ9Xy-00000006eZh-3FGQ;
	Wed, 17 Jan 2024 18:17:51 +0100
Message-ID: <820dc103cce16124a195c490ecc80dab4a9af96c.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 0/3] um: clean up mm creation - another attempt
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov
	 <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Date: Wed, 17 Jan 2024 18:17:49 +0100
In-Reply-To: <300c0b28952b2837efbb5c59f38944b02b7722f2.camel@sipsolutions.net>
References: <20230922223737.1206223-4-johannes@sipsolutions.net>
	 <bcc1170b-89b9-7c5e-d047-7055f97c1716@cambridgegreys.com>
	 <4f79b781db6d5892c86e103733c7c30cda78afdf.camel@sipsolutions.net>
	 <4b5764f0-d2c0-12ce-56bb-73c07ab59ebc@cambridgegreys.com>
	 <d6ac37b196ebc0443997a942f8efb16a69e424fc.camel@sipsolutions.net>
	 <18290c11-2d97-3aec-3fd7-b3dd0d33a88b@cambridgegreys.com>
	 <2d041a80-0ba4-d48b-07b1-b1bc835b3e0d@cambridgegreys.com>
	 <4d772184b2b39944de8444b0a6f437581297e1d4.camel@sipsolutions.net>
	 <300c0b28952b2837efbb5c59f38944b02b7722f2.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_091757_755201_A8A3CEA2 
X-CRM114-Status: GOOD (  16.56  )
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

On Wed, 2023-09-27 at 11:52 +0200, Benjamin Berg wrote:
> [SNIP]
> Once we are there, we can look for optimizations. The fundamental
> problem is that page faults (even minor ones) are extremely expensive
> for us.
>=20
> Just throwing out ideas on what we could do:
> =C2=A0=C2=A0 1. SECCOMP as that reduces the amount of context switches.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Yes, I know I should resubmit the patchse=
t)
> =C2=A0=C2=A0 2. Maybe we can disable/cripple page access tracking? If we =
assume
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initially mark all pages as accessed by us=
erspace (i.e.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pte_mkyoung), then we avoid a minor page f=
ault on first access.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Doing that will mess with page eviction th=
ough.
> =C2=A0=C2=A0 3. Do DAX (direct_access) for files. i.e. mmap files directl=
y in the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host kernel rather than through UM.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 With a hostfs like file system, one should=
 be able to add an
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 intermediate block device that maps host f=
iles to physical pages,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 then do DAX in the FS.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For disk images, the existing iomem infras=
tructure should be
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usable, this should work with any DAX enab=
led filesystems (ext2,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ext4, xfs, virtiofs, erofs).

So, I experimented quite a bit over Christmas (including getting DAX to
work with virtiofs). At the end of all this my conclusion is that
insufficient page table synchronization is our main problem.

Basically, right now we rely on the flush_tlb_* functions from the
kernel, but these are only called when TLB entries are removed, *not*
when new PTEs are added (there is also update_mmu_cache, but it isn't
enough either). Effectively this means that new page table entries will
often only be synced because the userspace code runs into an
unnecessary segfright now we rely on the flush_tlb_* functions from the
kernel, but these are only called when TLB entries are removed, *not*
when new PTEs are added (there is also update_mmu_cache, but it isn't
enough either). Effectively this means that new page table entries will
often only be synced because the userspace code runs into an
unnecessary segfaultault.
=20
Really, what we need is a set_pte_at() implementation that marks the
memory range for synchronization. Then we can make sure we sync it
before switching to the userspace process (the equivalent of running
flush_tlb_mm_range right now).

I think we should:
 * Rewrite the userspace syscall code
   - Support delaying the execution of syscalls
   - Only support mmap/munmap/mprotect and LDT
   - Do simple compression of consecutive syscalls here
   - Drop the hand-written assembler
 * Improve the tlb.c code
   - remove the HVC abstraction
   - never force immediate syscall execution
 * Let set_pte_at() track which memory ranges that need syncing
 * At that point we should be able to:
   - drop copy_context_skas0
   - make flush_tlb_* no-ops
   - drop flush_tlb_page from handle_page_fault
   - move unmap() from flush_thread to init_new_context
     (or do it as part of start_userspace)

So, I did try this using nasty hacks and IIRC one of my runs was going
from 21s to 16s and another from 63s to 56s. Which seems like a nice
improvement.

Benjamin


PS: As for DAX, it doesn't really seem to help performance. It didn't
seem to lower the amount of page faults in UML. And, from my
perspective, it isn't really worth just for the memory sharing.

PPS: dirty/young tracking seemed to be only cause a small amount of
page faults in the grand scheme. So probably not something worth
following up on.


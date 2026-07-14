Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992AFC44508
	for <linux-um@archiver.kernel.org>; Tue, 14 Jul 2026 14:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iM8SB61kZfRlZBBjK1HisTzxprKerLF7NioQQq06LHM=; b=ickNHxnJXguWAa9UGwBXqua6/0
	yLhndNWGfmopEzzjaMTsCWA7eFdSJMSdsIpl1BIiJp+BUVgRhfe8mHh9H/90rAPR+JouQjTYDP5sW
	vSObBBJsf6Gk0tVnaGAS2K1730FMPVMRH7FAyeczoj3byuIOTvXzPucOVYI+8b6HrxYLbzdkiDJ71
	lzH89nV9wLcZdKci6jeWru2/gHmFpuFJFLuR0OaFh4YIY8q6HS3wHHOwgb54/FcGbuU/CLw1J6lBy
	bl+fa4rt8xLKJLaswCpBzgTEf1OZXml+AIzekYNshfU67ws4sXHhVdps4FN3kwq/hPFsDtDSGKQYa
	ZV3YNAlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdmU-0000000CIqR-0x5x;
	Tue, 14 Jul 2026 14:06:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdmR-0000000CInl-2UaQ;
	Tue, 14 Jul 2026 14:06:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=iM8SB61kZfRlZBBjK1HisTzxprKerLF7NioQQq06LHM=; b=F5dPx4DZ8KWGAP6dnhc9pQlmfr
	uONk3NteFAlwHdUvvWGXFAJ7DCLPuhRnP5Ymg9upGOOJfdi9FwygTtUzNs6guDHdun6gLQ4XG8jdw
	U7WY4GhEYQmTls007Ik0cB0cfXRJ4vgXuA/GtqA60W5JHunJgMFcRCfI5pzE9iXrkHvF1dFIyjpep
	tp7033QnJTSRi9DNkAL+7SbM8StPWS/BiodGW9W8boT5UzqYhQD3Cv+dl8GbGVKfQ90Glonmd43Wm
	CzLgYiys0Er9INeuVB65HcPX9TVNgGdHFAaWIwOq/EOnq/roBgiCOkjX7i+K1h+IzlMXxhV6WS1FT
	ZJdJuIRA==;
Received: from foss.arm.com ([217.140.110.172])
	by desiato.infradead.org with esmtp (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjdmO-0000000CZ9y-3DTM;
	Tue, 14 Jul 2026 14:06:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8A9E1BF3;
	Tue, 14 Jul 2026 07:06:30 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE3913F7B4;
	Tue, 14 Jul 2026 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784037995; bh=brubU8ipNy1ujnPWOSJsU4D9Csfsl5oNxDWj3XnSBxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YzY9thwiHc65wNiUxU67y6/tJ7ZmfWCBeoA2a4LNQMo0O7ibHK6ctA9ComeTUEm9C
	 I/qi+0IpZSq41xPb+OZ7Z3/G4uCkw9cLd6IhSMUabwxmOQOqx2sF6D5jJAoetl8ck9
	 oA5zuyScXswzHCcI9ibhnX1aroPeO+YpvDY2p/3g=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:00 +0100
Subject: [PATCH 11/22] um: mm: use mm_is_kernel() in TLB sync
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-11-44be8a7685d7@arm.com>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
To: linux-mm@kvack.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org, 
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-s390@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ning Sun <ning.sun@intel.com>, 
 x86@kernel.org, tboot-devel@lists.sourceforge.net, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org, 
 Vishal Moola <vishal.moola@gmail.com>, Alistair Popple <apopple@nvidia.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=784;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=brubU8ipNy1ujnPWOSJsU4D9Csfsl5oNxDWj3XnSBxg=;
 b=/PzTb9tRgc6q7ZO/WLmLmpzghLV5CdRWiA/u95e31NiKnKwzFm+3cKJU2/zrnT5S/P+reJB4V
 ezvWWMbftRCD/SWI9ofvYfumKl5AhLTyCVWAwhB/2VFq3mOJHXdgNVl
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_150637_080013_9D76E52E 
X-CRM114-Status: GOOD (  12.57  )
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

The new MMF_KERNEL flag identifies kernel-owned mm's. Checking the
flag with mm_is_kernel() is preferred over comparing directly
against &init_mm.

No functional change, as only init_mm has MMF_KERNEL set for now.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/um/kernel/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 1f175716b474..fa34a710203e 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -171,7 +171,7 @@ int um_tlb_sync(struct mm_struct *mm)
 		return 0;
 
 	ops.mm_idp = &mm->context.id;
-	if (mm == &init_mm) {
+	if (mm_is_kernel(mm)) {
 		ops.mmap = kern_map;
 		ops.unmap = kern_unmap;
 	} else {

-- 
2.51.2



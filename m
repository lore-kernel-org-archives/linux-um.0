Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265DCC4450A
	for <linux-um@archiver.kernel.org>; Tue, 14 Jul 2026 14:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2AtuGnMkKUmg5Fcb42sI1/yhBOPgS1GscsBtzFqMWqA=; b=rBNRWAs1rn/DDqddQzwlwiaRnh
	DPplL/eTBc0pU3Qe9F5DKUYDaCZ/iuY91oww4TlSSeb1aXrxCh1cUR+boykVnROHW53k/9wGti473
	cuoD7lqAr4Jm4RuW0GOOh+2iLoa1b6AH9JgmW4/fQMMmnMj/ZCGqVFbJMXkxKg2CsJFcdTM1XuLdr
	LeuCFHw5KZ2lyMrtwBDY+l2bKCLxwRWdTNFzpRT9l/Ejw4j8ZjSTmY5nOkWPHPQgoE6+zpHyDse9h
	FXmyWQqtYQzvAHg5JA0gaclYxk7alycJDgkWLr6ASd22zurJZcewKs0rBnla1fh7DxX+IznAtKTgV
	7j85V9uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdnC-0000000CJbR-30yC;
	Tue, 14 Jul 2026 14:07:26 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdn8-0000000CJVx-0r1d;
	Tue, 14 Jul 2026 14:07:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49CFE1CDD;
	Tue, 14 Jul 2026 07:07:17 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 211913FBB1;
	Tue, 14 Jul 2026 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038041; bh=W5yMHnXfWcnH1ZpiyUJxzPFiGyzR0nmofTO/4v3XglM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tcs2QjbOfi2UrOaEb3Be0yDpY6GZomCe7QbbhuAt79rvxsFv0nPzL+CWkgYpCVks/
	 ogkFHzzFifaJTeH1MCRm+XyD/611Im1Ut2kp5sQ9dzHO1o7eUkGFrrRiH6Z4V/RDtz
	 /vlFqoX8JwYVcEUc2qvYwpr+Gn4LoNg3DQ/uWfI4=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:06 +0100
Subject: [PATCH 17/22] mm: pagewalk: drop redundant address check for
 kernel mm walks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-17-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=1902;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=W5yMHnXfWcnH1ZpiyUJxzPFiGyzR0nmofTO/4v3XglM=;
 b=TFBgeJD80Ix+w11MAOvfP3+Vh87dI14Hnq0FHr8NrSRBwD9XPKoZw/aAqVJc1+sG5OV8cIA+P
 hlg2L1E8nGiAdR9B4tzknmDLhA26Dhv64+3Fs4YGAcZ8Y3UcdoWIKP6
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_070722_361770_0E56D3C9 
X-CRM114-Status: GOOD (  13.56  )
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

Commit 8b1cb4a2e819 ("mm/pagewalk: fix EFI_PGT_DUMP of
espfix area") made no-VMA page table walks use
pte_offset_kernel() for any address above TASK_SIZE. This avoided
pte_offset_map() validation on EFI page table dumps, where efi_mm
could walk x86 espfix PMDs that intentionally look bad to pmd_bad().

efi_mm is now marked with MMF_KERNEL, and no-VMA walks use
mm_is_kernel() to select pte_offset_kernel() for kernel mm's. As a
result we no longer need to handle the EFI_PGT_DUMP case explicitly.The
address check is therefore redundant for EFI_PGT_DUMP and makes the
condition harder to reason about.

Remove the address check and associated comment; mm_is_kernel()
should be sufficient on its own.

Tested by booting x86 QEMU with CONFIG_EFI_PGT_DUMP=y and reading
/sys/kernel/debug/page_tables/efi.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 mm/pagewalk.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index a3f47d1de3c5..0dd9d4ad9b68 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -68,17 +68,14 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	if (walk->no_vma) {
 		/*
 		 * pte_offset_map() might apply user-specific validation.
-		 * Indeed, on x86_64 the pmd entries set up by init_espfix_ap()
-		 * fit its pmd_bad() check (_PAGE_NX set and _PAGE_RW clear),
-		 * and CONFIG_EFI_PGT_DUMP efi_mm goes so far as to walk them.
 		 */
-		if (mm_is_kernel(walk->mm) || addr >= TASK_SIZE)
+		if (mm_is_kernel(walk->mm))
 			pte = pte_offset_kernel(pmd, addr);
 		else
 			pte = pte_offset_map(pmd, addr);
 		if (pte) {
 			err = walk_pte_range_inner(pte, addr, end, walk);
-			if (!mm_is_kernel(walk->mm) && addr < TASK_SIZE)
+			if (!mm_is_kernel(walk->mm))
 				pte_unmap(pte);
 		}
 	} else {

-- 
2.51.2



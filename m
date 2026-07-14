Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27719C44508
	for <linux-um@archiver.kernel.org>; Tue, 14 Jul 2026 14:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=phHpo+Wmxx36MHxPj4C/6kUHr4sSD0fM0/8i7RvNHM8=; b=XCcg3UWxDr7SMwltp2QFqLydST
	83sNtCCOmAXGURyuknHzYymTeCUniNpBY25dlgvDX0JmTNr9Xbfr7MQiXrUHXrIXaPsPJ15aCvmiK
	v5BlRQjCBa7fhyeLR3oidpU6S9lNJJcu/ZhcmaHXttd/1jHQCgeIXG9Avfxg0NGNOnFpYygcBCkRd
	8eI9VTjZnyYyUERs1D3H5/EbkDppXxcNro27QYLzKfTqUH+ufaSNwc+FOkVOHzIfyXZbqp9A6D70V
	kABgNJyMTGNZhxDzsC6717O4ZhrkhDnFHFipqh2ua5RbUXzauoIW0+KjZNJrjtDy5U2uuPQwSljA/
	BAtRkbDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdlD-0000000CHcg-3HVA;
	Tue, 14 Jul 2026 14:05:23 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdl8-0000000CHZT-3Izs;
	Tue, 14 Jul 2026 14:05:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2F2C2F;
	Tue, 14 Jul 2026 07:05:13 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DEFC3F7B4;
	Tue, 14 Jul 2026 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784037917; bh=w+klhTdFU9VL3dvxDzm8zfdFs5zqm0APSZWeudQBGNo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZNaRsCzAt1MnFAcOqfXFWvT4T4lPSEzMCEGtQrD8PcOucfEtWoppc1fCEKGc9cJXK
	 6RWZuY1RJvPlk32rxkdaZDZjs4oIrAl0+EdZq5ACM4/oIU1EOINAjEPtOBYdtmnjAy
	 gQq/h8AoBHc7SVStww7Gu1VeAurSqfnl+VdiDEVc=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:03:50 +0100
Subject: [PATCH 01/22] mm: drop unused __mm_flags_set_mask_bits_word()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-1-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=1348;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=w+klhTdFU9VL3dvxDzm8zfdFs5zqm0APSZWeudQBGNo=;
 b=Ifi0NsVAxXOM3X00d29l/TBqH4M9i/euaIMaezX4RjYeZIsEEEbWOkkWnSKDmLxeFJ4OWFsJu
 hMlhl3GESzgCyZw7KMYDONi2E6s1qECPsAJEDuKo4qx+p6nf5J2ydG5
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_070518_933510_7E89C1CD 
X-CRM114-Status: GOOD (  10.46  )
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

Commit 39f8049cd49f ("mm: update coredump logic to correctly
use bitmap mm flags") added coredump-specific helpers for the
remaining masked mm-flags update users.

That left __mm_flags_set_mask_bits_word() without any callers.
This is a special-purpose helper that is unlikely to be useful for
other purposes; best to remove it.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/mm_types.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ae9bca4eda5c..b4129beb9c4a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1432,18 +1432,6 @@ static inline unsigned long __mm_flags_get_word(const struct mm_struct *mm)
 	return *__mm_flags_get_bitmap(mm);
 }
 
-/*
- * Update the first system word of mm flags ONLY, applying the specified mask to
- * it, then setting all flags specified by bits.
- */
-static inline void __mm_flags_set_mask_bits_word(struct mm_struct *mm,
-		unsigned long mask, unsigned long bits)
-{
-	unsigned long *bitmap = ACCESS_PRIVATE(&mm->flags, __mm_flags);
-
-	set_mask_bits(bitmap, mask, bits);
-}
-
 #define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | \
 			 MT_FLAGS_USE_RCU)
 extern struct mm_struct init_mm;

-- 
2.51.2



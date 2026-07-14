Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F9BC4450A
	for <linux-um@archiver.kernel.org>; Tue, 14 Jul 2026 14:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KoCRR95PLYnVxjBQ0+K98Mlg61rzeKsyaOHBI9FlQ+0=; b=cGY0xEilobiORjnSMPlwMtz0FM
	6wX9cuRX0jp8onSiZUn/iJiPWHnsgr2cDoWgIBb+s/kTCIVn6Ps1CM43M9eJ/Eo5AWi2I45ICJ7En
	9NkbLOskrHxnQbodBc8WxH2G8EO0o6P5CZz3X5MK7WdKLAjV8th4wvXeOSHYYP/QQJrfVdgEWrSit
	XM5yCWNhjEca9894t6Hg1jW7FMLGgRpr3uIEVnRD3S7T/Pk4tHQq/AhsoVWtqdyutO/nhYvg/YF2Y
	6MDZ3MQu4OIqDcd4qmL93zExT/m0/a2QGnJ37ouvcM8ZMy4lwx7ywRB7PayuXOjB6XN182tRKO+XX
	G6YJVH0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdnV-0000000CJto-1nea;
	Tue, 14 Jul 2026 14:07:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdnS-0000000CJrJ-0r05;
	Tue, 14 Jul 2026 14:07:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Cc:To:In-Reply-To:References:Message-Id
	:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=KoCRR95PLYnVxjBQ0+K98Mlg61rzeKsyaOHBI9FlQ+0=; b=RVhDY+cchUV5PrzgcRRc2FHCHf
	KdbMrBO+HVvQPqxakQomEz6FGcYC0J7Y7LwtXtn4Xy7Jo4+AiwCccYz/xYthjNnjmmYjKFhRshiSL
	EneWCNgydeBXxEW680FCLPUqop7CFUjP4Hciv44s4LZVqfZRRnIdzffZuWHPnvNcIqG+zUcTGKtJo
	iWSEYDsmvGzrzyYBz1/QrI7F7SXqOFeWIubQyKpni+gIEzquPK1bbxrAI/7u4TZRzFnJpZDye+FxI
	/U4Xfx0FW3E1y9Umatz2P9p8Oo0WuvP/Sncutu16RntVjl7zZh5GT7JFh3gwwksTcCzMxH9vqiSc6
	4U+SOs5w==;
Received: from foss.arm.com ([217.140.110.172])
	by casper.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdnO-0000000FCwy-3shv;
	Tue, 14 Jul 2026 14:07:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B74CB1D14;
	Tue, 14 Jul 2026 07:07:32 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FA7E3F7B4;
	Tue, 14 Jul 2026 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038057; bh=VrWlMtHqgM/vx22jiN3vYsU+W1Lh9jxCM8/DJ3H1HHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X2EPALpiGXj7jZ//umW0i2ZiscPs5c3b9FVhjQsTjSc/roIUOCw5ccwKbAM8AZVT0
	 R190qpIisEqdGcWQOaI8LP3WSMdBvOg2L0DaCq9z+740FCzemmIORnkMA6TGphJBf+
	 c9VjfZElkzX4N0E1s95w/Vtd50JJkhxZY+d0MtYw=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:08 +0100
Subject: [PATCH 19/22] x86/tboot: mark tboot_mm as a kernel mm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-19-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=1553;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=VrWlMtHqgM/vx22jiN3vYsU+W1Lh9jxCM8/DJ3H1HHw=;
 b=m8zZWjxysI7gu08ZC5WjroF8ppS2XmCi+NSg9AchPnK6c6wz3EcnLIwt4UrkZ1Tknhd8Uq+lO
 humwu8pswzNB3IZSFZsQqWeKm+RG8SsPRg6CN1eLU7ZKufXomLaUKal
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_150739_293441_DABA4406 
X-CRM114-Status: GOOD (  16.73  )
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

tboot_mm is a kernel-owned address space used to build the
identity map for tboot shutdown. Mark it with MMF_KERNEL so
page table allocation and initialisation code treats its page tables
as kernel page tables.

Having marked tboot_mm as a kernel mm, we also need to convert
pte_alloc_map() (user PTE) to pte_alloc_kernel() (kernel PTE), and
drop the matching pte_unmap().

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/x86/kernel/tboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 46b8f1f16676..08c899f88e41 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -99,6 +99,7 @@ static struct mm_struct tboot_mm = {
 	.pgd            = swapper_pg_dir,
 	.mm_users       = ATOMIC_INIT(2),
 	.mm_count       = ATOMIC_INIT(1),
+	.flags          = MM_FLAGS_INIT(MMF_KERNEL_MASK),
 	.write_protect_seq = SEQCNT_ZERO(tboot_mm.write_protect_seq),
 	MMAP_LOCK_INITIALIZER(init_mm)
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
@@ -129,11 +130,10 @@ static int map_tboot_page(unsigned long vaddr, unsigned long pfn,
 	pmd = pmd_alloc(&tboot_mm, pud, vaddr);
 	if (!pmd)
 		return -1;
-	pte = pte_alloc_map(&tboot_mm, pmd, vaddr);
+	pte = pte_alloc_kernel(pmd, vaddr);
 	if (!pte)
 		return -1;
 	set_pte_at(&tboot_mm, vaddr, pte, pfn_pte(pfn, prot));
-	pte_unmap(pte);
 
 	/*
 	 * PTI poisons low addresses in the kernel page tables in the

-- 
2.51.2



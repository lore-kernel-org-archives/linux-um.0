Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FEBC4450B
	for <linux-um@archiver.kernel.org>; Tue, 14 Jul 2026 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dz69MptF58JspLJ2rtF7ybUAV2FIyyNhQ9HifHNaDpQ=; b=bFrjeSZk2KfZxab1vH3Le44Tma
	2SYPVXDBw9z341ir4MxkGvXgPBm4YiRpKoZa/JaSGeTONkKyGrzvDv6PVkrXqCQvkJrHY+ET40JqT
	++FF9cg0b53gFpFcIC0bpmbnAB6nY+PfISZ9x+5t2n3wBQxu2LXwvpj1U7g04bZbzpSKLr5UJhbn2
	dm09ADI+c+rwdFoF5a//8z6WUC8F2lV5yZgvQAx/O0BfPyr7LLDGxZjihETIYk49FQmmjHzzGGNrV
	jeMZr+sWhfMIGOs5G5wWLS2xybdW/QOhkkB3qcHvTzMyYX/208HiBqOVv2NU/s8Tw1zpHDCctU71G
	Koq5WyEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdlt-0000000CICd-2NiS;
	Tue, 14 Jul 2026 14:06:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdlr-0000000CIAa-2MNJ;
	Tue, 14 Jul 2026 14:06:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=Dz69MptF58JspLJ2rtF7ybUAV2FIyyNhQ9HifHNaDpQ=; b=MVhHg+VTAxmCvEtRQqqmK6tGxz
	6KtPmDY65y7T37DyobcCNKT+XFwUCtDsuJ/UrYCQNKvKc92AUm8D+o+Jm0G3ZTYIiFo+ErpdxnhH6
	Uiskz6v88Joqgybfidb/qwdN23qHaPi4N4M+kYIRSGqlCkaGkYDdJFJvKSgOKKYXBKWEn+K8xrrS4
	eXDLnEyGqsb2oV8kp/TsUlngv39WTBJ2xN7kivdRda8hmRGLUskC9YwRMoAk0DaIRoiAwQtrgilsg
	VlhJryElRNQWBPsJiPVaNsIfZhnIsKfdaDpKeJyvGFA6P1Pj3gVdULsINTWax0Taot1hzk2g4ENKa
	BpNz8S5Q==;
Received: from foss.arm.com ([217.140.110.172])
	by desiato.infradead.org with esmtp (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjdlm-0000000CYvz-2kCs;
	Tue, 14 Jul 2026 14:06:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46E591570;
	Tue, 14 Jul 2026 07:05:52 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21DE63F7B4;
	Tue, 14 Jul 2026 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784037956; bh=VE+lHAHWK4dpsc9V3W/UPtkE4aBmXym2FNHO+k6axB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GBHbIxSv6yx6lpCATNlxlwrGWzZkjE50qqNWmTtSfC55Qij6ibNwZaI+5R9T7uiWd
	 i/VIOmdvMtutA0FQwIru3Tr0+8ZG+pxZmXfmR5SvbAQB1BQh7BgutmvfbwIFq0TwaI
	 MOql+/rIhlaU8c8MGd+SNjdFNyN/NAYTkzmX9Pu0=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:03:55 +0100
Subject: [PATCH 06/22] loongarch: mm: use mm_is_kernel() in
 switch_mm_irqs_off()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-6-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=1057;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=VE+lHAHWK4dpsc9V3W/UPtkE4aBmXym2FNHO+k6axB4=;
 b=vNqbzx2iMvV1fGidU2iKtjDvRxNSiS8E7MvYIjkLSIIndPb41plWi7UyNf7PU14qsGJzzjbPF
 x7c/ZLWX2B8DhFd7ct6QVQiE/yCdMoFkL2mbSBPv7/C7wV2jkBlaVC2
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_150559_501172_16BF8A02 
X-CRM114-Status: GOOD (  11.77  )
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
 arch/loongarch/include/asm/mmu_context.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/mmu_context.h b/arch/loongarch/include/asm/mmu_context.h
index 304363bd3935..6d51f11427b4 100644
--- a/arch/loongarch/include/asm/mmu_context.h
+++ b/arch/loongarch/include/asm/mmu_context.h
@@ -95,7 +95,7 @@ static inline void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *
 	if (!asid_valid(next, cpu))
 		get_new_mmu_context(next, cpu, &need_flush);
 
-	if (next != &init_mm)
+	if (!mm_is_kernel(next))
 		atomic_update_pgd_asid(cpu_asid(cpu, next), (unsigned long)next->pgd);
 	else
 		atomic_update_pgd_asid(cpu_asid(cpu, next), (unsigned long)invalid_pg_dir);

-- 
2.51.2



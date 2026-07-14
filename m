Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B07C44501
	for <linux-um@archiver.kernel.org>; Tue, 14 Jul 2026 14:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2eT5LgtVDR1PdMidQbZQUNMVcJjW/kv+exPqkO9uaE=; b=0RN5N1SfHrXNckoq7qqtZryZzY
	YoMuxYbinSOZXvOpyn7JnU/xYJZZ1SDxZUct0uDLjerQOtN9hI60j22WwLFxiU9Mg8qQiRy98Jrzl
	A253LYrgKdULvDRHQr1t+PneWW0cM1/AwM+69lL1gco4EAk4UcuLX7LLGe0/afQkQfUBI+egdx0de
	7lV6dpAn7FoQJaI91fEw5h+oyquxsnh9zTe/JUefZGEGgqZ+WjFSY3oTIAbUBbAFHaOCir9Gj/unW
	UmWtH2357bFzwfBj6t+m5NMBrRSjPv82/DYWrrJDRSjcW6Mz1SPWvkMX6rn0RrDSNB+ZzI9yfPdj5
	0cJ2+iAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdmw-0000000CJNB-3WGO;
	Tue, 14 Jul 2026 14:07:10 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdms-0000000CJH7-38dX;
	Tue, 14 Jul 2026 14:07:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE41D1576;
	Tue, 14 Jul 2026 07:07:01 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6BF83F7B4;
	Tue, 14 Jul 2026 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038026; bh=wRRvDY7vvj6o45l8yT2Q7WPIKaOL0Wfu1AKN4gUTBNM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CCHuQj4boJkfZHO19ek7AVQhcn2j5x9Inj92YhvCDOQNMYxw1wJHqVP3lNtmrXDor
	 z8dfztuTF5HxmmtkzWEn0bGB/ntiIdARdTp3OUTIiy6d1Pv6qDLGuwuR1khXjO+Vzy
	 5ViCvZtIVrztie1QTQbSWYbDcViyYQGhZmv5eaSk=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:04 +0100
Subject: [PATCH 15/22] mm: only initialise pt_share_count for user pgtables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-15-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=1093;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=wRRvDY7vvj6o45l8yT2Q7WPIKaOL0Wfu1AKN4gUTBNM=;
 b=Ly1CUGmQU4MNOAvYijXTm6a0Oy5bg25WoXD9BoAv+N4SapepeLDfsykLmzz2cpJ5XS9tuoOVI
 p8vbo57maMnDOD6whiBPPJLuCq0Skgv9I5RprwD5SM3O65zdB1a2N0T
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_070706_896949_98D22190 
X-CRM114-Status: GOOD (  13.03  )
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

ptdesc_pmd_pts_init() initialises the pt_share_count ptdesc field.
That field is only used for hugetlb tracking purposes, so there is
no need to initialise it for kernel page tables. Skip the call for
kernel page tables, like pmd_ptlock_init().

From now on pagetable_*_ctor() and pagetable_dtor() do nothing for
kernel page tables.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/mm.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 94f0fb1c662a..b217ccbed5a3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3905,9 +3905,12 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 static inline bool pagetable_pmd_ctor(struct mm_struct *mm,
 				      struct ptdesc *ptdesc)
 {
-	if (!mm_is_kernel(mm) && !pmd_ptlock_init(ptdesc))
-		return false;
-	ptdesc_pmd_pts_init(ptdesc);
+	if (!mm_is_kernel(mm)) {
+		if (!pmd_ptlock_init(ptdesc))
+			return false;
+		ptdesc_pmd_pts_init(ptdesc);
+	}
+
 	return true;
 }
 

-- 
2.51.2



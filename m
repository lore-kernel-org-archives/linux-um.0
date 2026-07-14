Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA36C44501
	for <linux-um@archiver.kernel.org>; Tue, 14 Jul 2026 14:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NDua9YY87aM7LX6RKGHHq5cosBzReZwnFG+9/6p63CY=; b=Tupc6k8K0wNZWF0WHRPxn0XN82
	0mCamR74M9ERanYs76l3u9zMv2DYme/0b9aumufWzLRu7Zs3nMJ54jw9CRGk685d9xA3C0N4gtWKf
	QpFj4DMQN/1LwzWRdiqKLT8iQLVSdOxAK17gGEr2yTeu+09miu2RlifzFyASGP+HU73IgigGt1UWE
	OEGYEk1EoMvnbhMbEv0iqQsKl3ulgVdj7s36bfNUEkTuOQroJ4CRYpiPeEU4DfAWrspyj636lHUYu
	FqvicNBzm/k0Mmq02EP+aQ/6Mczk++2tozn89T4vBAFRT9r/8eSN78LUKTYUHTN7z3Jqg0s285t0X
	HIhkWTRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdnk-0000000CK8W-1mia;
	Tue, 14 Jul 2026 14:08:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdnh-0000000CK58-0bkQ;
	Tue, 14 Jul 2026 14:07:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=NDua9YY87aM7LX6RKGHHq5cosBzReZwnFG+9/6p63CY=; b=dz1T5NVWVFLd9u7GHFeddGhFEk
	z6CJ5VH9MmmWrydxHo3lCXKbEVnCzst6BCG8SF5Vj/s3EMjp/D4p2r+hu9lF5wAba3RbHiUv3JTGD
	gXDbS1ciXGeAumVTXgm79aWYCsEj7c9iTXmweWIy57ID6rP9qndqpDMVEqUbeOi7Ujaz6/d4fqbuH
	mNiL3tDYFoS+np3rsXcjyrqFvRgDANzdSMw/72BZZ/YddNH9SH+zyELHu9X6j8fQdT6hGjcmHLk0A
	97XYcaXZhIC1KoXURWY2Jh2ltKBnKY81bIpgOdDDttNZDReCpjEIBdugos760ZiVs3mkni65KunjO
	99/HqQ2w==;
Received: from foss.arm.com ([217.140.110.172])
	by desiato.infradead.org with esmtp (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjdnd-0000000CZf4-3pqZ;
	Tue, 14 Jul 2026 14:07:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DE4E1CE0;
	Tue, 14 Jul 2026 07:07:48 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A8183F7B4;
	Tue, 14 Jul 2026 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038072; bh=8oYQ9MXuYWmm90weLSF/t4FrSgRMmgMLSgcdK785vME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vjhfq5hujZgmkhySuJNw6Ovi0ZDPllrwytdpUl1CFaMMmQ7YlrA+FTdxr6ytaSSAO
	 1u9NsJ08KRRDg8iJcOgusKSxciglroRswKdfyUOkoGu8QXjmncAKV2aqeRer5z/ygB
	 q8OYyTsSmA+9Qr1jQYJQdHlBqhCMBgipf8FFPhm0=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:10 +0100
Subject: [PATCH 21/22] arm: mm: drop ctor call for kernel page tables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-21-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=861;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=8oYQ9MXuYWmm90weLSF/t4FrSgRMmgMLSgcdK785vME=;
 b=nhPVpPwxc0Tgep45F4r22gVJiYH4IqNiA/Z9S3Ix77hbH+m9X9zzxN6EovZVFIEF1e8oAreuL
 YHrL6dXW1utB0IBYjmbnRvx5pXQ0zPIU5EqMprfu37YqfA5Aaxh0XUC
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_150754_298519_6786D5D4 
X-CRM114-Status: GOOD (  12.10  )
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

Thanks to recent changes:

* pagetable_pte_ctor() does nothing for kernel page tables.

* efi_mm is also treated like a kernel mm by the page table logic,
  including ctors.

We can therefore drop the ctor call when allocating special kernel
page tables in mmu.c.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm/mm/mmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 23b87b5ef7f1..c8de77a6f01e 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -728,8 +728,7 @@ static void *__init late_alloc(unsigned long sz)
 	void *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM,
 			get_order(sz));
 
-	if (!ptdesc || !pagetable_pte_ctor(NULL, ptdesc))
-		BUG();
+	BUG_ON(!ptdesc);
 	return ptdesc_address(ptdesc);
 }
 

-- 
2.51.2



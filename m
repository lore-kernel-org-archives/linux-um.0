Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E76C02181
	for <linux-um@archiver.kernel.org>; Fri, 24 Jan 2025 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FHz4xRyFvnCB+fzQfYx1bd2piIN9WzxnnPBHmtG/vRk=; b=1AlcaEzeR4c5OgdaXoIPBJoKeu
	Qp40/EwSUyKTt5A2Zm0N3D8Cc+RMtaDswLD9KD1qWugRbbClyfquo8qxtaNLIot0vIpi1kPZphKKa
	ErosQ5lSxnbAdHVWyvs/0+Wu2kzBHC5tN9RrR70Om4WIDfW2ZUBV3MbtGugOrBNe6gMWw/ST0INNW
	sTiHD5xgSvNSYkXzB14imt20E8mF/JJttuuh9rMxj+z2wkVQ6ImRnyZumyyoPJ0+FDt/ZmdmFG1Nc
	ZlSib2XMl8a3hQiIHiRt92SWFoMDKIjOyfE7hfSXNDT3LfTX2MuOHHt6w+6l5ghZNYMlFa4d1lTXI
	i7jAGOag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbIAQ-0000000EbUD-3AbA;
	Fri, 24 Jan 2025 11:48:06 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbIAO-0000000EbSP-42tZ;
	Fri, 24 Jan 2025 11:48:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FHz4xRyFvnCB+fzQfYx1bd2piIN9WzxnnPBHmtG/vRk=; b=BUvQ8lthZ9k+2zHpGZvP9tKKD1
	lquaViIsl97XMxi+w8EPv26S5U4qI49wLbq/7Z70Dx1PNQlAWLNHyX5MOxOeVxP4Nte4BT4YUIzDX
	F52rfiWnKleajUvXOvI/YtkLPGiQgfJbZ65zkBnOUrhxWnmgueeVKpxckt259crPtJcZ5rXVXpoFM
	syCjHshJlr2WeOAArElAVkHqGgsD05TidNMiKYomegI18TgNnu1EUL7Y8XuoZThBl3xAcYvswTFQ+
	+U1i57UNVCfKIrAKHrrJDCOr78rXxcqssi79dyjWqepk2cPB8NNNMD1JuTWfQw+x7WshfCesUldTR
	AWx3WONg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tbIAK-0000000FV1z-0JOS;
	Fri, 24 Jan 2025 11:48:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4550D300619; Fri, 24 Jan 2025 12:47:59 +0100 (CET)
Date: Fri, 24 Jan 2025 12:47:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: kevin.brodsky@arm.com, riel@surriel.com, vishal.moola@gmail.com,
	david@redhat.com, jannh@google.com, hughd@google.com,
	willy@infradead.org, yuzhao@google.com, muchun.song@linux.dev,
	akpm@linux-foundation.org, will@kernel.org, aneesh.kumar@kernel.org,
	npiggin@gmail.com, arnd@arndb.de, dave.hansen@linux.intel.com,
	rppt@kernel.org, alexghiti@rivosinc.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org, x86@kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/5] remove tlb_remove_page_ptdesc()
Message-ID: <20250124114759.GB15996@noisy.programming.kicks-ass.net>
References: <cover.1737637631.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1737637631.git.zhengqi.arch@bytedance.com>
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

On Thu, Jan 23, 2025 at 09:26:13PM +0800, Qi Zheng wrote:
> Hi all,
> 
> As suggested by Peter Zijlstra below [1], this series aims to remove
> tlb_remove_page_ptdesc().
> 
> : Fundamentally tlb_remove_page() is about removing *pages* as from a PTE,
> : there should not be a page-table anywhere near here *ever*.
> :
> : Yes, some architectures use tlb_remove_page() for page-tables too, but
> : that is more or less an implementation detail that can be fixed.
> 
> After this series, all architectures use tlb_remove_table() or tlb_remove_ptdesc()
> to remove the page table pages. In the future, once all architectures using
> tlb_remove_table() have also converted to using struct ptdesc (eg. powerpc), it
> may be possible to use only tlb_remove_ptdesc().

Right, so I don't think Sparc and Power care to use ptdesc, they're
using non page page-tables.

At the very least we should do something like this, the only point of
having tlb_remove_ptdesc() is type safety, there really is no benefit
from it in any other way.

---
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index dec030cb1210..a6731328db6f 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -504,7 +504,7 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
 }
 
-static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
+static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
 {
 	tlb_remove_table(tlb, pt);
 }


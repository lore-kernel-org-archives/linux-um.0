Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5339CE77188
	for <linux-um@archiver.kernel.org>; Fri,  3 Jan 2025 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CPGOdr/jsXJNO5Wu3fEBGF99GP73lSQF/IKxQW4k0R4=; b=WoSEv1SGe8UhXlhwVjUZKWDyDz
	spQUNRIVkLt6XdBlGjXv7TSu4ShrhalSHh2EUYAdn3dlnaMj/L/uFLHMPzO2Y38aPkY5jpp7vQXhi
	Z63euG95EmnyTJ6s1v6wW/KtJP5q0a2mQBU+9rWpv58dNXlGWkJ7tZHU8P3u+6T0KzbEQoyIHRUUv
	xtRu7g061qZNUBdlncCLg5a6GE2MVp1XMZIn5N4qK+60vBnwDbCknPGw9ZS4R1sLjaDUDfi8PkxpK
	t5GtA29ohL0rR+bTCuuZYr+HMntWOXDtjqs50Sq9vQSayMPCRfBvcDHKJeRrtTiDGnlDhjZehFFyo
	o0ESqSAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTff9-0000000CnyC-2XKi;
	Fri, 03 Jan 2025 11:16:19 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTfdw-0000000CnoI-1ZoD;
	Fri, 03 Jan 2025 11:15:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CPGOdr/jsXJNO5Wu3fEBGF99GP73lSQF/IKxQW4k0R4=; b=Tf96QP1nI5zee8m+i5u3CA94h9
	3PVNNoLdvhSBk2t6LZQP6KHn1+Y/Ig9kK3lwT2hFjHWgZiqq3VK4SzqQBmD6A0e29acKD8NJDsAzp
	PBklhel75TRoOCf5VTzc00lXza1eWj1sW19Tjleo1fc/L5i9P5juDXyKQY9kHKExje/1wAmmZkrHj
	FdESUWBGwWEamk3EA3c0+gwV4EPoveBGXJo3r+051uO72Cz+2Bir5nMUbKQ2FfpEvF0r1gyVxRelx
	Ro4i1hRHlfJmHnjxqwmbD1SaYDgPeAH7HhcAneWE1IcOwP7nCEbEkp2xJxpa8O/6L3gNZJN11KFqb
	fYAj5NUQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tTfdp-00000005j4l-1npS;
	Fri, 03 Jan 2025 11:14:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3EDFC3003AF; Fri,  3 Jan 2025 12:14:57 +0100 (CET)
Date: Fri, 3 Jan 2025 12:14:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, agordeev@linux.ibm.com,
	kevin.brodsky@arm.com, tglx@linutronix.de, david@redhat.com,
	jannh@google.com, hughd@google.com, yuzhao@google.com,
	willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
	lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
	rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de,
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ryan.roberts@arm.com,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v3 15/17] mm: pgtable: remove tlb_remove_page_ptdesc()
Message-ID: <20250103111457.GC22934@noisy.programming.kicks-ass.net>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
 <b37435768345e0fcf7ea358f69b4a71767f0f530.1734945104.git.zhengqi.arch@bytedance.com>
 <Z2_EPmOTUHhcBegW@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2_EPmOTUHhcBegW@kernel.org>
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

On Sat, Dec 28, 2024 at 11:26:22AM +0200, Mike Rapoport wrote:
> On Mon, Dec 23, 2024 at 05:41:01PM +0800, Qi Zheng wrote:
> > Here we are explicitly dealing with struct page, and the following logic
> > semms strange:
> > 
> > tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));
> > 
> > tlb_remove_page_ptdesc
> > --> tlb_remove_page(tlb, ptdesc_page(pt));
> > 
> > So remove tlb_remove_page_ptdesc() and make callers call tlb_remove_page()
> > directly.
> 
> Please don't. The ptdesc wrappers are there as a part of reducing the size
> of struct page project [1]. 
> 
> For now struct ptdesc overlaps struct page, but the goal is to have them
> separate and always operate on struct ptdesc when working with page tables.

I don't see how the current idiotic code helps with that at all.

Fundamentally tlb_remove_page() is about removing *pages* as from a PTE,
there should not be a page-table anywhere near here *ever*.

Yes, some architectures use tlb_remove_page() for page-tables too, but
that is more or less an implementation detail that can be fixed.

So no, please keep these patches and kill this utterly idiotic code.

The only thing that should eventually care about page-tables is
tlb_remove_table(), and that takes a 'void *' and is expected to match
whatever __tlb_remove_table() does.

Flipping those to pgdesc, once its actually a thing, should be fairly
straight forward.


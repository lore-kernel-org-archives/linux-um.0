Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2094EC02198
	for <linux-um@archiver.kernel.org>; Sat,  8 Feb 2025 07:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dIUTnKlqptBhVh4FHbYoQplL5I5DQEoGc3UGevcbKYc=; b=pfzborRCxRm3TC8bXOEUq0zVEG
	wLGmUOuwqXhb2FcDxvl9MgIxo2mwmOvU7rWUy1yEMySLcEKdNckAoLqjlsuolHLEJlvyqgUYE3fD9
	Qzi2bmOEMwmeT87SpgUFrJSROUR0EA65Gsui8dFGfqO9hOJ8CNU5RwmkBSTrLSzR3mrdvIGlq2DDL
	ctnfrOPM8khwenEGkubnH62LwGh/sUajkhIXTV6jnEn1pcs6KA18+7L32aj2n/wJQ6UkzE/G9o76Z
	oIN3/n8A4CbCLZ2VoZO6oJlfoF1eC+BOYx7ZF3SEEC+hZ3APH40jp8cVMo0FArZrVgs6sWsrF/gxw
	UHj8R/fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgfB4-0000000COkc-3fbQ;
	Sat, 08 Feb 2025 07:22:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgfB4-0000000COkQ-06Zv;
	Sat, 08 Feb 2025 07:22:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dIUTnKlqptBhVh4FHbYoQplL5I5DQEoGc3UGevcbKYc=; b=Aq7ElquEb4PU458vaoh2BURefq
	0XGupeL+Ea5a1zbTs9mHs4isuqu4YDjsFkA4psNsUKV2IVtFGihdFzB3J4BlS1lx6yz2RbyKBPzLQ
	q5ug1G3UoBjgjdjZJ8pDtcbs+0u9J4m2W1Iyo6sUbB6qG+Wy0ywQUlWoMnSn8OmDM2h3cb8/NuufT
	bw6tV0V3F/oz2+8ixkTFko2xzqDuL2B9JR1G1aO/JW0eMEN6zXuMA2HAuspE0AAPA0iEyLWFwxwXY
	h9ZeDE/095r6pBz9fJ78gD+4ccGeRpRxZN3tn2b/eY9RppD2xLfz/F6OIiBJtZ6ZGQIYD7hJA/Ade
	hnrUUgrg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgfAx-00000009uJj-3bg7;
	Sat, 08 Feb 2025 07:22:51 +0000
Date: Sat, 8 Feb 2025 07:22:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, kevin.brodsky@arm.com,
	riel@surriel.com, vishal.moola@gmail.com, david@redhat.com,
	jannh@google.com, hughd@google.com, yuzhao@google.com,
	muchun.song@linux.dev, akpm@linux-foundation.org, will@kernel.org,
	aneesh.kumar@kernel.org, npiggin@gmail.com, arnd@arndb.de,
	dave.hansen@linux.intel.com, rppt@kernel.org,
	alexghiti@rivosinc.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org, x86@kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/5] remove tlb_remove_page_ptdesc()
Message-ID: <Z6cGS__8VRQdzAYA@casper.infradead.org>
References: <cover.1737637631.git.zhengqi.arch@bytedance.com>
 <20250124114759.GB15996@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124114759.GB15996@noisy.programming.kicks-ass.net>
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

On Fri, Jan 24, 2025 at 12:47:59PM +0100, Peter Zijlstra wrote:
> Right, so I don't think Sparc and Power care to use ptdesc, they're
> using non page page-tables.

i think you mean s390, not sparc.  all architectures _use_ ptdescs,
it's just that s390  and ppc use fractional ptdescs rather than an
entire ptdesc for an individual page table.

eventually we can change that, but we're looking out perhaps five years
before we can allocate a ptdesc for a sub-PAGE_SIZE quantity.


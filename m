Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B7DC77B73
	for <linux-um@archiver.kernel.org>; Sat, 27 May 2023 15:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kf7SOiBrPPBDpuJDfA2UEASe9LfTNoHGAI/84UJ8Utg=; b=CMUrJNh+SU2/ht
	nzNcu+j2W9dVuF4fn93k8y3pgj7cjp0P5tGL6no5R6v09Q8WIJcQZm0MHfXwyWXQd0pf02bXhcWi8
	EQQzpv5wxj8pnZ+IlZFyKw2rXIb7QDThCgbFZ8tbKMNMfvXBwwXYjnAH2AwXg7zF50la30/bw5L0+
	bRMLo3mFejeQSqPiyvc1JpC/fTCwrQKipd/sXWfT/mgTT7jXVf0kSL4st5jkdIxE7SA08jvk5Kda7
	h2h2Hn+vbINdBJ/nQskbv6zMA5NZfT7lyf8wwBEg/I3NyW9TfpzleEqUnkPwZARMuEkEl2xYrn0Mf
	lwLLqIkh3Uiy0+/enHdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2vY1-005vAV-0Q;
	Sat, 27 May 2023 15:09:37 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2vXy-005v9x-0E;
	Sat, 27 May 2023 15:09:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u50hcZSLxjXk+ZnHObIQ29gSZuYnejTLeMWOgyxvfyQ=; b=kvDbU0q2z5jUTh3d5nQNpnIto9
	5xrW767Q1PCPoDvq7cJx36GAZEG2mizda3DrQtiBOGyiytCq2OMTOEXq8TWh2LZ+xzaLqiKD9V9Eb
	EJX8E77j208rlnFcLKHX2rZvcHGssHh261tJ08qNlv2+zYnLCkftBGtSrrF/p39TJSIPJr0ITg4/l
	1g7Vh1u4qG6tN9I49LGc4DG6JUJ0KFWAYdrSkVV8XgiRrI/avMqTujLKkfiEnrTSZ/y+N3Nd9R9D8
	/OJnFeU9SGlsUclnIO5MUMB9v4WCZl1IYBNx4a3hMv/KnLwfYzmktawxgr1m6qrMuAbL8hw04B8Os
	8rYGwubA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1q2vXv-003tpc-6G; Sat, 27 May 2023 15:09:31 +0000
Date: Sat, 27 May 2023 16:09:31 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Vishal Moola <vishal.moola@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 05/34] mm: add utility functions for ptdesc
Message-ID: <ZHIdK+170XoK2jVe@casper.infradead.org>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-6-vishal.moola@gmail.com>
 <20230525090956.GX4967@kernel.org>
 <CAOzc2pxSH6GhBnAoSOjvYJk2VdMDFZi3H_1qGC5Cdyp3j4AzPQ@mail.gmail.com>
 <20230525202537.GA4967@kernel.org>
 <CAOzc2pxD21mxisy-M5b_SDUv0MYwNHqaVDJnJpARuDG_HjCbOg@mail.gmail.com>
 <20230527104144.GH4967@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230527104144.GH4967@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Sat, May 27, 2023 at 01:41:44PM +0300, Mike Rapoport wrote:
> Sorry if I wasn't clear, by "page table page" I meant the page (or memory
> for that matter) for actual page table rather than struct page describing
> that memory.
> 
> So what we allocate here is the actual memory for the page tables and not
> the memory for the metadata. That's why I think the name ptdesc_alloc is
> confusing.

But that's going to be the common pattern in the Glorious Future.
You allocate a folio and that includes both the folio memory descriptor
and the 2^n pages of memory described by that folio.  Similarly for all
the other memory descriptors.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

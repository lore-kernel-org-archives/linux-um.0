Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B57FC7EE45
	for <linux-um@archiver.kernel.org>; Sun, 28 May 2023 05:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lDaz6ONAIEX7DhtrQ9syyxnhb6s63EVJtgMdeRgr2h0=; b=NOAK9QhkYR0m3p
	6NpXrCGXwXEk83QZOqufcJls+OXbuB83Z/C8FClzqUXhT58ycTqQU6tLV6KLZ4Q2zquJL4MQS9IZC
	RW5lo7RtD0A714Oqte/WsGPgnuuyv9jbk19FQuaRum5Z8DOOHp42ELzs7IWMRHh2h29dZStUDM++T
	nQwzxVzfO2JPQ8RBw8Q7O5iomRu/+nJTq1C1mbsvV8YMvIQdTbL8tjzKaahrKnTLr+piDtUjW+L76
	sS9lsF5aOnRduheCNM/UuoRAaAXegLw+MKdOT14Cj9gEokipuzL6YUTBnftexiZ9oafIslws9mRjE
	97+t5V9BojM4wZcnu/JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q39GK-006yug-2t;
	Sun, 28 May 2023 05:48:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q39GH-006yti-1C;
	Sun, 28 May 2023 05:48:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A7A4B60B63;
	Sun, 28 May 2023 05:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2385C433D2;
	Sun, 28 May 2023 05:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685252892;
	bh=bkuMHroVl9TlOSFo6p59v17X6rAsvGxb3kzfT5vZogM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/fA88QDLAPfI5+3dlnjis0mHISdgNRk033rp1tEp/+Mnh4pdPF6GyqhT2d0f44ZM
	 O9W0HkIZYw4XGrrX1f3tUzE0jNE3oALs8Cn992s+EfmiHsu8hfXhu3DkQX9TcwN2oj
	 7E7N3KWaDItcFkwUQzuLHOiQy27MUurhgxG80g7TkNYefeCpTsWvx1dhgZiE8imgx7
	 3iInnTBsRh7R7es7uW5hUx43VvmKiGSLfYpxMoZFKFBm9CDY8XYAON1aC4gzYndzuk
	 JoH7BurJumWuV7HAw5lKspfn5I/oVTTKuKbhXpKROtOf7xIXSt3aAHLO5P0Ikkt3g7
	 bN8aIuRcKOvMA==
Date: Sun, 28 May 2023 08:47:45 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20230528054745.GI4967@kernel.org>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-6-vishal.moola@gmail.com>
 <20230525090956.GX4967@kernel.org>
 <CAOzc2pxSH6GhBnAoSOjvYJk2VdMDFZi3H_1qGC5Cdyp3j4AzPQ@mail.gmail.com>
 <20230525202537.GA4967@kernel.org>
 <CAOzc2pxD21mxisy-M5b_SDUv0MYwNHqaVDJnJpARuDG_HjCbOg@mail.gmail.com>
 <20230527104144.GH4967@kernel.org>
 <ZHIdK+170XoK2jVe@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZHIdK+170XoK2jVe@casper.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230527_224813_470616_937031EC 
X-CRM114-Status: GOOD (  17.05  )
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

On Sat, May 27, 2023 at 04:09:31PM +0100, Matthew Wilcox wrote:
> On Sat, May 27, 2023 at 01:41:44PM +0300, Mike Rapoport wrote:
> > Sorry if I wasn't clear, by "page table page" I meant the page (or memory
> > for that matter) for actual page table rather than struct page describing
> > that memory.
> > 
> > So what we allocate here is the actual memory for the page tables and not
> > the memory for the metadata. That's why I think the name ptdesc_alloc is
> > confusing.
> 
> But that's going to be the common pattern in the Glorious Future.
> You allocate a folio and that includes both the folio memory descriptor
> and the 2^n pages of memory described by that folio.  Similarly for all
> the other memory descriptors.

I'm not arguing with that, I'm not happy about the naming. IMO, the name
should reflect that we allocate memory for page tables rather than for the
descriptor of that memory, say pgtable_alloc() or page_table_alloc().

-- 
Sincerely yours,
Mike.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

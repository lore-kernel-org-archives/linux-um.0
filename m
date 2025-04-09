Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2295C36002
	for <linux-um@archiver.kernel.org>; Wed,  9 Apr 2025 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dp8sha2/kD65ph8oJFScW2gq/P9KqMUSHUkZ62xlQOM=; b=z5xaqy/bebjku4qZy+oz4YHSjH
	SSkjx3UzA1OwSQV6sdJikATZEwRfC84IIctEmomAlsUHwMiUMcCc76FKOC56JmMl2YwVNSpA1lEQ9
	mY1hOL8StU0rgCgI2fXykI3JY5lhtsIUJkc0sWYQfLfy7o9u6w9Z/6RaYz/FckfJvEcgeMAgcI3Rw
	gQmELm3OMoxcPkgBm54uBAhsoiFm6ZZGicGSlcADoAeIjJtM+sKY3xnm4ZRz7Dmwp6osNnPLRDH/H
	QjsEvkBOO2U88Pgn45xUkumvaeksKl+7B/jCK9a9jD6N/FPG+3o/NGIJ3i6MtzqjO5YY2VHVZrznL
	RW8a0+zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2ZFr-000000082yx-40sT;
	Wed, 09 Apr 2025 17:30:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2ZFq-000000082yG-0hZl
	for linux-um@lists.infradead.org;
	Wed, 09 Apr 2025 17:30:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B516040BFA;
	Wed,  9 Apr 2025 17:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB47C4CEE2;
	Wed,  9 Apr 2025 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744219825;
	bh=QtbLIEpxQbl34x26pYfR01C9eSJ1C0HEyNuuXfp4D3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKfCNkxvxks330i4tmhVvAYNvT/3zmyJBu8PNd1asnopvitwFiQNTaa7FPQ0e+7Qf
	 Pwrac4lcstH6fvQzID0xWRXscDYU+tfieiOAN2MxBQHx1WTR+jZEg1ArzOgabHEv5T
	 S1bRVZyPqooXP6yzHjbz5awfGo9zWc3sromP+Ku0/X0tTCvwLSEOxRwC+49IMkID24
	 cSnd5tZLhf27kNcXfchgs+cqK56ohz/so9FCQZJgcMpsVrIYEGmzwYJPBpzmYO6g6k
	 PIXJq/Dd7JQC67JhyIxg5uOKGXGZRjeOoYLyKmzdpnjneFmKgnC2qa00Pi0TIFvg4T
	 4s42utE4mNMyg==
Date: Wed, 9 Apr 2025 19:30:19 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Logan Gunthorpe <logang@deltatee.com>,
	Stephen Bates <sbates@raithlin.com>,
	Dinh Nguyen <dinguyen@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1] um: fix incompatible argument type in iounmap()
Message-ID: <Z_auq9XEUxMwKVoN@cassiopeiae>
References: <20250409061129.136788-1-fujita.tomonori@gmail.com>
 <CANiq72mbci8kxEx5jrq=HVc6WKuJqq8NCLzNsjH1wFcJNoHm+w@mail.gmail.com>
 <CAMuHMdWtgSjxeGYJVNzeWPOCd9nUWeKQnCtFQaROQ1o=r_-QwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWtgSjxeGYJVNzeWPOCd9nUWeKQnCtFQaROQ1o=r_-QwQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_103026_223082_D51BE552 
X-CRM114-Status: GOOD (  12.94  )
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

On Wed, Apr 09, 2025 at 07:07:56PM +0200, Geert Uytterhoeven wrote:
> Hi Miguel,
> 
> CC arnd
> 
> On Wed, 9 Apr 2025 at 16:48, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> > On Wed, Apr 9, 2025 at 8:16 AM FUJITA Tomonori
> > <fujita.tomonori@gmail.com> wrote:
> > >
> > > Align iounmap() signature with other architectures.
> >
> > Most indeed have `volatile`, but nios2 and m68k don't -- Cc'ing them
> > just in case.
> 
> Indeed. Apparently the volatile keyword has not always been there...
> Why does iounmap() need the volatile keyword?
> Why does pci_iounmap() not have the volatile keyword?

I think none of the functions within rust/helpers/io.c need volatile, since they
just defer to the corresponding C function / macro.

This probably has been a copy/paste mistake of the function signatures and
should be removed instead.

- Danilo


Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32149CF11C0
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 09:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WrWTn2Oq+Rhw9veaoLDKyeXM5cqwIWw+RVmdXKxlKas=; b=SeWs7wuRUMruxmxUAWKX2bvMM2
	gFQd677xTVrD3u++AyBaubL3FP8LeqdRwolCDIkfUhWeqTVKZEJgrhf7Po7eWoOSY6apCJXV8J5F3
	sqyRLIN+UhpKkiYFgoB/88Vn34UwI8NWoayWGqkAxWUM9SCdtEpHhw1qFiDs+KcmCEI9nU4tGiAPm
	+q5EYknWAwG8uCpnd9sgQri8bnavcGUv5JORwFv21r7mGb+v+h6SAsPU4deE1X2WBD7gyJ1pVroJV
	Y/4TgZPhnjQANA8FKIEWXwVJJvxC4W8b8d/GGrisR6N1U6O/Q3wuxeM/i3PeP6OlN1zyMd3HJ+ZS7
	YbHVDL5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sypkE-0000000CHfs-2EsS;
	Thu, 10 Oct 2024 09:46:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syogS-0000000C2g3-1D8d;
	Thu, 10 Oct 2024 08:38:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WrWTn2Oq+Rhw9veaoLDKyeXM5cqwIWw+RVmdXKxlKas=; b=VmWiu22ZQhlaf0BC5wdd0qK6Ai
	oRDhR42QUsZ0/psY/kx0U27E8QM2G4oMIZ6ZGTbbn+YISxOZsbe/TS6taAurRqvCJcvkDG+muGRRc
	PZb1CfR7YcsUf0m9Geqg2/9kdLm6YPZ5LqSZJlP1HBOhCgp7iGrGkB/hHu3THPf1BS2KNR/nrUYHW
	6OWJRCPiGQVURJYeZqGSh4/lBUayZgI3arz1Rw+xUHlDbBrJNA2mCXE8TLJZxBVStBaYNq9BaBVip
	8BwDiApR2wWI/m4p9aa42eWANyKL19xQiJFdaeRFiLvSg1fzpb7oRhs9WvWscSfoetumE9e+pDjM5
	T7JbSYtA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syogP-00000005G4X-0wgN;
	Thu, 10 Oct 2024 08:38:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1D670227A8E; Thu, 10 Oct 2024 10:37:57 +0200 (CEST)
Date: Thu, 10 Oct 2024 10:37:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] asm-generic: provide generic page_to_phys and
 phys_to_page implementations
Message-ID: <20241010083756.GA8685@lst.de>
References: <20241009114334.558004-1-hch@lst.de> <20241009114334.558004-2-hch@lst.de> <3e12014e-47a7-4cae-bcd1-87d301e1f80c@app.fastmail.com> <20241010070342.GB6674@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010070342.GB6674@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_093805_417030_82EAFA0C 
X-CRM114-Status: GOOD (  15.05  )
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

On Thu, Oct 10, 2024 at 09:03:42AM +0200, Christoph Hellwig wrote:
> > I think we should try to have a little fewer nested macros
> > to evaluate here, right now this ends up expanding
> > __pfn_to_phys, PFN_PHYS, PAGE_SHIFT, CONFIG_PAGE_SHIFT,
> > page_to_pfn and __page_to_pfn. While the behavior is fine,
> > modern gcc versions list all of those in an warning message
> > if someone passes the wrong arguments.
> > 
> > Changing the two macros above into inline functions
> > would help as well, but may cause other problems.
> 
> Doing them as inlines seems useful to me, let me throw that at
> the buildbot and see if anything explodes.

The inline version instantly blows up, so I'll try just open coding
the phys to/from pfn translation instead.



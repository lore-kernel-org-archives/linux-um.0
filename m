Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9D2CD98E2
	for <linux-um@archiver.kernel.org>; Wed, 17 Jun 2026 05:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8JiAftHNhrL08XMMBn9odXezSEJJMZl0ZgqlAPubGAw=; b=wR+RJZVs6UhohIHoDTtrwrij11
	6f/sORL0j+mMzqJenUmcxb6TV2A3+00JzpEHfDJ4Z3BecrCabOHxbUn8fsGf2VDTlAWaRjLUP2SIU
	x5UvxbtTsvp5+cLaMVBngTR7lTCp60Ie/cRwVsdgF6zzZeOskhgu1/IVrgUV7TUyyoqx84Ef4hYSY
	KjvFKI9QFkOskfjbeNFHY03W3PT73mdS4QpJJn0SetCfBnpfoXz5f/+oULQaoCAwDOfjg9Rlv3GzA
	ejwrEoDEG1S9CmsQ74CYc95Yfgf3CcViqfJAy/GUNWfkR+xBJP8r20joywNMBrzv38kJkJQ3hqUbX
	WKntEETA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZj5K-0000000GfOb-1SW2;
	Wed, 17 Jun 2026 05:45:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZj5H-0000000GfNV-1JEN
	for linux-um@lists.infradead.org;
	Wed, 17 Jun 2026 05:45:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 212A968C4E; Wed, 17 Jun 2026 07:44:56 +0200 (CEST)
Date: Wed, 17 Jun 2026 07:44:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Eric Biggers <ebiggers@kernel.org>,
	Richard Weinberger <richard@nod.at>, x86@kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-crypto@vger.kernel.org,
	David Laight <david.laight.linux@gmail.com>,
	linux-raid@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v3] lib/raid/xor: x86: Add AVX-512 optimized xor_gen()
Message-ID: <20260617054456.GA19125@lst.de>
References: <20260615190338.26581-1-ebiggers@kernel.org> <20260615201050.GB1764@quark> <255CAE3E-7FD3-4DC2-B3DE-46BE67EF22A8@alien8.de> <20260615212922.GA28589@quark> <20260615235318.GBajCQbuy9dBgKH8L_@fat_crate.local> <a832eee3-55ec-4cf4-907f-346ff98870ca@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a832eee3-55ec-4cf4-907f-346ff98870ca@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_224507_514585_28196980 
X-CRM114-Status: GOOD (  15.26  )
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

On Mon, Jun 15, 2026 at 05:29:58PM -0700, Dave Hansen wrote:
> On 6/15/26 16:53, Borislav Petkov wrote:
> > 
> >> In any case, I'd like these to go away:
> >>
> >>     $ git grep cpu_has_xfeatures | wc -l
> >>     31
> > Yeah, all in crypto. I can certainly see why.
> > 
> > @dhansen, any other thoughts?
> 
> If we can get rid of cpu_has_xfeatures(), I'm all for it. I'm not quite
> sure how the code would look so I'm reserving judgement until I see the
> patches. But it's worth a try.

I think the most important part is to be consistent.  Either use it
everywhere or not at all.


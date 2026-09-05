Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D70CC624D3
	for <linux-um@archiver.kernel.org>; Sat,  5 Sep 2026 11:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/x9C5bNxNWl9gURHOdoOE+fPK6NtP9yr0zoY9jWPaYs=; b=Jdo5lujKGXn/V8r//iQu8w6svp
	PJo/yPg1zRkCu188opoXyWUYh+vuylkzBmkL0Jasrl1tNDkyA6RMMmu3ZHSp+ar59kTLFogwJCHKu
	ZcitBs7Kn+DzbkC8G0U7UckE0P7k7xwH/Cyr6Z6uLIx+ui1sUgjB6MUzY6jCtKKJz/HSV4hwMWR0b
	43uIIMlgF+oszmSyGiuhHjAYCGRwtk3Lbg9Qs53i8jWWO1amScVycG7W7ANfRbiOJunaxDFlZg+8u
	5WLl7gMpZUXDZFhdsUpYbHNnpJ7amFJNu1/9tW1ToUxnv4yOu2+UCg16xS5J0R3m1ue1t7nfcZtL/
	nUmOWKnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2p1v-000000042mJ-3qbE;
	Sat, 05 Sep 2026 11:57:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2p1u-000000042lx-0FGd;
	Sat, 05 Sep 2026 11:57:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1846A43E0D;
	Sat,  5 Sep 2026 11:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6E51F00A3D;
	Sat,  5 Sep 2026 11:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788609472;
	bh=/x9C5bNxNWl9gURHOdoOE+fPK6NtP9yr0zoY9jWPaYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=zRIEiSllWjjqKMphf2jfhctZ0NlrXjWQRUU/AfOo6qNsCmAQeLVGIh/ycZGD0zEwP
	 YR0g0dr+06CYTBIYyLs2S+/F8a5umC2Yd6op83rlS2imO8nJSMDLYE9lBTSnuy7y2w
	 Aix1OCYdeLxdsFOw2HgXwlLM4M9AuUPhixPage20=
Date: Sat, 5 Sep 2026 13:56:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, achill@achill.org,
	akpm@linux-foundation.org, broonie@kernel.org, conor@kernel.org,
	f.fainelli@gmail.com, hargar@microsoft.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, linux@roeck-us.net,
	lkft-triage@lists.linaro.org, patches@kernelci.org,
	patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de,
	shuah@kernel.org, sr@sladewatkins.com, stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com, torvalds@linux-foundation.org,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
	linux-mm@kvack.org, Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 6.18 000/552] 6.18.50-rc1 review
Message-ID: <2026090538-irritant-tattoo-caa5@gregkh>
References: <20260904045747.813364717@linuxfoundation.org>
 <20260905114111.124795-1-ojeda@kernel.org>
 <apwBsCGpUG69KdGc@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apwBsCGpUG69KdGc@codewreck.org>
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

On Sat, Sep 05, 2026 at 08:49:04PM +0900, Dominique Martinet wrote:
> Miguel Ojeda wrote on Sat, Sep 05, 2026 at 01:41:11PM +0200:
> > I see the same arm32 build issue:
> > 
> >     mm/page_vma_mapped.c:110:11: error: call to undeclared function 'huge_ptep_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >       110 |                 ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
> >           |                         ^
> > 
> > In addition, in UML (x86_64) there is also nearby:
> > 
> >     mm/page_vma_mapped.c:110:9: error: assigning to 'pte_t' from incompatible type 'int'
> >       110 |                 ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
> >           |                       ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       111 |                                       pvmw->pte);
> >           |                                       ~~~~~~~~~~
> 
> See this 6.12 thread[1] for this build failure (I didn't check but
> assume it is the same, that missing commit only made it 7.3-rc1 but was
> also backported to the 7.2 tree, which also explains 7.2 didn't build
> fail)

I should have this fixed up now, will push out a -rc2 so that you all
can test it as I'm away from my big build box at the moment :(

thanks,

greg k-h


Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F66DC4345F
	for <linux-um@archiver.kernel.org>; Mon, 22 Apr 2024 20:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4JpIgXCB9jUQPkFUGAI31NP5EjtRLupEYrFT1gtqbDU=; b=PZFruLJ/d0Wx5s/E8XKYwt9wKI
	nVm8ATH+kAuLoimA0Qh3F4O+CDki0KpMD8P1ce5yCKycEQHAccKSgsH8Z+3/o6qKRA48pzgkOVxmM
	QECEd/Ww8FZ2ysTv+dOCb3l9DVBU9nWlSzYqQC4h5oFFOHWGTwJ6ISSL5EaFeIZEcv0SGsJ2lPFu3
	dXrmP9rHA/gECsJH1q/4gRatI+jue3U8iLgWKPnkGmhPNJJN6f9EBd51OfOnAIRxK2YxQDP7uzVHL
	XH/f6HPb1ZNsfpypNk1MCgNgO4VhfuZA+gUeAG2JKlL0V9i4LgO0RFktq+cnmUT3srIERPFAPsK56
	Bej5uT0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz00L-0000000Ewoc-1nOH;
	Mon, 22 Apr 2024 20:11:09 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz00G-0000000EwnR-3mEi
	for linux-um@lists.infradead.org;
	Mon, 22 Apr 2024 20:11:07 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8788D647A82A;
	Mon, 22 Apr 2024 22:11:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fvDzHBxSevvb; Mon, 22 Apr 2024 22:11:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 10A4F647A80D;
	Mon, 22 Apr 2024 22:11:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rBhDvx3ZBnCr; Mon, 22 Apr 2024 22:11:00 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id CEF3A609B3C4;
	Mon, 22 Apr 2024 22:11:00 +0200 (CEST)
Date: Mon, 22 Apr 2024 22:11:00 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, 
	kent overstreet <kent.overstreet@linux.dev>, 
	SeongJae Park <sj@kernel.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-mm <linux-mm@kvack.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <95819052.15033.1713816660761.JavaMail.zimbra@nod.at>
In-Reply-To: <20240326073750.726636-1-surenb@google.com>
References: <20240326073750.726636-1-surenb@google.com>
Subject: Re: [PATCH 1/1] arch/um: fix forward declaration for vmalloc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: arch/um: fix forward declaration for vmalloc
Thread-Index: VhMS7jUdUYDlNrao2e2bRQ6VhbmZJA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_131105_102332_97BB9B4C 
X-CRM114-Status: UNSURE (   8.62  )
X-CRM114-Notice: Please train this message.
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

----- Urspr=C3=BCngliche Mail -----
> Von: "Suren Baghdasaryan" <surenb@google.com>
> Betreff: [PATCH 1/1] arch/um: fix forward declaration for vmalloc

> Patch [1] replaced vmalloc() function with a new definition but it did
> not adjust the forward declaration used in UML architecture. Change it
> to act as before.
> Note that this prevents the vmalloc() allocations in __wrap_malloc()
> from being accounted. If accounting here is critical, we will have
> to remove this forward declaration and include vmalloc.h, however
> that would pull in more dependencies and would require introducing more
> architecture-specific headers, like asm/bug.h, asm/rwonce.h, etc.
> This is likely the reason why this forward declaration was introduced
> in the first place.
>=20
> [1] https://lore.kernel.org/all/20240321163705.3067592-31-surenb@google.c=
om/
>=20
> Fixes: 576477564ede ("mm: vmalloc: enable memory allocation profiling")

This commit id is not in Linus tree.
Do I miss something?

Thanks,
//richard


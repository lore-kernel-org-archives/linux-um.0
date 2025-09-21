Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C514CAC59A
	for <linux-um@archiver.kernel.org>; Sun, 21 Sep 2025 18:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BmXXBmIMus/AQCY9Y9SqLz9oz/WtDG9X5Ad9Nc7rYb8=; b=SecsWekVKv7y96u1OvhIlpYE9M
	YTP0axAMxbfIc1z6vw1WNknRTAilg1HErLOw0pzEhuwtlsuZZrgFtS2b0/nCsgE73asxkppk06V7P
	kmARgWuJSx9jHG59Wm89Fa0Jg1BO/AwLJYfe8o1b2S9MlveuPRIQnTWIQAjRW3/ebrzka4qbiFgsH
	y83K59/HGzraP0jGyupqMSwdGsMvJGtMJDqk9r6cXZpZS+4s+8QuA+REIpCChzIpyXONWFqLHMH8D
	qtK92OWCd4RgJupcChOYSe3B4/CFzUWfa3Lbww8kKDwPB2f6UnE5VjiRQGVvpz1jS+SxxSQUC0IcX
	GkKFaSPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0OnV-00000008157-2wh1;
	Sun, 21 Sep 2025 18:28:29 +0000
Received: from mta1.formilux.org ([51.159.59.229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0OnT-0000000814d-17eZ
	for linux-um@lists.infradead.org;
	Sun, 21 Sep 2025 18:28:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758479305; bh=BmXXBmIMus/AQCY9Y9SqLz9oz/WtDG9X5Ad9Nc7rYb8=;
	h=From:Message-ID:From;
	b=hQkV0yRzoqv4zMjnqrAkquGTdz73flgfRVhqdMoKN5WJiWdx8+nThwa63csLtvUFw
	 lIpjtAgL9k21WyyE1NQbEbCUsdbHFbf2/X8uAf3DPI/LjU8t5cOx9uq6R0doUN3DNs
	 hNlBOOEwknKN1g13iyeVmreviTf3selOvj/KFcBA=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id E556FC072E;
	Sun, 21 Sep 2025 20:28:24 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58LISOAl028613;
	Sun, 21 Sep 2025 20:28:24 +0200
Date: Sun, 21 Sep 2025 20:28:24 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <20250921182824.GA28610@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-4-benjamin@sipsolutions.net>
 <20250921075511.GA16684@1wt.eu>
 <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
 <54d0bf1d1010530941b595129312a56cfdea7c7b.camel@sipsolutions.net>
 <20250921171323.GC28238@1wt.eu>
 <70421908-6300-4df2-a54c-2dca03e8184e@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70421908-6300-4df2-a54c-2dca03e8184e@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_112828_066782_092B3EF2 
X-CRM114-Status: GOOD (  14.71  )
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

On Sun, Sep 21, 2025 at 08:26:35PM +0200, Thomas Weißschuh wrote:
> > I'm totally fine with saying that errno shouldn't be defined when building
> > without errno, but all functions must continue to be defined. perror() is
> > used to print an error message, it's a valid use case just as printf() and
> > should remain.
> > 
> > If we disable perror for this, then we must also disable usage of printf
> > for consistency (and I don't want this either).
> 
> Then let's also fix printf(). Benjamin, do you want to add this to your
> series? It should be consitent with the perror() fallback.

Yes that would be great given that the series focuses on fixing errno
usage.

Thanks,
Willy


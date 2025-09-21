Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565E4CAC59A
	for <linux-um@archiver.kernel.org>; Sun, 21 Sep 2025 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lZEJjfmDCtONRBvjrWY369UYPWUKbQc1p+sE1/zjMKo=; b=axXvcZIhzF8ExfPpvcpWfyUFUp
	KRUtsCjVcuNHkqvSM45gZ5VL2CdJHSuVUKH3x1Ef+4/OmTmrZSiyARSBrmeY3+OxD2WncFqajNe0X
	L/xDNVz36kZN5lvbJFbIoNPPd7+491Lg/ABSB/Hyl0yHJllkCD3HJ4XUVea8OnM4YXXM0eAicDKp4
	9SQUqElHPDJFKon34ZSd+9QfGmMaMmHUP9PH3o1BsylYQ6PMQiwrvwpr4u+hAwO0vNjoMe7uQG5C4
	qyIVwRaRWRSO4Y13URBXFT/FE6fQB+OG8/Fr+Ltqadaegrrat6Ybh4g2C0SODQ0IB1eIk32gXYhDX
	K5r58pCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Nmr-00000007vO0-2aX3;
	Sun, 21 Sep 2025 17:23:45 +0000
Received: from mta1.formilux.org ([51.159.59.229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Nmp-00000007vNW-1Mxq
	for linux-um@lists.infradead.org;
	Sun, 21 Sep 2025 17:23:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758475421; bh=lZEJjfmDCtONRBvjrWY369UYPWUKbQc1p+sE1/zjMKo=;
	h=From:Message-ID:From;
	b=DfqJ2TpK5SnUGMKt4nR9j+v5isCw9m35pmAQjU8IwXI8Evs90bMGVtsmuuA0VdnAm
	 bJgn8svrF66M7H4ORGbWjLS/msOjMQr5GnPMWU88x6v6v+DUQT0/Y7Z2PFwdKn6VLR
	 k1+/f16uMTUDw/ow8vC769mzqtjTxxMgQPxG6FvE=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 63D50C072E;
	Sun, 21 Sep 2025 19:23:41 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58LHNfJv028498;
	Sun, 21 Sep 2025 19:23:41 +0200
Date: Sun, 21 Sep 2025 19:23:41 +0200
From: Willy Tarreau <w@1wt.eu>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <20250921172341.GA28493@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-4-benjamin@sipsolutions.net>
 <20250921075511.GA16684@1wt.eu>
 <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
 <54d0bf1d1010530941b595129312a56cfdea7c7b.camel@sipsolutions.net>
 <20250921171323.GC28238@1wt.eu>
 <25a968dab7cc7e473ff85400a3a824b272121c79.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25a968dab7cc7e473ff85400a3a824b272121c79.camel@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_102343_644928_A4C3AFEE 
X-CRM114-Status: GOOD (  29.42  )
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

On Sun, Sep 21, 2025 at 07:16:50PM +0200, Benjamin Berg wrote:
> Hi,
> 
> On Sun, 2025-09-21 at 19:13 +0200, Willy Tarreau wrote:
> > On Sun, Sep 21, 2025 at 07:05:24PM +0200, Benjamin Berg wrote:
> > > This also ties to the question of the other mail. I prefer "errno" not
> > > to be available if it is not actually safe to use. UML does use threads
> > > in some places (and may use it extensively in the future). The current
> > > "errno" implementation is not threadsafe and I see neither an obvious
> > > way nor a need to change that. By setting NOLIBC_IGNORE_ERRNO any
> > > unsafe code will not compile and can be changed to use the sys_*
> > > functions to avoid errno.
> > 
> > That's the point I disagree with because here we're not using errno
> > more than printf() or dirent(). Why fix dirent() to build without errno
> > and break perror() ? Why not also break printf() then ? All of this must
> > be consistent. We're unbreaking some arbitrary functions and breaking
> > other arbitrary ones, that's not logical.
> > 
> > I'm totally fine with saying that errno shouldn't be defined when building
> > without errno, but all functions must continue to be defined. perror() is
> > used to print an error message, it's a valid use case just as printf() and
> > should remain.
> > 
> > If we disable perror for this, then we must also disable usage of printf
> > for consistency (and I don't want this either).
> 
> Right, fair enough. It is true that it does not really hurt to keep
> perror defined. I doubt there is much code out there, but I also don't
> really have a a strong argument against keeping perror. After all, it
> will "just" result in a bad error messages rather than undefined
> behaviour.

It shouldn't be a "bad" error message, just a limited one, which is the
main purpose of ignoring errno (i.e. where we're running we don't care
about error details since the user only needs to know that it failed, or
may even not know about it at all). perror *does* display the caller's
error message. I'm personally fine with seeing:

    "open(): unknown error"

for:

    if (open(path, O_RDONLY) < 0)
         perror("open()");

when building without errno.

Willy


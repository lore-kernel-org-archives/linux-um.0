Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64D3CAC5A7
	for <linux-um@archiver.kernel.org>; Sun, 21 Sep 2025 18:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aFjcvrJzYEyRmhP0OXL6VPMq6VWk8/T9qBfYnVdKMCw=; b=aVU+v9jmRMy68CyhlICEBySTKf
	a3H9qAU8oZWwlCi6lRFWnJ0dryIJqiJLvpP9es2SglDBMWJUXn//6LALW9jFuzQgPQVBv2XKk56/7
	M+QohW+EcNeL9z30+mEpFlMFL/ecnO8BVjTYFumvXIFrpAUK+6rxJZSoK3L4dJ/jacv6F9oWJUL6Q
	NuzN5eDTobZW3QWmcIdmuleHgkK9OPvko5XgDwDDAtKpWQFzMUSbQFexgyjE6NAEzrSwi4lM9NT4T
	yj1BP00v87Quc3nTvJi1N7mif/sqDv+uGO3p1ek4xtRsqIXq2FfU0X7syR05tYhlBPkmNw9mWP5Gj
	A2v6xFDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Oll-000000080ue-0R1d;
	Sun, 21 Sep 2025 18:26:41 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Oli-000000080u7-0tpx
	for linux-um@lists.infradead.org;
	Sun, 21 Sep 2025 18:26:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758479195;
	bh=QXSeu2WytESQlQTkLgYKHrixkheQCq3k1bXCbILkUkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SiLXF84uJ0cUlIgVvdme+rvvump7e0qFUDt78/BvjcglFbOXDjhwbf7kipCnvhAIg
	 VGQRuIzId+t3NRqqzGLa+NAnfmlI0tetXYU3BkaQ9zT7rj+SuTHj6sv5a9h6IZHdTN
	 7DmNwSVHcqA5pgtPDP0FiJtt95XJFiFofNN0isbQ=
Date: Sun, 21 Sep 2025 20:26:35 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, 
	linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <70421908-6300-4df2-a54c-2dca03e8184e@t-8ch.de>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-4-benjamin@sipsolutions.net>
 <20250921075511.GA16684@1wt.eu>
 <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
 <54d0bf1d1010530941b595129312a56cfdea7c7b.camel@sipsolutions.net>
 <20250921171323.GC28238@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921171323.GC28238@1wt.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_112638_413335_D5AEC283 
X-CRM114-Status: GOOD (  22.83  )
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

On 2025-09-21 19:13:23+0200, Willy Tarreau wrote:
> On Sun, Sep 21, 2025 at 07:05:24PM +0200, Benjamin Berg wrote:
> > This also ties to the question of the other mail. I prefer "errno" not
> > to be available if it is not actually safe to use. UML does use threads
> > in some places (and may use it extensively in the future). The current
> > "errno" implementation is not threadsafe and I see neither an obvious
> > way nor a need to change that. By setting NOLIBC_IGNORE_ERRNO any
> > unsafe code will not compile and can be changed to use the sys_*
> > functions to avoid errno.
> 
> That's the point I disagree with because here we're not using errno
> more than printf() or dirent(). Why fix dirent() to build without errno
> and break perror() ? Why not also break printf() then ? All of this must
> be consistent. We're unbreaking some arbitrary functions and breaking
> other arbitrary ones, that's not logical.

printf() is already broken. So by breaking perror() it would have been
consistent :-/.

> I'm totally fine with saying that errno shouldn't be defined when building
> without errno, but all functions must continue to be defined. perror() is
> used to print an error message, it's a valid use case just as printf() and
> should remain.
> 
> If we disable perror for this, then we must also disable usage of printf
> for consistency (and I don't want this either).

Then let's also fix printf(). Benjamin, do you want to add this to your
series? It should be consitent with the perror() fallback.


Thomas


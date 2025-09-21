Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D51CAC5A7
	for <linux-um@archiver.kernel.org>; Sun, 21 Sep 2025 17:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q8jo9RFMZL6CKiQ9yL4ItfVfRDdClH3IhBmKgJzcfrE=; b=byJrTO5ByFtYSS6VP/iNtY5ery
	F7ZesA6KqetGhpAz9aS0IdAKSxeAMOAC6cvr/8yAUT+Fj0MOw21zGC4HDGKU7rZSVUGGpIgl2KuQC
	GU4TjrD4wvKAn7LTF46l9wcOV9/jktvxlYhxMA88SbA5AJlVMAc1tHWrhGphNNaTkovQuFZo5EFX5
	kGyB3G248/BuSbk6vFylbGS4IauuKeyL3dsw8Cc1E5YJfddQt5bT0xkyMaHQ5ey18BRXJNB4oVRL+
	0pjTfjWSl1Ut9EE5XG+mhKEEqSG3JfFbihf+n6CUT/cmMiwQQm3Mf1LSYyNbcb5yhRdq1IaTuRh6z
	7wMhbf8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Nct-00000007uFr-2GqS;
	Sun, 21 Sep 2025 17:13:27 +0000
Received: from mta1.formilux.org ([51.159.59.229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Ncr-00000007uF3-1z23
	for linux-um@lists.infradead.org;
	Sun, 21 Sep 2025 17:13:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758474803; bh=Q8jo9RFMZL6CKiQ9yL4ItfVfRDdClH3IhBmKgJzcfrE=;
	h=From:Message-ID:From;
	b=IJnEBDMXfFAgLA2RWfQfp2k0SZxRN6gJY07Q3u86wORv+COMYnao5OGTPi7Xqe/BY
	 NhWOEwiJuA2qRvxPFLxyvMEPnEebkTsmvUHyajSKIGWeAATcmWq6F3fgEk25illfb/
	 J872Nn3CTCrxzi/LQFMryu9TZnk/+vBom6kBEnYY=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 623EBC072E;
	Sun, 21 Sep 2025 19:13:23 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58LHDNfT028425;
	Sun, 21 Sep 2025 19:13:23 +0200
Date: Sun, 21 Sep 2025 19:13:23 +0200
From: Willy Tarreau <w@1wt.eu>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <20250921171323.GC28238@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-4-benjamin@sipsolutions.net>
 <20250921075511.GA16684@1wt.eu>
 <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
 <54d0bf1d1010530941b595129312a56cfdea7c7b.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54d0bf1d1010530941b595129312a56cfdea7c7b.camel@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_101325_687260_1B659C94 
X-CRM114-Status: GOOD (  15.78  )
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

On Sun, Sep 21, 2025 at 07:05:24PM +0200, Benjamin Berg wrote:
> This also ties to the question of the other mail. I prefer "errno" not
> to be available if it is not actually safe to use. UML does use threads
> in some places (and may use it extensively in the future). The current
> "errno" implementation is not threadsafe and I see neither an obvious
> way nor a need to change that. By setting NOLIBC_IGNORE_ERRNO any
> unsafe code will not compile and can be changed to use the sys_*
> functions to avoid errno.

That's the point I disagree with because here we're not using errno
more than printf() or dirent(). Why fix dirent() to build without errno
and break perror() ? Why not also break printf() then ? All of this must
be consistent. We're unbreaking some arbitrary functions and breaking
other arbitrary ones, that's not logical.

I'm totally fine with saying that errno shouldn't be defined when building
without errno, but all functions must continue to be defined. perror() is
used to print an error message, it's a valid use case just as printf() and
should remain.

If we disable perror for this, then we must also disable usage of printf
for consistency (and I don't want this either).

Willy


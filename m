Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB15CAC597
	for <linux-um@archiver.kernel.org>; Sat, 20 Sep 2025 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/3/AwUUMsTp7d78G28Otxkq3O+K4o5t6A/3hUbFRuV8=; b=hEMFov/5pHiSzvcpwITLB2xa+k
	tc5YGPw1u8ZgdoL2bYO3CxH320azQ0/B/2r4dT1GtOqqpgxJQ2NfsJuKPh5Fk3dOsK/kU2TT5mM58
	nsGCSubnu6wuqG7pWzEdEEHUJNEfRipD3sT7BUT0hbM2qPD2W8Yf4eOQCEwquf8zMx45VgiQh+gON
	m9mm5Gl1pMDg0kfOe9nJjnVoPgQerswu6IOw+k58e3sS8smVeOgZ3jEV/4v+ocdDqm7p0kl90Y7Q7
	PbX8UYY5TmJLsZ8ee02jBMVD3bj+1mcozMMpkuvueyhrvsGoJIDLSWalKOTyQKPnxIWnyRzaLNpzn
	16FgG0hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uztvI-000000057kU-32np;
	Sat, 20 Sep 2025 09:30:28 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uztvG-000000057k4-1prY
	for linux-um@lists.infradead.org;
	Sat, 20 Sep 2025 09:30:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758360623;
	bh=GLnIwTogMt9dz1kwCxTGJ3RmHIApQIH7+X2LKzdBoFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNMArAehsQkJD49jzRd4dSNYcBLiTNkKtK3kTL/PixpbKul1oD8tMB2gZjYtMoZYi
	 FAQxOha3OSw2WSN6O2R386SbcJlJ5coR2yFAFfTbLyxGvl5RYVdBqq6IAhUiA6HvjP
	 Y5m0rDPtT8HrHlXUx2WKHEUM3Zjf1E8qGNsdblZI=
Date: Sat, 20 Sep 2025 11:30:18 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 00/11] Start porting UML to nolibc
Message-ID: <07b0f2d0-5dfe-49b0-9f86-28f90512dd4e@t-8ch.de>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250920_023026_637229_D3A75137 
X-CRM114-Status: GOOD (  17.90  )
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

On 2025-09-19 17:34:09+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> This patchset is an attempt to start a nolibc port of UML. The goal is
> to port UML to use nolibc in smaller chunks to make the switch more
> manageable.
> 
> There are three parts to this patchset:
>  * Two patches to use tools/include headers instead of kernel headers
>    for userspace files.
>  * A few nolibc fixes and a new NOLIBC_NO_STARTCODE compile flag for it
>  * Finally nolibc build support for UML and switching two files while
>    adding the appropriate support in nolibc itself.
> 
> v1 of this patchset was
>   https://lore.kernel.org/all/20250915071115.1429196-1-benjamin@sipsolutions.net/
> 
> Changes in v2:
> - add sys/uio.h and sys/ptrace.h to nolibc
> - Use NOLIBC_NO_RUNTIME to disable nolibc startup code
> - Fix out-of-tree build
> - various small improvements and cleanups
> 
> Should the nolibc changes be merged separately or could everything go
> through the same branch?

Both work for me. But only for the next cycle.

> Also, what about tools/include/linux/compiler.h? It seems that was added
> for the tracing code, but it is not clear to me who might ACK that fix.

Some files in tools/ are orphaned. In the past I got some reviews, included
the change in my tree and mentioned it to Linus in my regular pull request.

(...)


Thomas


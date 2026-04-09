Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2A1F364AD
	for <linux-um@archiver.kernel.org>; Thu,  9 Apr 2026 18:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PozlKi1c5KdbUL7OKHc6/Z1RM9T1oOwBLv4Kc92LWdk=; b=cPt6nU36YiP2AF2WFZwRTM9t+Q
	nEBUnJwI9pZm45X85m6FSELZWKHayopqqjSwledmj3iDo6u0BpVNU6T9skNDCKLS/B/P+2W2Sa0hQ
	OFrG8ORDQMrlufd6fUxiORn0OO47Id+w2mHFAmvStQtmHS7ggNtkniLYjaHIKBjh6+m6EEZTyrCHV
	GmkIYusDzqiyiYbqvK5Nw0tiWTvAk4G+QbZwfnOfzOkleP8nPePOmP9tL61qeVY77JhdWy/09CjdB
	yRKp6FXFjYFFbd9cAgjkYkXIqghL9k2Wfkx7tDAVNprTAyhs/6AossBn5JPlTjZ4MrLCj/MPqUqdQ
	wiLqjblw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAu5G-0000000B5mI-2AQu;
	Thu, 09 Apr 2026 18:26:30 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAu5D-0000000B5lS-41NF
	for linux-um@lists.infradead.org;
	Thu, 09 Apr 2026 18:26:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5CDF5409EE;
	Thu,  9 Apr 2026 18:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFA5C4CEF7;
	Thu,  9 Apr 2026 18:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775759186;
	bh=A9bQ1ncAabtfS0R/KDC5j3Rw8ryqwWgMdQsEDLefxIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZQ2+rBxvWmuIce0HjdzyCT5dl8IF6I19g+TmFN0ObVDlIwajMODXNLhWJoZVVbWo
	 v4H5Qcj0hK6FekJowIPUhOPY3DxwycXhV6o/1JApGpJZ6LU3sCjML6D7p0Kk1LbgS8
	 Owia3/628zTQCzHFkzbW8dqrwj+bHeoVngT0jcJ47hY+50U8ejSZMw9CaLALPP7PLz
	 dYFVmY35XVtYB3Y+lxcLhV2d9xG+Bc7CX3oCRRGzIAYbwXnoh8faQ8ehrXTDAdtwm9
	 BJmEK5biDnMt6J0tAcswILZnIcM5Yzam/P+ul95i+Yw9YZAimdJ+Qrhk6teyQjH+V7
	 bk30wz/a8909Q==
Date: Thu, 9 Apr 2026 11:26:20 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <kees@kernel.org>, Richard Weinberger <richard@nod.at>,
	kernel test robot <lkp@intel.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] gcov: Disable GCOV_PROFILE_ALL on 32-bit UML with
 Clang 20/21
Message-ID: <20260409182620.GA2550473@ax162>
References: <20260409052038.make.995-kees@kernel.org>
 <5cf1d83227fd5a6af784f0b11fcdebf9a0bc9f94.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf1d83227fd5a6af784f0b11fcdebf9a0bc9f94.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_112628_042625_D22DD692 
X-CRM114-Status: GOOD (  14.88  )
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

On Thu, Apr 09, 2026 at 04:47:32PM +0200, Johannes Berg wrote:
> Hi,
> 
> Maybe the subject should say "um:" instead of "gcov:" now?
> 
> (I'm assuming you want us to apply it to uml tree.)
> 
> > Prevent the bad combination by disabling UML's ARCH_HAS_GCOV_PROFILE_ALL
> > on 32-bit when using Clang 20.x or 21.x.
> 
> You say 20.x or 21.x,
> 
> > +	# Clang 20 & 21 miscompute __builtin_object_size() under -fprofile-arcs
> > +	# on 32-bit, causing spurious compile-time errors in check_copy_size().
> > +	select ARCH_HAS_GCOV_PROFILE_ALL if !(!64BIT && CLANG_VERSION >= 200000 && CLANG_VERSION < 220100)
> 
> and I see that 22.0 doesn't even exist, and maybe that's a general
> pattern, but it still looks confusing? Wouldn't it be better simpler to
> say < 220000? At least to me that more obviously is "up to 21.x". After
> all, 20.0 also didn't exist, and you did >=200000, not >200000 or
> >=200100?

22.0.0 means a development cycle version of LLVM 22, whereas 22.1.0 is
the released version (mirroring how GCC versioning works). The bug was
not fixed in the 22 development cycle, it was fixed at the beginning of
the 23 development cycle then backported to 22.1.0 before the final
release, so I think the bounds is correct as it is. We assume all
versions of 20 and 21 and the development version of 22 have the bug.

Cheers,
Nathan


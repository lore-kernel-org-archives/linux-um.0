Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3560CC369C2
	for <linux-um@archiver.kernel.org>; Sat,  3 May 2025 17:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wfYb0t5S/K+8zs2NzTzfRtfSNYBnzowq+ik5aTh7Vsg=; b=kyeOHBTxfyRjwQMddBQXdGAjNG
	ODhnSgNfUFkfCBHykl63DGqGzgfxtYMGpfDr13AHAi16tZI/e/n/WDNg79HZ82DnDMzCB4OufDbwH
	RomxSpJzVStTxCb44rRUmm3tjaWTwj7vEr/m+EHBGtUajEUxffatZvpCw5w4yiC9r7WMQCV9YSPnb
	VgnQQI5xmK64Ky+3aFVrYr6WK6kzLI7wGy2oGa2ddSotTg7IkaTolnP9DueJpjtB6YIyfg/ls/GR2
	8otD/onE6immV4wdcj6KtLGC7PNZX0pnw+LU0DUzdlXxidl/uDsFO7lxT5vFQyYbx2qXazCie0JBi
	XIdficsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBGnd-00000004JXD-0tNQ;
	Sat, 03 May 2025 17:37:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBGnc-00000004JX3-023x
	for linux-um@lists.infradead.org;
	Sat, 03 May 2025 17:37:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 61B5C6111F;
	Sat,  3 May 2025 17:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F681C4CEE3;
	Sat,  3 May 2025 17:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746293834;
	bh=y7WfEK3a16DmPLp50jYGnCuAQ573Pt+N9OZeOpG6A8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=roGI5vk0DiDOfwmApphUuD1Ln8gVL17ZzOLJgmneAflP1O6DXKh1gHZRbQm1/kQrY
	 IVSgRhSrPGEKdpI+v6gSZuWlDOIP7DRFepBw8Ddr2aTTrk3sezWp/fMpeGYqQtU0D4
	 vq9TynoZ7BF7Ij0YesGKG5Q2sUHjwhnjmzLbcVuRYMrgJg9y16ZuEwKX7dBl/e9aRE
	 SwqRyVwYjCfrR2JmeFvO0vw49V2HyWGnc3sxp6tBYeQ08YJE0PqWgF9ji1MUFF9tgA
	 l3vMzVN2pNCLUhLLraTFCEjiOf3tDhNYDIbLfrWv+KoApkd+mPw9b3PfLUWNYza6DC
	 FMmzHGLdILrhg==
Date: Sat, 3 May 2025 10:37:11 -0700
From: Kees Cook <kees@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Justin Stitt <justinstitt@google.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Detect changed compiler dependencies for full
 rebuild
Message-ID: <202505031028.7022F10061@keescook>
References: <20250502224512.it.706-kees@kernel.org>
 <CAK7LNAQCZMmAGfPTr1kgp5cNSdnLWMU5kC_duU0WzWnwZrqt2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQCZMmAGfPTr1kgp5cNSdnLWMU5kC_duU0WzWnwZrqt2A@mail.gmail.com>
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

On Sat, May 03, 2025 at 06:39:28PM +0900, Masahiro Yamada wrote:
> On Sat, May 3, 2025 at 7:54 AM Kees Cook <kees@kernel.org> wrote:
> >
> >  v2:
> >   - switch from -include to -I with a -D gated include compiler-version.h
> >  v1: https://lore.kernel.org/lkml/20250501193839.work.525-kees@kernel.org/
> 
> 
> What do you think of my patch as a prerequisite?
> https://lore.kernel.org/linux-kbuild/20250503084145.1994176-1-masahiroy@kernel.org/T/#u
> Perhaps, can you implement this series more simply?
> 
> My idea is to touch a single include/generated/global-rebuild.h
> rather than multiple files such as gcc-plugins-deps.h, integer-wrap.h, etc.
> 
> When the file is touched, the entire kernel source tree will be rebuilt.
> This may rebuild more than needed (e.g. vdso) but I do not think
> it is a big deal.

This is roughly where I started when trying to implement this, but I
didn't like the ergonomics of needing to scatter "touch" calls all over,
which was especially difficult for targets that shared a build rule but
may not all need to trigger a global rebuild. But what ultimately pushed
me away from it was when I needed to notice if a non-built source file
changed (the Clang .scl file), and I saw that I need to be dependency
driven rather than target driven. (Though perhaps there is a way to
address this with your global-rebuild.h?)

As far as doing a full rebuild, if it had been available last week, I
probably would have used it, but now given the work that Nicolas, you,
and I have put into this, we have a viable way (I think) to make this
more specific. It does end up being a waste of time/resources to rebuild
stuff that doesn't need to be (efi-stub, vdso, boot code, etc), and that
does add up when I'm iterating on something that keeps triggering a full
rebuild. We already have to do the argument filtering for targets that
don't want randstruct, etc, so why not capitalize on that and make the
rebuild avoid those files too?

So, I think the global-rebuild.h idea is a good one (though I think it
should maybe be included in compiler-version.h just to avoid yet more
compiler command line arguments), I'd really like to try to have the
specific dependency-based way to get it done.

I'll send a v3, and see what you think?

-Kees

-- 
Kees Cook


Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E876BC3ABC0
	for <linux-um@archiver.kernel.org>; Thu,  8 May 2025 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vMN+iMGvFhpjV0lE7tYmN8eikr2AxmfQ/1RJzjUb7HA=; b=Qc2HK36RIg+W+EeLrb2jWD+gZs
	oopDXw7ivk1weYGmbctydSQvcUSYkzP0mHU35zt/Kpfrs61yRGdG7njTmsg4fFy3qlY4jJ3UuXe13
	pBd+og2IgQ5hfW/kUcrq7Bu1w1Mm9oeSkNzAYIibsLJqcIcnKgZRdnm4GSLWoAsz+X5oQ6Wf1o5YR
	GSiY+LSKw0CidHNMJ+9FmiWzVUFsZv2g8pyK3TqNQoBAyS3kBW3dh1gW/twmRLsRQXjBR837ekdSf
	sPOIKbHcvDFZ/tfz9jzVMR4LAsidKpKNAfd08l/0eo3iQKgXcx3PQxUzU7Q+l+ZaWslihXT/64kaR
	ht2uC3JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD4w3-00000001NZY-25t5;
	Thu, 08 May 2025 17:21:27 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD4Xw-00000001KSp-35Ls
	for linux-um@lists.infradead.org;
	Thu, 08 May 2025 16:56:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CEE79A4DF8D;
	Thu,  8 May 2025 16:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EFAC4CEE7;
	Thu,  8 May 2025 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746723391;
	bh=kCC/RC1xjDARRLa7SAcxuLQRIDrsjd8nQJwVZfH9pX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ChcionI4QpBcr/AH77gTgk1kCLQT1l9LMAfmwMVaNf+bDRP6Op1BYMt0tvnyZCJsn
	 xV61+2za141yy7hFSI4I+u5IMD2WXBmr47eZ0zVO2m47go2gDtBsreS+sJ0dc9HUAf
	 3+TOt49NRBZVC6JUNMUCRALtckKCB/Kx41RnBtPXefVPpjLz7BQutjJpXiJZ8FwJMA
	 Lxy8sJkRr67dZJjkZI0gv1XsigXkr8albkRm3IKimy2/+lxM0dKKsujroALWXRTzTe
	 zEIyalnW83GX4AWc/VuCmGqORHqrQDoQZHE+sddRHD9gkjQT7JuZzPmP5jR/TwgXrP
	 8h7EKAY1c0FVA==
Date: Thu, 8 May 2025 09:56:28 -0700
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
Message-ID: <202505080953.789B3381@keescook>
References: <20250502224512.it.706-kees@kernel.org>
 <CAK7LNAQCZMmAGfPTr1kgp5cNSdnLWMU5kC_duU0WzWnwZrqt2A@mail.gmail.com>
 <202505031028.7022F10061@keescook>
 <CAK7LNAQehmFgB3kJtrkVhUKM1NEXGQrfJ3v3piToh7YV7-3ccw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQehmFgB3kJtrkVhUKM1NEXGQrfJ3v3piToh7YV7-3ccw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_095632_910919_4E529CF7 
X-CRM114-Status: GOOD (  37.82  )
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

On Fri, May 09, 2025 at 01:44:09AM +0900, Masahiro Yamada wrote:
> On Sun, May 4, 2025 at 2:37 AM Kees Cook <kees@kernel.org> wrote:
> >
> > On Sat, May 03, 2025 at 06:39:28PM +0900, Masahiro Yamada wrote:
> > > On Sat, May 3, 2025 at 7:54 AM Kees Cook <kees@kernel.org> wrote:
> > > >
> > > >  v2:
> > > >   - switch from -include to -I with a -D gated include compiler-version.h
> > > >  v1: https://lore.kernel.org/lkml/20250501193839.work.525-kees@kernel.org/
> > >
> > >
> > > What do you think of my patch as a prerequisite?
> > > https://lore.kernel.org/linux-kbuild/20250503084145.1994176-1-masahiroy@kernel.org/T/#u
> > > Perhaps, can you implement this series more simply?
> > >
> > > My idea is to touch a single include/generated/global-rebuild.h
> > > rather than multiple files such as gcc-plugins-deps.h, integer-wrap.h, etc.
> > >
> > > When the file is touched, the entire kernel source tree will be rebuilt.
> > > This may rebuild more than needed (e.g. vdso) but I do not think
> > > it is a big deal.
> >
> > This is roughly where I started when trying to implement this, but I
> > didn't like the ergonomics of needing to scatter "touch" calls all over,
> > which was especially difficult for targets that shared a build rule but
> > may not all need to trigger a global rebuild. But what ultimately pushed
> > me away from it was when I needed to notice if a non-built source file
> > changed (the Clang .scl file), and I saw that I need to be dependency
> > driven rather than target driven. (Though perhaps there is a way to
> > address this with your global-rebuild.h?)
> >
> > As far as doing a full rebuild, if it had been available last week, I
> > probably would have used it, but now given the work that Nicolas, you,
> > and I have put into this, we have a viable way (I think) to make this
> > more specific. It does end up being a waste of time/resources to rebuild
> > stuff that doesn't need to be (efi-stub, vdso, boot code, etc), and that
> > does add up when I'm iterating on something that keeps triggering a full
> > rebuild. We already have to do the argument filtering for targets that
> > don't want randstruct, etc, so why not capitalize on that and make the
> > rebuild avoid those files too?
> 
> 
> efi-stub, vdso are very small.
> 
> Unless this turns out to be painful, I prefer
> a simpler implementation.
> 
> You will see how .scl file is handled.
> 
> See the below code:
> 
> 
> diff --git a/Kbuild b/Kbuild
> index f327ca86990c..85747239314c 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -67,10 +67,20 @@ targets += $(atomic-checks)
>  $(atomic-checks): $(obj)/.checked-%: include/linux/atomic/%  FORCE
>         $(call if_changed,check_sha1)
> 
> +rebuild-$(CONFIG_GCC_PLUGINS)          += $(addprefix
> scripts/gcc-plugins/, $(GCC_PLUGIN))
> +rebuild-$(CONFIG_RANDSTRUCT)           += include/generated/randstruct_hash.h

These are in $(objtree)

> +rebuild-$(CONFIG_UBSAN_INTEGER_WRAP)   += scripts/integer-wrap-ignore.scl

This is in $(srctree)

> +
> +quiet_cmd_touch = TOUCH   $@
> +      cmd_touch = touch $@
> +
> +include/generated/global-rebuild.h: $(rebuild-y)
> +       $(call cmd,touch)

Is this rule going to find the right versions of the dependencies?

> --- a/Makefile
> +++ b/Makefile
> @@ -558,7 +558,8 @@ USERINCLUDE    := \
>                 -I$(srctree)/include/uapi \
>                 -I$(objtree)/include/generated/uapi \
>                  -include $(srctree)/include/linux/compiler-version.h \
> -                -include $(srctree)/include/linux/kconfig.h
> +                -include $(srctree)/include/linux/kconfig.h \
> +                -include $(objtree)/include/generated/global-rebuild.h

Instead of adding a new file, why not just touch compiler-version.h?

But whatever the case, sure, I can live with this. :)

-Kees

-- 
Kees Cook


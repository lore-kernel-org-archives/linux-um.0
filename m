Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B69C3ABBE
	for <linux-um@archiver.kernel.org>; Thu,  8 May 2025 23:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RJffRbbgB2mmArflowq3rHRTwEaLVFDXijNwI2PHBf4=; b=pXIX11w4B/5yTGTpO3FdK2T/Ge
	b3P4DSS7s4DlEMgV8Yl2msQOakji7eXkSm6h/+PqkN2TiswDwHE68YS5zdOXvA/xh/+7yc6ARLg/v
	TzJitLeFNYpWHRVsh79EfkcCfKW1o3Rrussz9udkOhJZ9Q0FzV7GrAgSkMGH0CKsEW7lbCzB2VdnO
	qZGpqyt/WhQNz2RWFc3ZCg99e3U52x686nGCiYTETGFoZ0N9RChK/vJdwCBRNYH7/Eh2jCTgvhMBX
	lsaMMH84ssrfuuR2as1NWDckpYZBMCcpg4g4OsdHSSpDsvodwHXbiJd30WUZa4BCVDwYSMmYGPR9D
	357JXhvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDB9g-0000000230N-1LBG;
	Thu, 08 May 2025 23:59:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDB9d-000000022zu-0avb
	for linux-um@lists.infradead.org;
	Thu, 08 May 2025 23:59:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B94475C655A;
	Thu,  8 May 2025 23:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06FFC4CEE7;
	Thu,  8 May 2025 23:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746748791;
	bh=avRAmG5hREbE1cMABo+KJNWPixB85ErvDhA3zrJGPAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UjxuE3Mae7RW76OmV7hsizwR7noAPvXp/aY05LbcZfIDqaTATfPrqGelVe3tS97tQ
	 HfYL9lH+fStr/u7b74eaf15E43kif+3e8J2QK9rmBAZtEhJgflxt03o8q1yTSF0Tdo
	 o43eNewtkVzcbraIZ04MFoPWFxfDz+R7QUbsHkzTlbm8Vwt1zTevLa7+4DNnlk/7Yj
	 qTzM7J0DD83C7RJg3daSBVj1nQxQ5OBpxRbVIeU3Ssx9cnJj+VPXuZax4u4V2gKe74
	 8N+3Zs4ZHOl+b+CcK3oMtIO0m/H83naESh0y6brHgfGtPMWuVf/kDhLVuwukrA8CyL
	 l4vubc2RB+a4Q==
Date: Thu, 8 May 2025 16:59:48 -0700
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
Message-ID: <202505081651.EAF0C6B@keescook>
References: <20250502224512.it.706-kees@kernel.org>
 <CAK7LNAQCZMmAGfPTr1kgp5cNSdnLWMU5kC_duU0WzWnwZrqt2A@mail.gmail.com>
 <202505031028.7022F10061@keescook>
 <CAK7LNAQehmFgB3kJtrkVhUKM1NEXGQrfJ3v3piToh7YV7-3ccw@mail.gmail.com>
 <202505080953.789B3381@keescook>
 <CAK7LNAQpGXmWNhoE9wLoP01dn2o7KjhedoqHXm474CoCgwHp2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQpGXmWNhoE9wLoP01dn2o7KjhedoqHXm474CoCgwHp2Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_165953_269411_61E9A290 
X-CRM114-Status: GOOD (  43.21  )
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

On Fri, May 09, 2025 at 08:13:18AM +0900, Masahiro Yamada wrote:
> On Fri, May 9, 2025 at 1:56 AM Kees Cook <kees@kernel.org> wrote:
> >
> > On Fri, May 09, 2025 at 01:44:09AM +0900, Masahiro Yamada wrote:
> > > On Sun, May 4, 2025 at 2:37 AM Kees Cook <kees@kernel.org> wrote:
> > > >
> > > > On Sat, May 03, 2025 at 06:39:28PM +0900, Masahiro Yamada wrote:
> > > > > On Sat, May 3, 2025 at 7:54 AM Kees Cook <kees@kernel.org> wrote:
> > > > > >
> > > > > >  v2:
> > > > > >   - switch from -include to -I with a -D gated include compiler-version.h
> > > > > >  v1: https://lore.kernel.org/lkml/20250501193839.work.525-kees@kernel.org/
> > > > >
> > > > >
> > > > > What do you think of my patch as a prerequisite?
> > > > > https://lore.kernel.org/linux-kbuild/20250503084145.1994176-1-masahiroy@kernel.org/T/#u
> > > > > Perhaps, can you implement this series more simply?
> > > > >
> > > > > My idea is to touch a single include/generated/global-rebuild.h
> > > > > rather than multiple files such as gcc-plugins-deps.h, integer-wrap.h, etc.
> > > > >
> > > > > When the file is touched, the entire kernel source tree will be rebuilt.
> > > > > This may rebuild more than needed (e.g. vdso) but I do not think
> > > > > it is a big deal.
> > > >
> > > > This is roughly where I started when trying to implement this, but I
> > > > didn't like the ergonomics of needing to scatter "touch" calls all over,
> > > > which was especially difficult for targets that shared a build rule but
> > > > may not all need to trigger a global rebuild. But what ultimately pushed
> > > > me away from it was when I needed to notice if a non-built source file
> > > > changed (the Clang .scl file), and I saw that I need to be dependency
> > > > driven rather than target driven. (Though perhaps there is a way to
> > > > address this with your global-rebuild.h?)
> > > >
> > > > As far as doing a full rebuild, if it had been available last week, I
> > > > probably would have used it, but now given the work that Nicolas, you,
> > > > and I have put into this, we have a viable way (I think) to make this
> > > > more specific. It does end up being a waste of time/resources to rebuild
> > > > stuff that doesn't need to be (efi-stub, vdso, boot code, etc), and that
> > > > does add up when I'm iterating on something that keeps triggering a full
> > > > rebuild. We already have to do the argument filtering for targets that
> > > > don't want randstruct, etc, so why not capitalize on that and make the
> > > > rebuild avoid those files too?
> > >
> > >
> > > efi-stub, vdso are very small.
> > >
> > > Unless this turns out to be painful, I prefer
> > > a simpler implementation.
> > >
> > > You will see how .scl file is handled.
> > >
> > > See the below code:
> > >
> > >
> > > diff --git a/Kbuild b/Kbuild
> > > index f327ca86990c..85747239314c 100644
> > > --- a/Kbuild
> > > +++ b/Kbuild
> > > @@ -67,10 +67,20 @@ targets += $(atomic-checks)
> > >  $(atomic-checks): $(obj)/.checked-%: include/linux/atomic/%  FORCE
> > >         $(call if_changed,check_sha1)
> > >
> > > +rebuild-$(CONFIG_GCC_PLUGINS)          += $(addprefix
> > > scripts/gcc-plugins/, $(GCC_PLUGIN))
> > > +rebuild-$(CONFIG_RANDSTRUCT)           += include/generated/randstruct_hash.h
> >
> > These are in $(objtree)
> 
> Yes.
> 
> > > +rebuild-$(CONFIG_UBSAN_INTEGER_WRAP)   += scripts/integer-wrap-ignore.scl
> >
> > This is in $(srctree)
> 
> Yes.
> 
> > > +
> > > +quiet_cmd_touch = TOUCH   $@
> > > +      cmd_touch = touch $@
> > > +
> > > +include/generated/global-rebuild.h: $(rebuild-y)
> > > +       $(call cmd,touch)
> >
> > Is this rule going to find the right versions of the dependencies?
> 
> I think so, but please test it.

The patch was white-space damaged and wrapped, but I rebuilt it manually
and it mostly works. There still seems to be some ordering issues, as
some stuff gets rebuilt on a record build:

# Clean the tree and pick an "everything" build
$ make O=gcc-test clean allmodconfig -s

# Make a target normally
$ make O=gcc-test kernel/seccomp.o -s

# Touch a gcc plugin that was in .config
$ touch scripts/gcc-plugins/stackleak_plugin.c

# Build and a full rebuild is triggered (good)
$ make O=gcc-test kernel/seccomp.o
make[1]: Entering directory '/srv/code/gcc-test'
  GEN     Makefile
  DESCEND objtool
  HOSTCXX scripts/gcc-plugins/stackleak_plugin.so
  INSTALL libsubcmd_headers
  TOUCH   include/generated/global-rebuild.h
  CC      kernel/bounds.s
  CC      arch/x86/kernel/asm-offsets.s
  CALL    ../scripts/checksyscalls.sh
  CC      kernel/seccomp.o
make[1]: Leaving directory '/srv/code/gcc-test'

# Build again, but more stuff gets built
$ make O=gcc-test kernel/seccomp.o
make[1]: Entering directory '/srv/code/gcc-test'
  GEN     Makefile
  DESCEND objtool
  CC      scripts/mod/empty.o
  CC      scripts/mod/devicetable-offsets.s
  INSTALL libsubcmd_headers
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTCC  scripts/mod/symsearch.o
  HOSTCC  scripts/mod/file2alias.o
  HOSTLD  scripts/mod/modpost
  CALL    ../scripts/checksyscalls.sh
make[1]: Leaving directory '/srv/code/gcc-test'

# Third time finally everything is stable
$ hmake O=gcc-test kernel/seccomp.o
make[1]: Entering directory '/srv/code/gcc-test'
  GEN     Makefile
  DESCEND objtool
  CALL    ../scripts/checksyscalls.sh
  INSTALL libsubcmd_headers
make[1]: Leaving directory '/srv/code/gcc-test'


Note that scripts/mod/* gets rebuilt on the second rebuild.


-- 
Kees Cook


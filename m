Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B2FC3ABCA
	for <linux-um@archiver.kernel.org>; Thu,  8 May 2025 17:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pppXYxJy60TByf0z+7Os2rj90jXqInqF2/euTdlfyqA=; b=WYta7nE2SZLnXkocJ/kF7xpcSD
	2Plk8UZpnQKcp8XU9Uwi0XRL8knDQTKx3fHsVPcoPQWifj9WC8CdFwP+/2KmS+mfqiUM/JPo5J37K
	8ydWnTKIzc23JHn+1pGfNxyUiRJObYnMINUYd/ThTSQcmYq2ffxnCic2N8EBHdxzMCTby1HKvlLWG
	8zjJobF1IFaejBih3g1ePgVjA70txjENTc5Bdqx0ZLyvt8YlNHD0XqcsMrCNiQVApnVHEH+gYqOuq
	ZVWZ0yvtonVlXvuh4s/GHbFshlTnXbMW+6MhE4VYLlID2donhurDbweNkn+/9LiFmCvVbq86Svi1U
	dll2x3MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD4vv-00000001NL6-31qh;
	Thu, 08 May 2025 17:21:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD4Mb-00000001JV4-0Xca
	for linux-um@lists.infradead.org;
	Thu, 08 May 2025 16:44:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 84A125C6388
	for <linux-um@lists.infradead.org>; Thu,  8 May 2025 16:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666C7C4AF0B
	for <linux-um@lists.infradead.org>; Thu,  8 May 2025 16:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746722687;
	bh=DdWar6fKEw55H1h+izcbqO8r64MP/OeOm+R9e7/8l0Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WM+LM73I7CqjIWYL3HVX2mY78LZu8C/ySLwTzSo6isbpFYteEkjG86gBRjnesCCFd
	 yTCTANT6SVySNMGoUChXN+tlrIhPPRoxzhYuWfAOwPqoFghmqqfWWKjaQCgxq7IH05
	 2CO4G33fRkzrm25wXTnkWsWcKW+xc1Tln6maTIcJuBLW/4Xy2LwdS/8pIPHV5QDW4Q
	 QP4FRrXZU8KU2JouDE37GW85+Rt9yyvKDngLjgnwEYUIirVYSgv8D1WoTweUlR5xdI
	 PY9LkRctjq8DEkK23ujoRVV6bHLbZIGVHSg1GU3eEz9C9JtH7eOxJxTJsWDEr/ORI3
	 YHMSSnd9NSU5w==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so11074251fa.2
        for <linux-um@lists.infradead.org>; Thu, 08 May 2025 09:44:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPTnWpGqadVsknEEJajXeFJAvT1m+RUoMglgyD6/baf6g/v0irAypy269ZFN3rsBImaft0S6FEXQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwMlFgiQiST6R1GmUtY3xwHjSNtGoaG5QwhMvzPqXO6rsAyyh9u
	vWT3d7RTmwN5qHGwEvB6I/3ycNbyhjoZE3eddqxkxpTmvhfVci8jenWW+JnaIm456mCj8dcjJlM
	/RThlyXdj8LdmlzLGzIS6EotwNCk=
X-Google-Smtp-Source: AGHT+IGsvci89voQr9pAUZ3y3eRydguJjpMN1T/NJZ9qNcW21aUTmZG4JL22IxfrotYYLFCzcegldF2dAZEWmitBgzE=
X-Received: by 2002:a05:651c:547:b0:30b:b987:b68d with SMTP id
 38308e7fff4ca-326c456b4e0mr971471fa.8.1746722686040; Thu, 08 May 2025
 09:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250502224512.it.706-kees@kernel.org> <CAK7LNAQCZMmAGfPTr1kgp5cNSdnLWMU5kC_duU0WzWnwZrqt2A@mail.gmail.com>
 <202505031028.7022F10061@keescook>
In-Reply-To: <202505031028.7022F10061@keescook>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 9 May 2025 01:44:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQehmFgB3kJtrkVhUKM1NEXGQrfJ3v3piToh7YV7-3ccw@mail.gmail.com>
X-Gm-Features: ATxdqUGBr2jT3f2a89H7dPi47dX43RaH0_KQGHELQlFyFtKIOvxwQNuJP6GjnKA
Message-ID: <CAK7LNAQehmFgB3kJtrkVhUKM1NEXGQrfJ3v3piToh7YV7-3ccw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Detect changed compiler dependencies for full rebuild
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Justin Stitt <justinstitt@google.com>, Marco Elver <elver@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_094449_271160_7B44F696 
X-CRM114-Status: GOOD (  31.35  )
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

On Sun, May 4, 2025 at 2:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Sat, May 03, 2025 at 06:39:28PM +0900, Masahiro Yamada wrote:
> > On Sat, May 3, 2025 at 7:54=E2=80=AFAM Kees Cook <kees@kernel.org> wrot=
e:
> > >
> > >  v2:
> > >   - switch from -include to -I with a -D gated include compiler-versi=
on.h
> > >  v1: https://lore.kernel.org/lkml/20250501193839.work.525-kees@kernel=
.org/
> >
> >
> > What do you think of my patch as a prerequisite?
> > https://lore.kernel.org/linux-kbuild/20250503084145.1994176-1-masahiroy=
@kernel.org/T/#u
> > Perhaps, can you implement this series more simply?
> >
> > My idea is to touch a single include/generated/global-rebuild.h
> > rather than multiple files such as gcc-plugins-deps.h, integer-wrap.h, =
etc.
> >
> > When the file is touched, the entire kernel source tree will be rebuilt=
.
> > This may rebuild more than needed (e.g. vdso) but I do not think
> > it is a big deal.
>
> This is roughly where I started when trying to implement this, but I
> didn't like the ergonomics of needing to scatter "touch" calls all over,
> which was especially difficult for targets that shared a build rule but
> may not all need to trigger a global rebuild. But what ultimately pushed
> me away from it was when I needed to notice if a non-built source file
> changed (the Clang .scl file), and I saw that I need to be dependency
> driven rather than target driven. (Though perhaps there is a way to
> address this with your global-rebuild.h?)
>
> As far as doing a full rebuild, if it had been available last week, I
> probably would have used it, but now given the work that Nicolas, you,
> and I have put into this, we have a viable way (I think) to make this
> more specific. It does end up being a waste of time/resources to rebuild
> stuff that doesn't need to be (efi-stub, vdso, boot code, etc), and that
> does add up when I'm iterating on something that keeps triggering a full
> rebuild. We already have to do the argument filtering for targets that
> don't want randstruct, etc, so why not capitalize on that and make the
> rebuild avoid those files too?


efi-stub, vdso are very small.

Unless this turns out to be painful, I prefer
a simpler implementation.

You will see how .scl file is handled.

See the below code:


diff --git a/Kbuild b/Kbuild
index f327ca86990c..85747239314c 100644
--- a/Kbuild
+++ b/Kbuild
@@ -67,10 +67,20 @@ targets +=3D $(atomic-checks)
 $(atomic-checks): $(obj)/.checked-%: include/linux/atomic/%  FORCE
        $(call if_changed,check_sha1)

+rebuild-$(CONFIG_GCC_PLUGINS)          +=3D $(addprefix
scripts/gcc-plugins/, $(GCC_PLUGIN))
+rebuild-$(CONFIG_RANDSTRUCT)           +=3D include/generated/randstruct_h=
ash.h
+rebuild-$(CONFIG_UBSAN_INTEGER_WRAP)   +=3D scripts/integer-wrap-ignore.sc=
l
+
+quiet_cmd_touch =3D TOUCH   $@
+      cmd_touch =3D touch $@
+
+include/generated/global-rebuild.h: $(rebuild-y)
+       $(call cmd,touch)
+
 # A phony target that depends on all the preparation targets

 PHONY +=3D prepare
-prepare: $(offsets-file) missing-syscalls $(atomic-checks)
+prepare: $(offsets-file) missing-syscalls $(atomic-checks)
include/generated/global-rebuild.h
        @:

 # Ordinary directory descending
diff --git a/Makefile b/Makefile
index b29cc321ffd9..f963a72b0761 100644
--- a/Makefile
+++ b/Makefile
@@ -558,7 +558,8 @@ USERINCLUDE    :=3D \
                -I$(srctree)/include/uapi \
                -I$(objtree)/include/generated/uapi \
                 -include $(srctree)/include/linux/compiler-version.h \
-                -include $(srctree)/include/linux/kconfig.h
+                -include $(srctree)/include/linux/kconfig.h \
+                -include $(objtree)/include/generated/global-rebuild.h

 # Use LINUXINCLUDE when you must reference the include/ directory.
 # Needed to be compatible with the O=3D option
@@ -1250,6 +1251,12 @@ endif
 include/config/kernel.release: FORCE
        $(call filechk,kernel.release)

+quiet_cmd_touch =3D TOUCH   $@
+      cmd_touch =3D touch $@
+
+include/generated/global-rebuild.h:
+       $(call cmd,touch)
+
 # Additional helpers built in scripts/
 # Carefully list dependencies so we do not try to build scripts twice
 # in parallel
@@ -1266,6 +1273,7 @@ scripts: scripts_basic scripts_dtc
 PHONY +=3D prepare archprepare

 archprepare: outputmakefile archheaders archscripts scripts
include/config/kernel.release \
+       include/generated/global-rebuild.h \
        asm-generic $(version_h) include/generated/utsrelease.h \
        include/generated/compile.h include/generated/autoconf.h \
        include/generated/rustc_cfg remove-stale-files
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 1d36a613aad8..f564a26c1364 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -73,7 +73,8 @@ USER_CFLAGS =3D $(patsubst
$(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
                -D_FILE_OFFSET_BITS=3D64 -idirafter $(srctree)/include \
                -idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__ \
                -include $(srctree)/include/linux/compiler-version.h \
-               -include $(srctree)/include/linux/kconfig.h
+               -include $(srctree)/include/linux/kconfig.h \
+               -include $(objtree)/include/generated/global-rebuild.h

 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-Linux









--=20
Best Regards
Masahiro Yamada


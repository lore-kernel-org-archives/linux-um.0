Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8CCC369D9
	for <linux-um@archiver.kernel.org>; Sat,  3 May 2025 06:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0+Ax35WNqVI/5m43wjx3nYTlibRzAFsgYE2Zj2RZzvA=; b=QPOKprxj50x81JXr9IfBTP3JK4
	5dSWvQMsZi+1eo1+DW/B6BGPEEUB+HEo7yxJrSDNw5t4NN6PsV3Fvv38aIgfb91LZyS7TQcSeG6Fz
	Re8DtzerfRQ0sRvrMDzMwLsislFLoXr9qzGRaeQHrSECQYNl40DDL0GjUwSrczLA3bJyYIHnoAocD
	SdNECFXCXlktUbN5I5esKHzQ528dARAQdBi9h+iyjosCS1RUFRo6akOA6sUjmwHyHuMl9IGlp2U+v
	Jx1IrY8A2mkLOCdM9NvPABuLj67e8PZggzWRTjwQ1LdZVhbluMlTHAG2L8Qf/ThOeYh6jWyIj/z9p
	+Q3XNYSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uB68D-00000003YIM-2ZfA;
	Sat, 03 May 2025 06:13:49 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uB68B-00000003YHx-0ItE
	for linux-um@lists.infradead.org;
	Sat, 03 May 2025 06:13:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DEEF2A49F68
	for <linux-um@lists.infradead.org>; Sat,  3 May 2025 06:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE5CC4CEE3
	for <linux-um@lists.infradead.org>; Sat,  3 May 2025 06:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746252824;
	bh=2U2wL8Pi543SbcmyoJldkSSWk5buF2ORkxSTsHb5ZcU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n7KyF4ZB1M1lW25+vAIiKOWa09Mp70QwKyPuOJaenwL4jYrAa7brkFXoY55paxX/S
	 S6D2fuQJHjAY+2LuyUyc4cEWlGplX8lv+JrkhC4tx0ZGoJ+aaokTr88s/8gkixj9ds
	 /ypkQo4zOAh5Sa6nDZxov+6sfIOruc4Y7a0o3IhqMU+PPQL8vwghGbJiRQSlmYTMm9
	 XhVW1PrQb6Nn2sAlPtiszxDafC1xVutFBh6nkIJfO/1wh+hE+tePFIKX2Iws2X/BQK
	 DYDCCl32TsMnAupJIbXzU+rEJhp4XGd+Z11U3p6y04AtEDNaD9Hfu567RE1PuvWBAK
	 7Bw7Cg2P4e4GA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54993c68ba0so3424849e87.2
        for <linux-um@lists.infradead.org>; Fri, 02 May 2025 23:13:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiLSYOJ+ysx7YBq7GzJ6Dt8LXxv+ePmDUJ6zSY0JFlB76YQYYXDbfyH2u+t4oSguyvE1Z0aMt10g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxmy8lDmkWitTHzYxIX6pk9sFMd/nWHF39zMLn9JDY4+H/VU5Qj
	Jc8vLFXnyTFeA22xWp5+ZDU8K8eTuh/NgzejGlVOI9MRE1Pi6ZFZpZIWhiwsb6nkvbLqV8JAe6j
	pL4pzy1O2wlAnzNDFX58iCVF38rg=
X-Google-Smtp-Source: AGHT+IHDMQa+oNCs5qON+sDDzQNEJC5z9iOjeQOtZXdg5euKKxFYjlqPHELLj7u3v7dizjxFZqmOgZF1dJh6ss58uGc=
X-Received: by 2002:a05:6512:3f1c:b0:549:7d6e:fe84 with SMTP id
 2adb3069b0e04-54eac2433c8mr1283219e87.53.1746252823032; Fri, 02 May 2025
 23:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250502224512.it.706-kees@kernel.org> <20250502225416.708936-2-kees@kernel.org>
In-Reply-To: <20250502225416.708936-2-kees@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 3 May 2025 15:13:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNATDbxc+3HQ6zoSk9t-Lkf4MSNmEUN6S5EqoVWnBQw_K6g@mail.gmail.com>
X-Gm-Features: ATxdqUF76dt_7gcYn_ksSKtSA5fymBjXQ0TBB0SjwOyXw1Ac63YqHHphqbqToKc
Message-ID: <CAK7LNATDbxc+3HQ6zoSk9t-Lkf4MSNmEUN6S5EqoVWnBQw_K6g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] randstruct: Force full rebuild when seed changes
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kbuild@vger.kernel.org, Justin Stitt <justinstitt@google.com>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_231347_252143_C3DFF0C1 
X-CRM114-Status: GOOD (  20.30  )
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

On Sat, May 3, 2025 at 7:54=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> While the randstruct GCC plugin was being rebuilt if the randstruct
> seed changed, Clangs build did not notice the change. Include the hash
> header directly so that it becomes a universal build dependency and full
> rebuilds will happen if it changes.
>
> Since we cannot use "-include ..." as the randstruct flags are removed
> via "filter-out" (which would cause all instances of "-include" to be
> removed), use the existing -DRANDSTRUCT to control the header inclusion
> via include/linux/compiler-version.h. Universally add a -I for the
> scripts/basic directory, where header exists. The UM build requires that
> the -I be explicitly added.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas.schier@linux.dev>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: <linux-kbuild@vger.kernel.org>
> ---
>  Makefile                         |  1 +
>  arch/um/Makefile                 |  1 +
>  include/linux/compiler-version.h |  3 +++
>  include/linux/vermagic.h         |  1 -
>  scripts/basic/Makefile           | 11 ++++++-----
>  5 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 5aa9ee52a765..cef652227843 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -567,6 +567,7 @@ LINUXINCLUDE    :=3D \
>                 -I$(objtree)/arch/$(SRCARCH)/include/generated \
>                 -I$(srctree)/include \
>                 -I$(objtree)/include \
> +               -I$(objtree)/scripts/basic \


Now you are adding random header search paths everywhere.
This is very hacky.


I recommend keeping <generated/randstruct_hash.h>

Then,  -I$(objtree)/scripts/basic is unneeded.


>                 $(USERINCLUDE)
>
>  KBUILD_AFLAGS   :=3D -D__ASSEMBLY__ -fno-PIE
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index 8cc0f22ebefa..38f6024e75d7 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -73,6 +73,7 @@ USER_CFLAGS =3D $(patsubst $(KERNEL_DEFINES),,$(patsubs=
t -I%,,$(KBUILD_CFLAGS))) \
>                 -D_FILE_OFFSET_BITS=3D64 -idirafter $(srctree)/include \
>                 -idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__ =
\
>                 -I$(objtree)/scripts/gcc-plugins \
> +               -I$(objtree)/scripts/basic \
>                 -include $(srctree)/include/linux/compiler-version.h \
>                 -include $(srctree)/include/linux/kconfig.h
>
> diff --git a/include/linux/compiler-version.h b/include/linux/compiler-ve=
rsion.h
> index 08943df04ebb..05d555320a0f 100644
> --- a/include/linux/compiler-version.h
> +++ b/include/linux/compiler-version.h
> @@ -16,3 +16,6 @@
>  #ifdef GCC_PLUGINS_ENABLED
>  #include "gcc-plugins-deps.h"
>  #endif
> +#ifdef RANDSTRUCT
> +#include "randstruct_hash.h"
> +#endif
> diff --git a/include/linux/vermagic.h b/include/linux/vermagic.h
> index 939ceabcaf06..335c360d4f9b 100644
> --- a/include/linux/vermagic.h
> +++ b/include/linux/vermagic.h
> @@ -33,7 +33,6 @@
>  #define MODULE_VERMAGIC_MODVERSIONS ""
>  #endif
>  #ifdef RANDSTRUCT
> -#include <generated/randstruct_hash.h>
>  #define MODULE_RANDSTRUCT "RANDSTRUCT_" RANDSTRUCT_HASHED_SEED
>  #else
>  #define MODULE_RANDSTRUCT
> diff --git a/scripts/basic/Makefile b/scripts/basic/Makefile
> index dd289a6725ac..31637ce4dc5c 100644
> --- a/scripts/basic/Makefile
> +++ b/scripts/basic/Makefile
> @@ -8,9 +8,10 @@ hostprogs-always-y     +=3D fixdep
>  # before running a Clang kernel build.
>  gen-randstruct-seed    :=3D $(srctree)/scripts/gen-randstruct-seed.sh
>  quiet_cmd_create_randstruct_seed =3D GENSEED $@
> -cmd_create_randstruct_seed =3D \
> -       $(CONFIG_SHELL) $(gen-randstruct-seed) \
> -               $@ $(objtree)/include/generated/randstruct_hash.h
> -$(obj)/randstruct.seed: $(gen-randstruct-seed) FORCE
> +      cmd_create_randstruct_seed =3D $(CONFIG_SHELL) $(gen-randstruct-se=
ed) \
> +               $(obj)/randstruct.seed $(obj)/randstruct_hash.h
> +
> +$(obj)/randstruct_hash.h $(obj)/randstruct.seed: $(gen-randstruct-seed) =
FORCE
>         $(call if_changed,create_randstruct_seed)


This is wrong.


$(obj)/randstruct_hash.h $(obj)/randstruct.seed: $(gen-randstruct-seed) FOR=
CE
         $(call if_changed,create_randstruct_seed)

is equivalent to:

$(obj)/randstruct_hash.h: $(gen-randstruct-seed) FORCE
         $(call if_changed,create_randstruct_seed)

$(obj)/randstruct.seed: $(gen-randstruct-seed) FORCE
         $(call if_changed,create_randstruct_seed)


So, this rule is executed twice; for randstruct_hash.h and for randstruct.s=
eed

randstruct_hash.h and randstruct.seed will contain different hash values.

I recommend keeping the current code.













--
Best Regards
Masahiro Yamada


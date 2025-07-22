Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F78C87FC5
	for <linux-um@archiver.kernel.org>; Tue, 22 Jul 2025 15:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GboL0eWXtD3fDsEKzgJ1xepA1JQohVF9co6pstDgRM8=; b=coqCEJt7OAWbBVaf2VLYrZGlmp
	kS0DZ8RonmUsk/CDHssfYrNJTEQ4TWNwCDf9YAqQY35XYJLfY8peQ6D2yFGKQsuJJ7EAgucl6Jm7J
	l+dM6+2GXxZC/W5kPvZCiHxa0ypXqZ9O0iNnFGYioRXY4xnFSQj3r9zKx1LfrNqPsYMZCH4mrab3I
	R7KhxLqlBeSnS1DPbICSXW3op4kq21d6rM7GDzfKHOl2yaiwXco0/OpdujRrSYbf21ojZotdwGKck
	oYtwxLhYjPFh+PzryERUg5hwtcpzpYtWWzkXlIe/8+j3SK6VXdkmaaBRvaMHihqGJHxc7m3tjo1IJ
	fhRZanKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueEyY-00000002shw-2D5l;
	Tue, 22 Jul 2025 15:32:18 +0000
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueDo3-00000002fns-26FZ;
	Tue, 22 Jul 2025 14:17:24 +0000
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-32b5226e6beso54161441fa.2;
        Tue, 22 Jul 2025 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753193842; x=1753798642; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GboL0eWXtD3fDsEKzgJ1xepA1JQohVF9co6pstDgRM8=;
        b=PlCNMmEGafdS9aD70KNuYuzC0dmfOvDHNG4bm5ZnMqXMbGRYnnIEAlAeQxAAFu8G+T
         iUAz1kO7MWgrvPG2TsXJHXWugTS21IHLzaspBfsyIJ3q1XqYWpbNRDdpQFhHFlN3ZHib
         /9bt+uOuuNXy/LLkUFa7KwG5jpMkTcA6zKid/Yj0DHZo0AmMz4j823KTXenWuQxDIo+C
         p7aryu0mn/RnL6UIP3tihC7Qh5qyR3vQVbvzkRoOZFDrDacXOMe5b3pX+lPPyErWM1Sy
         HNMvtBO6aP6s5HymGjcIe3oQ4Dsvyw43QTpTT5O1QAcydh12uSDrODdGMM0LfUatMMIX
         909Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753193842; x=1753798642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GboL0eWXtD3fDsEKzgJ1xepA1JQohVF9co6pstDgRM8=;
        b=dUq87XjCH589lNINYHtuixVBW2dmo0dF8Ng7V2GWskOfSeduPKk3DhPoBjK6MMNChj
         x7gXaCoWvDoT7cw5E67kzC8JN5eK5g9+KF6zOLZCT5S+ajNML5WQYOYRrUhOtYw7kHvo
         fhrnKgdIdeZHFYe+wpJs1mYLF6rDMdv4Px9SmY7EMhYMFEg7GoP1OYfXAKuL1MTSKXFL
         TQfhVu7qVzlDuQ1lvBGBgxZTEPteOdKcE+etdpCaRyw2Kc8e3bDRftyfiSOfgfZUPdWz
         rpotgM+joZKZesuZBwq/JbbuuD/o73T5Nwpr0o9MozLcV/VgqId3ZBsape7TcruSMp47
         1wGg==
X-Forwarded-Encrypted: i=1; AJvYcCUfTbGiV6x7sdkaNHXVaDdKOusx98EDz02pLuCSDP6qyLoMz/tEGhg0M0gv7B6/EhE2UddiY+P/h+kxnw==@lists.infradead.org, AJvYcCV1lnTygRWVOTrJZCiNqOSmmcK6YWNEKlGSMRavg9OtpB9eWO7aQn53lu06BA7TzoY/5nz/IXfhaBk=@lists.infradead.org
X-Gm-Message-State: AOJu0Yydp1OnLr6F0jMJE6jYEVlwaS+U45RSUaenLMDRSfW1aJcLtRkg
	tw1+tnEJyhqfagvgnXFJL+Q0kBw+dEJlzXLaG23iSQR/owOMfBtzxEPSbNKcl09UMh3GYHFITif
	A4ebm0KUH8GbhMvW12pxy9AuKPAGykBs=
X-Gm-Gg: ASbGncuiO2w9for5CUaormQpA4Kl1PRd4V+IWPomAJgLLjDLD0GoRMS52YBoIljAcQ5
	qQGWKlmByjfaGV5o99dO8NlzUS8KQBIOVaRKoCmQnC/RYRMgJ2mA0Qkv3PlUvyaXCtNTw9w9K+Z
	ACyHFXw+TXBHBR+ZnJKWEgQtE5AarBfUaiWsgYyQb/KtRu/0y4rjmtMWPKZeZnr1fzwtPiNL5al
	SCV8Og=
X-Google-Smtp-Source: AGHT+IHWyFSdlAJ08NCU6ABmF9BGYFP4zXRYUy0aJCm6G+P21nbWRd00HVhqfmwkvmBdoun3tyqTRuImHuMXXJuHVwM=
X-Received: by 2002:a05:651c:110d:b0:32b:75f0:cfa4 with SMTP id
 38308e7fff4ca-3308f5c95f9mr70998461fa.25.1753193841372; Tue, 22 Jul 2025
 07:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250717142732.292822-1-snovitoll@gmail.com> <20250717142732.292822-9-snovitoll@gmail.com>
 <85de2e1f-a787-4862-87e4-2681e749cef0@gmail.com>
In-Reply-To: <85de2e1f-a787-4862-87e4-2681e749cef0@gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Tue, 22 Jul 2025 19:17:03 +0500
X-Gm-Features: Ac12FXzF_nEInn7KovIF1rCbPeOEkryRpoS2Hx7q1NkLYIXq7eXxsmx3CUCidIg
Message-ID: <CACzwLxiD98BLmEmPhkJQgv297bP_7qw+Vm_icFhTiDYN7WvLjw@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] kasan/um: select ARCH_DEFER_KASAN and call kasan_init_generic
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com, 
	agordeev@linux.ibm.com, akpm@linux-foundation.org, glider@google.com, 
	dvyukov@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250722_071723_541525_9991649A 
X-CRM114-Status: GOOD (  23.34  )
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

On Tue, Jul 22, 2025 at 4:00=E2=80=AFAM Andrey Ryabinin <ryabinin.a.a@gmail=
.com> wrote:
>
>
>
> On 7/17/25 4:27 PM, Sabyrzhan Tasbolatov wrote:
> > UserMode Linux needs deferred KASAN initialization as it has a custom
> > kasan_arch_is_ready() implementation that tracks shadow memory readines=
s
> > via the kasan_um_is_ready flag.
> >
> > Select ARCH_DEFER_KASAN to enable the unified static key mechanism
> > for runtime KASAN control. Call kasan_init_generic() which handles
> > Generic KASAN initialization and enables the static key.
> >
> > Delete the key kasan_um_is_ready in favor of the unified kasan_enabled(=
)
> > interface.
> >
> > Note that kasan_init_generic has __init macro, which is called by
> > kasan_init() which is not marked with __init in arch/um code.
> >
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217049
> > Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> > ---
> > Changes in v3:
> > - Added CONFIG_ARCH_DEFER_KASAN selection for proper runtime control
> > ---
> >  arch/um/Kconfig             | 1 +
> >  arch/um/include/asm/kasan.h | 5 -----
> >  arch/um/kernel/mem.c        | 4 ++--
> >  3 files changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> > index f08e8a7fac9..fd6d78bba52 100644
> > --- a/arch/um/Kconfig
> > +++ b/arch/um/Kconfig
> > @@ -8,6 +8,7 @@ config UML
> >       select ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >       select ARCH_HAS_CPU_FINALIZE_INIT
> >       select ARCH_HAS_FORTIFY_SOURCE
> > +     select ARCH_DEFER_KASAN
> >       select ARCH_HAS_GCOV_PROFILE_ALL
> >       select ARCH_HAS_KCOV
> >       select ARCH_HAS_STRNCPY_FROM_USER
> > diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
> > index f97bb1f7b85..81bcdc0f962 100644
> > --- a/arch/um/include/asm/kasan.h
> > +++ b/arch/um/include/asm/kasan.h
> > @@ -24,11 +24,6 @@
> >
> >  #ifdef CONFIG_KASAN
> >  void kasan_init(void);
> > -extern int kasan_um_is_ready;
> > -
> > -#ifdef CONFIG_STATIC_LINK
> > -#define kasan_arch_is_ready() (kasan_um_is_ready)
> > -#endif
> >  #else
> >  static inline void kasan_init(void) { }
> >  #endif /* CONFIG_KASAN */
> > diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> > index 76bec7de81b..058cb70e330 100644
> > --- a/arch/um/kernel/mem.c
> > +++ b/arch/um/kernel/mem.c
> > @@ -21,9 +21,9 @@
> >  #include <os.h>
> >  #include <um_malloc.h>
> >  #include <linux/sched/task.h>
> > +#include <linux/kasan.h>
> >
> >  #ifdef CONFIG_KASAN
> > -int kasan_um_is_ready;
> >  void kasan_init(void)
> >  {
> >       /*
> > @@ -32,7 +32,7 @@ void kasan_init(void)
> >        */
> >       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
> >       init_task.kasan_depth =3D 0;
> > -     kasan_um_is_ready =3D true;
> > +     kasan_init_generic();
>
> I think this runs before jump_label_init(), and static keys shouldn't be =
switched before that.>  }

I got the warning in my local compilation and from kernel CI [1].

arch/um places kasan_init() in own `.kasan_init` section, while
kasan_init_generic() is called from __init.
Could you suggest a way how I can verify the functions call order?

I need to familiarize myself with how to run arch/um locally and try
to fix this warning.

[1] https://lore.kernel.org/all/CACzwLxicmky4CRdmABtN8m2cr2EpuMxLPqeF5Hk375=
cN2Kvu-Q@mail.gmail.com/

> >
> >  static void (*kasan_init_ptr)(void)
>


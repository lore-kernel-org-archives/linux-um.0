Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F7BC87FDA
	for <linux-um@archiver.kernel.org>; Wed,  6 Aug 2025 14:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HHHtXBq5WO+vvcc0f+jtGoFoRXRDF9tjNLE6vwGhp98=; b=OiR3mXx6i3KL9LPapeN1gjXuyu
	LLSdkfrjfE9Ydobt0LAiuVTgEBW6UUJv7yE3A4i6h8UiPxlJ4vQCp4v5yrtW/xSeod/+LtyjKpYSX
	u1QlcXoAsxWyHFpdXJ/YYSdR0odktBQmr9lMLlmpBdz5oV7mQuJ2C/XiSkXcxwuFWHQeINLygLKJt
	0wFYa98LtvtgoKyRaZLfH8oUQteCO1kLaqTtmyLQHe4CTgXH9mKRkwI5fgxDwHMgWNd+9P2N1xm76
	7BDc92gj7M43RHiGQo1ix7sHT+xaHkZJbrEFRDo27W4iT6eda+19BIQmyFipKVmCozrh3ognASnY6
	Z85tOAFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujexL-0000000FQGD-03d8;
	Wed, 06 Aug 2025 14:17:27 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujevI-0000000FPzb-14nr;
	Wed, 06 Aug 2025 14:15:21 +0000
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-55b93104888so5884472e87.1;
        Wed, 06 Aug 2025 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754489718; x=1755094518; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHHtXBq5WO+vvcc0f+jtGoFoRXRDF9tjNLE6vwGhp98=;
        b=PLLTK7asOcjbBBZXyw2CRmWAkWxNGCgC9uIaHDOkokG8fLKb/FTvxalPLmXY0xO0zY
         Xcdp/6JmpcI6sBSPBUXgM16grhA35mVYfuxk4n5Fd4TptZhHyo4oQpYLl52Ggv9+RjUk
         26L1+pAy6O5v136kyMpXyNnN9Z3J2qKvmn29LOM3PH8tvP4LuzmwicaDp1+Gb6Xyr11t
         9cd5qiTAXvdKTI2HGOQBZRJzkh279Xn9cp4KeKOgNm7NIuGNEFKpj4Bcwbbyuk0BJo6B
         4a8GhFJy8oY93v6HERZqfYcA/w1ighk0uoZ0qDT0sgNAAuVItS3n4WB/7RbVIFXJvPxt
         RVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754489718; x=1755094518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHHtXBq5WO+vvcc0f+jtGoFoRXRDF9tjNLE6vwGhp98=;
        b=JCZwbpu/cwIefXp00rPQ8LLdVrJmOarFJnIpavRfCRSc/x0Kqcn47Gvnm8hOwyeRMe
         fCbSBsg+iKHIh3Fa14uYDO2oBIraFTNptex9B9vEHh+VgpmQdDXR7dk/AcpCsDEy6B/d
         fRCjdJTlz/fCRSvZ2/BOKCrg+0W1zfFXzSZEXTqwJDWDZLDyVBTPSOm+5ovh/huUcYtL
         MtPTV8WVxoojKbN6mt5d9qHTgIr5MamMe/SmidaAQY/cG3ClY3ZoemEXvPw0RmpoWVOH
         xKjyHCviH2ZTXZkdQwYlb9r8IcqaKeLX1p/4fp932w9YoP3hZR7XY2LhWuC3WakC5A5m
         MN9w==
X-Forwarded-Encrypted: i=1; AJvYcCV0ygI4YzxG7Gb2l2b98zMxi4thBefZWQ7VwYAqIxKaicpqilNaEu/ITF3Z/OyQrsHlScO/99ge7bE=@lists.infradead.org, AJvYcCWnEwn+PJg/FCRH/swin0GM3C7X20oLN5xR56WS74UJkSBZQc9P0xw396Bw8X6Z4PwPGipliOftCcX5Pw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzy5jbLXklx9Y2YBkMteOjc3ym+BFJwunvzVTDEamBxvEM7zfki
	pAjyHhLCVIw4oDxHNrQ+O2ldzUrLjIaSi59CMrif3Z4zi/HCTHWPLd4a7sLmgUCI5dcnIOsP+vS
	XHGFOyw08QIGeJ6M9JR/teLKjwQB5aqQ=
X-Gm-Gg: ASbGncsjX9W0MDAych7IbZLTEPEKUlS84iJNMDtsqCPAgZEBbCwyvUKpHtIExgXeUs0
	UmY50o6gPW0eP3aPf8Rqd9dVkDhLQ3XgPszRhLBMqZOr7LAC/zbHF4Ug00J7Y+8bSK7hhN065vK
	NDhPJu55FEMt3SbonywzqE6ejPvOS8cY6vBlpJttXZIRYb9H8Pzc20V6r+OnI+j186yxfSfN5M3
	sQhVtM9oZWnIENFmA==
X-Google-Smtp-Source: AGHT+IGJIXTvnACCtHBTy4xxxFNjsKAhes5Wv7IRo3RcAz7+56gG6smaMf7pNYbDbu4cgI3F5Fzl+OIwDZB8GhsMAoI=
X-Received: by 2002:a05:6512:144c:10b0:55a:90b:7a37 with SMTP id
 2adb3069b0e04-55caf3b36c2mr652245e87.50.1754489718011; Wed, 06 Aug 2025
 07:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250805142622.560992-1-snovitoll@gmail.com> <20250805142622.560992-2-snovitoll@gmail.com>
 <5a73e633-a374-47f2-a1e1-680e24d9f260@gmail.com>
In-Reply-To: <5a73e633-a374-47f2-a1e1-680e24d9f260@gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 6 Aug 2025 19:15:01 +0500
X-Gm-Features: Ac12FXyPyQ2NShErRdFgyvw5rZUg2mPvtAtIHmw2QjkFVe_vIUdzA6ST_4dfZTU
Message-ID: <CACzwLxg=zC-82sY6f-z0VOnmbpN2E8tQxe7RyOnynpbJEFP+NA@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com, 
	agordeev@linux.ibm.com, akpm@linux-foundation.org, zhangqing@loongson.cn, 
	chenhuacai@loongson.cn, trishalfonso@google.com, davidgow@google.com, 
	glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_071520_307668_D20CF903 
X-CRM114-Status: GOOD (  35.87  )
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

On Wed, Aug 6, 2025 at 6:35=E2=80=AFPM Andrey Ryabinin <ryabinin.a.a@gmail.=
com> wrote:
>
>
>
> On 8/5/25 4:26 PM, Sabyrzhan Tasbolatov wrote:
> > Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
> > to defer KASAN initialization until shadow memory is properly set up,
> > and unify the static key infrastructure across all KASAN modes.
> >
> > Some architectures (like PowerPC with radix MMU) need to set up their
> > shadow memory mappings before KASAN can be safely enabled, while others
> > (like s390, x86, arm) can enable KASAN much earlier or even from the
> > beginning.
> >
> > Historically, the runtime static key kasan_flag_enabled existed only fo=
r
> > CONFIG_KASAN_HW_TAGS mode. Generic and SW_TAGS modes either relied on
> > architecture-specific kasan_arch_is_ready() implementations or evaluate=
d
> > KASAN checks unconditionally, leading to code duplication.
> >
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217049
> > Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> > ---
> > Changes in v4:
> > - Fixed HW_TAGS static key functionality (was broken in v3)
>
> I don't think it fixed. Before you patch kasan_enabled() esentially
> worked like this:
>
>  if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>         return static_branch_likely(&kasan_flag_enabled);
>  else
>         return IS_ENABLED(CONFIG_KASAN);
>
> Now it's just IS_ENABLED(CONFIG_KASAN);

In v4 it is:

        #if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAG=
S)
        static __always_inline bool kasan_shadow_initialized(void)
        {
                return static_branch_likely(&kasan_flag_enabled);
        }
        #else
        static __always_inline bool kasan_shadow_initialized(void)
        {
                return kasan_enabled(); // which is IS_ENABLED(CONFIG_KASAN=
);
        }
        #endif

So for HW_TAGS, KASAN is enabled in kasan_init_hw_tags().

>
> And there are bunch of kasan_enabled() calls left whose behavior changed =
for
> no reason.

By having in v5 the only check kasan_enabled() and used in current mainline=
 code
should be right. I've addressed this comment below. Thanks!

>
>
> > - Merged configuration and implementation for atomicity
> > ---
> >  include/linux/kasan-enabled.h | 36 +++++++++++++++++++++++-------
> >  include/linux/kasan.h         | 42 +++++++++++++++++++++++++++--------
> >  lib/Kconfig.kasan             |  8 +++++++
> >  mm/kasan/common.c             | 18 ++++++++++-----
> >  mm/kasan/generic.c            | 23 +++++++++++--------
> >  mm/kasan/hw_tags.c            |  9 +-------
> >  mm/kasan/kasan.h              | 36 +++++++++++++++++++++---------
> >  mm/kasan/shadow.c             | 32 ++++++--------------------
> >  mm/kasan/sw_tags.c            |  4 +++-
> >  mm/kasan/tags.c               |  2 +-
> >  10 files changed, 133 insertions(+), 77 deletions(-)
> >
> > diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enable=
d.h
> > index 6f612d69ea0..52a3909f032 100644
> > --- a/include/linux/kasan-enabled.h
> > +++ b/include/linux/kasan-enabled.h
> > @@ -4,32 +4,52 @@
> >
> >  #include <linux/static_key.h>
> >
> > -#ifdef CONFIG_KASAN_HW_TAGS
> > +/* Controls whether KASAN is enabled at all (compile-time check). */
> > +static __always_inline bool kasan_enabled(void)
> > +{
> > +     return IS_ENABLED(CONFIG_KASAN);
> > +}
> >
> > +#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
> > +/*
> > + * Global runtime flag for KASAN modes that need runtime control.
> > + * Used by ARCH_DEFER_KASAN architectures and HW_TAGS mode.
> > + */
> >  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> >
> > -static __always_inline bool kasan_enabled(void)
> > +/*
> > + * Runtime control for shadow memory initialization or HW_TAGS mode.
> > + * Uses static key for architectures that need deferred KASAN or HW_TA=
GS.
> > + */
> > +static __always_inline bool kasan_shadow_initialized(void)
>
> Don't rename it, just leave as is - kasan_enabled().
> It's better name, shorter and you don't need to convert call sites, so
> there is less chance of mistakes due to unchanged kasan_enabled() -> kasa=
n_shadow_initialized().

I actually had the only check "kasan_enabled()" in v2, but went to
double check approach in v3
after this comment:
https://lore.kernel.org/all/CA+fCnZcGyTECP15VMSPh+duLmxNe=3DApHfOnbAY3NqtFH=
ZvceZw@mail.gmail.com/

Ok, we will have the **only** check kasan_enabled() then in
kasan-enabled.h which

        #if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAG=
S)
        static __always_inline bool kasan_enabled(void)
        {
                return static_branch_likely(&kasan_flag_enabled);
        }
        #else
        static inline bool kasan_enabled(void)
        {
                return IS_ENABLED(CONFIG_KASAN);
        }

And will remove kasan_arch_is_ready (current kasan_shadow_initialized in v4=
).

So it is the single place to check if KASAN is enabled for all arch
and internal KASAN code.
Same behavior is in the current mainline code but only for HW_TAGS.

Is this correct?

>
>
> >  {
> >       return static_branch_likely(&kasan_flag_enabled);
> >  }
> >
> > -static inline bool kasan_hw_tags_enabled(void)
> > +static inline void kasan_enable(void)
> > +{
> > +     static_branch_enable(&kasan_flag_enabled);
> > +}
> > +#else
> > +/* For architectures that can enable KASAN early, use compile-time che=
ck. */
> > +static __always_inline bool kasan_shadow_initialized(void)
> >  {
> >       return kasan_enabled();
> >  }
> >
>
> ...
>
> >
> >  void kasan_populate_early_vm_area_shadow(void *start, unsigned long si=
ze);
> > -int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
> > -void kasan_release_vmalloc(unsigned long start, unsigned long end,
> > +
> > +int __kasan_populate_vmalloc(unsigned long addr, unsigned long size);
> > +static inline int kasan_populate_vmalloc(unsigned long addr, unsigned =
long size)
> > +{
> > +     if (!kasan_shadow_initialized())
> > +             return 0;
>
>
> What's the point of moving these checks to header?
> Leave it in C, it's easier to grep and navigate code this way.

Andrey Konovalov had comments [1] to avoid checks in C
by moving them to headers under __wrappers.

: 1. Avoid spraying kasan_arch_is_ready() throughout the KASAN
: implementation and move these checks into include/linux/kasan.h (and
: add __wrappers when required).

[1] https://lore.kernel.org/all/CA+fCnZcGyTECP15VMSPh+duLmxNe=3DApHfOnbAY3N=
qtFHZvceZw@mail.gmail.com/

>
>
> > +     return __kasan_populate_vmalloc(addr, size);
> > +}
> > +
> > +void __kasan_release_vmalloc(unsigned long start, unsigned long end,
> >                          unsigned long free_region_start,
> >                          unsigned long free_region_end,
> >                          unsigned long flags);
> > +static inline void kasan_release_vmalloc(unsigned long start,
> > +                        unsigned long end,
> > +                        unsigned long free_region_start,
> > +                        unsigned long free_region_end,
> > +                        unsigned long flags)
> > +{
> > +     if (kasan_shadow_initialized())
> > +             __kasan_release_vmalloc(start, end, free_region_start,
> > +                        free_region_end, flags);
> > +}
> >
>
> ...> @@ -250,7 +259,7 @@ static inline void poison_slab_object(struct kme=
m_cache *cache, void *object,
> >  bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
> >                               unsigned long ip)
> >  {
> > -     if (!kasan_arch_is_ready() || is_kfence_address(object))
> > +     if (is_kfence_address(object))
> >               return false;
> >       return check_slab_allocation(cache, object, ip);
> >  }
> > @@ -258,7 +267,7 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache=
, void *object,
> >  bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool in=
it,
> >                      bool still_accessible)
> >  {
> > -     if (!kasan_arch_is_ready() || is_kfence_address(object))
> > +     if (is_kfence_address(object))
> >               return false;
> >
> >       poison_slab_object(cache, object, init, still_accessible);
> > @@ -282,9 +291,6 @@ bool __kasan_slab_free(struct kmem_cache *cache, vo=
id *object, bool init,
> >
> >  static inline bool check_page_allocation(void *ptr, unsigned long ip)
> >  {
> > -     if (!kasan_arch_is_ready())
> > -             return false;
> > -
>
>
> Well, you can't do this yet, because no arch using ARCH_DEFER_KASAN yet, =
so this breaks
> bisectability.
> Leave it, and remove with separate patch only when there are no users lef=
t.

Will do in v5 at the end of patch series.

>
> >       if (ptr !=3D page_address(virt_to_head_page(ptr))) {
> >               kasan_report_invalid_free(ptr, ip, KASAN_REPORT_INVALID_F=
REE);
> >               return true;
> > @@ -511,7 +517,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsig=
ned long ip)
> >               return true;
> >       }
> >
> > -     if (is_kfence_address(ptr) || !kasan_arch_is_ready())
> > +     if (is_kfence_address(ptr))
> >               return true;
> >
> >       slab =3D folio_slab(folio);
>
>


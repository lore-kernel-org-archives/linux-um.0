Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9821DC83F1A
	for <linux-um@archiver.kernel.org>; Tue, 22 Jul 2025 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z72Y4lywtzmWJK50j4gaS5KcylDNvYHYQchCkK6Shzo=; b=g7NCC/k3/yjDi+xmP5g39p0K9Z
	dGKIoI8jIlUkbEuWgM8+QrW01mJ4cTTh3kg8hqOMV+KrNuCWu8haEEnkPz0p1kc1oxmrL8eyEddbP
	oyNx/5ZmWL95ZPfsCkC9pBowjBDcAWnBx7dJYLgCF565xwo3F/SXX68plOXiay4ZpgxWLpvwBvc1/
	KxqBRJZrQg/Y3TcyNDaXpZOnMb6J8P6J7cZurL6jFsLTz2KcQ9TD7NLwX3WSb0NWFHQe2mOslSNZ0
	5Uv5sE099DWiD88KQxeZZU4lzpEcMS1AzFat2mzOTCfmkkAk8mfev1t86W96w3CarHvUGBvkNiKXL
	3PTepBnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueEtX-00000002rz3-3oAm;
	Tue, 22 Jul 2025 15:27:07 +0000
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueDgN-00000002e3u-2Y61;
	Tue, 22 Jul 2025 14:09:28 +0000
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-32f2947ab0cso44727001fa.2;
        Tue, 22 Jul 2025 07:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753193365; x=1753798165; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z72Y4lywtzmWJK50j4gaS5KcylDNvYHYQchCkK6Shzo=;
        b=IMXVwYIYrkwdyu2y47D5t2AxLuWJQfcOr/4bLb7pnRYfN/cyA/VwqfOYqr9Dm6gfF/
         fghd56bHfKaWmLM52LCwpjjCPIYXqZ12np0awmCLsWZohthEojkfP/o1jMqUZNrrV73Z
         XPaeQVbfkcVDUTa7xP4WUWbWua2LoW7o8glluCbevpnmT96QkczNzfiIYJLY5tKJVm/D
         C45EriTAsvjBUEQA5tZe6VhYFpmGICvt+CtZdsxQ50IGjZEwt5AWO/FsNBQ8NnrJ461l
         V/OlgL406Q1W4lrWKp2lnxvT8xDg/EtY4J5jVzEkapAFWBmBFuIN0zv1QKAIsvQ40RIh
         /Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753193365; x=1753798165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z72Y4lywtzmWJK50j4gaS5KcylDNvYHYQchCkK6Shzo=;
        b=qFc7n6P8gZFr6BkmR56GdPQ5LsO5fBdVSIiJbd+50E1BZt4qRSn+3pU7lUhALVyb0D
         begTHzKr6fRB1qDwUxGh1TyuyF6TX4fxbdphI+cR3kv3ywjeXNbygjr9P8EEc351Rdi/
         jePFjUcfm43k+zv9jrAnA6fHAOTSyjZua0iik3vfwrtG9U/FzfYRYArC0oOrgJJyEUFL
         ITKqRlCBCKgr5dbII3pmpWz70GJFlADlLDSgdtsBAOPpkKvsmilEjcTOE0SHElyLpptM
         alohc4SfgxesYQ6Mh3IUjPEU7zLCrExhy9Hvke/PudH8KjH6bW7+3XmUsv20ykDzebuy
         DB3g==
X-Forwarded-Encrypted: i=1; AJvYcCVDZfZBH6heBYN3n0wBbRHOIcVuofFSgOTgQL212XBzPCeyzSTiQ8nVmgk9JY+t8BXhKXFWUyVwvi4=@lists.infradead.org, AJvYcCX3dlLXdXS8JGAMxjJ4iJhUnTClTKSPrrL0mBV8olo7SM74ctbfVrv560w/uYXWE2BJcA1+QRjbOGyzzw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyqGmOM9M/lBXcCRYthnUC0wCLkzTATeMQah2BNZnYzFy2jKyzp
	dc0jiTGtE0dUeu0lvFJXsrOulWRi/Qavc47ICoqvJngC7OvysCMAaGrPHjqVUUa4y/nyaENc+6R
	34lyXnTpDO5U25/3wfQuI7klnpaUsvQE=
X-Gm-Gg: ASbGnctkyzzDDC2TJ6nU51aukkk7lHAQpKhy0wOr/hW9+Cuh4AiyGFBjjyaNVW+hj3o
	SJHgt68IxWEEu3lXD+07sDn1+HTxNxUrDalzwXEUp4wCJ91DbLiCKXsAIhcp0NQRzuvh811z7Dl
	21NR5aLVD6/RT0J450EpAv12vMLbuH9ym3wd1V5H2N2WjKDJGMLZ0IQWx8ZE927wLWV6pj1P1+x
	OcYzmA=
X-Google-Smtp-Source: AGHT+IHxVK00NMC1GHSpVq/sT2EfSuq7omX6wX24xSvgGhrc9yg0F8isqB5neLuF1et0yPorDOiVEfN1u9rtptu/xSU=
X-Received: by 2002:a05:651c:4110:b0:32a:885b:d0f with SMTP id
 38308e7fff4ca-3308f5e2852mr36383791fa.24.1753193364861; Tue, 22 Jul 2025
 07:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250717142732.292822-1-snovitoll@gmail.com> <20250717142732.292822-8-snovitoll@gmail.com>
 <c8b0be89-6c89-46ed-87c3-8905b6ccbbeb@gmail.com>
In-Reply-To: <c8b0be89-6c89-46ed-87c3-8905b6ccbbeb@gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Tue, 22 Jul 2025 19:09:07 +0500
X-Gm-Features: Ac12FXxpDsEYsUfFuRK9xdlLStcuqGTW4Nrf9JrgjFdTiyEs4CW8gE7SGsQYdo4
Message-ID: <CACzwLxgjKz-bc1w4SvGu-EeoMvK9Dh=2WpB-A_zC-u7H38QqVg@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] kasan/loongarch: select ARCH_DEFER_KASAN and
 call kasan_init_generic
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
X-CRM114-CacheID: sfid-20250722_070927_649473_E47231C3 
X-CRM114-Status: GOOD (  12.75  )
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
>
> > diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/includ=
e/asm/kasan.h
> > index 62f139a9c87..0e50e5b5e05 100644
> > --- a/arch/loongarch/include/asm/kasan.h
> > +++ b/arch/loongarch/include/asm/kasan.h
> > @@ -66,7 +66,6 @@
> >  #define XKPRANGE_WC_SHADOW_OFFSET    (KASAN_SHADOW_START + XKPRANGE_WC=
_KASAN_OFFSET)
> >  #define XKVRANGE_VC_SHADOW_OFFSET    (KASAN_SHADOW_START + XKVRANGE_VC=
_KASAN_OFFSET)
> >
> > -extern bool kasan_early_stage;
> >  extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
> >
> >  #define kasan_mem_to_shadow kasan_mem_to_shadow
> > @@ -75,12 +74,6 @@ void *kasan_mem_to_shadow(const void *addr);
> >  #define kasan_shadow_to_mem kasan_shadow_to_mem
> >  const void *kasan_shadow_to_mem(const void *shadow_addr);
> >
> > -#define kasan_arch_is_ready kasan_arch_is_ready
> > -static __always_inline bool kasan_arch_is_ready(void)
> > -{
> > -     return !kasan_early_stage;
> > -}
> > -
> >  #define addr_has_metadata addr_has_metadata
> >  static __always_inline bool addr_has_metadata(const void *addr)
> >  {
> > diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_i=
nit.c
> > index d2681272d8f..cf8315f9119 100644
> > --- a/arch/loongarch/mm/kasan_init.c
> > +++ b/arch/loongarch/mm/kasan_init.c
> > @@ -40,11 +40,9 @@ static pgd_t kasan_pg_dir[PTRS_PER_PGD] __initdata _=
_aligned(PAGE_SIZE);
> >  #define __pte_none(early, pte) (early ? pte_none(pte) : \
> >  ((pte_val(pte) & _PFN_MASK) =3D=3D (unsigned long)__pa(kasan_early_sha=
dow_page)))
> >
> > -bool kasan_early_stage =3D true;
> > -
> >  void *kasan_mem_to_shadow(const void *addr)
> >  {
> > -     if (!kasan_arch_is_ready()) {
> > +     if (!kasan_enabled()) {
>
> This doesn't make sense, !kasan_enabled() is compile-time check which is =
always false here.

I should've used `!kasan_shadow_initialized()` check here which provides
the needed runtime behavior that kasan_early_stage used to provide.
Will do in v4. Thanks!

>
> >               return (void *)(kasan_early_shadow_page);
> >       } else {
> >               unsigned long maddr =3D (unsigned long)addr;


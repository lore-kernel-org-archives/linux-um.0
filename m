Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD74C87FD1
	for <linux-um@archiver.kernel.org>; Wed,  6 Aug 2025 04:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qo/Viw2qcvpv/MoBS3iI99BxX9ghV/qd2Tz3ezwRf/E=; b=3NlP5GIT1EmVEbInd9q8/3A9mM
	VC8UEjq2VOWE74BqkHowfHTLxw738uiUNWut6QdPIr1naZEnoRifLINqp7ADQVYNt2a9UahQ8tSR8
	me9JWzLkHyxi809vwjomtIrBNMfPNTWRnd8areXNmiSG6OYG9MWJeJtWiW1wBv7uDQUaYspVYomTu
	wivhyo3WZB5kWoyrfUx9HrxUJAVY6pMAxBBNqmmRlhnBL96sg/33v1CJAi0dYvRjECL2bNdKwNlPM
	YN4s+DcgDPikCEHQ9Mcc/oVFqPehOa0txwCdgeaCJEj5v2DwDl6k97OhY+7VK9j5gVr1s0LyDdlZA
	zzYM4XvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujVuZ-0000000EHXu-2gjc;
	Wed, 06 Aug 2025 04:37:59 +0000
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujVuX-0000000EHX7-0HbP;
	Wed, 06 Aug 2025 04:37:58 +0000
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-3322d10e29dso49261491fa.0;
        Tue, 05 Aug 2025 21:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754455075; x=1755059875; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qo/Viw2qcvpv/MoBS3iI99BxX9ghV/qd2Tz3ezwRf/E=;
        b=fEPr+KklbaVqmGD/iB2VwNt3iI0lMMq+izqaT/aW3kFY4Hu9iEtNTVUYSm5e/401xZ
         iTJbRfzLwmD19mEjNEQ0L1NWS831sIcGaXoU52ZKPQ6SnxnFgxSUuhYX/j23DrbjJr91
         UyFWsACGoOd6SIw71d37ZBE6nbzpbjlZNSN7SIwwDyC0nz3DMdxXK1xyhh6wylmshNZD
         xjtaVXfvoPlsdbRgZK9to4atQD1aZX0O+U3hZIuak/aultYZeqo20aTUBmOpibWjctum
         Hssg64TBHxGBtCmvux1xNImgu6NHRQKPeQQcZMDgREdO3awSlq7cU1FAsw48yz9LCh0V
         Ii5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754455075; x=1755059875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qo/Viw2qcvpv/MoBS3iI99BxX9ghV/qd2Tz3ezwRf/E=;
        b=lzC7suVaSuaOWhsWbvWAMtzbt2qFKZ9qrfGne1V56j7KdXsMcfm1q0MtA7x1YEs3Rv
         5PQQPxkLehTfQIFFROfxK8xnt0tcuCkDnOQAHF6v4ClKsk3mLndVJc7fsxilTqv8FZQQ
         SinmqFcxf9DXiPHHeh3MGVPMP/YIRvLksZ3ps14C3NFzUTEaaYlwOGF10PqZaNiebK69
         qgG0AX8gTH6WiBuUqnnQUpDQHhRt2M1JV7NGtsb35MqxKfuBqN547OuBCuk9y6jl2BeC
         ShJ725ZHuvSGsafHAtRHSzO9T8/L53vnjxDPpXfzisLG0AiryqZAFm+rAfRgGYFmOfsj
         yl6A==
X-Forwarded-Encrypted: i=1; AJvYcCWCkCgFl5NOhXWitD0ozJu+qvXe1T23hY3sBecWwypbdHH6liPoAumB3DvCrkJxfGqdaoV62C1DenTv2Q==@lists.infradead.org, AJvYcCXAzxleQAAUpTPTGlcdLdrZdNmbllj142Uuknr1DdqWolvz5+t0nOiSfAkA3wXGu1bM0ykxceC57kw=@lists.infradead.org
X-Gm-Message-State: AOJu0YwunUETpsVPBTqimVe2VEOyg/oQCoG6Ovhh4RwDxPOaMcSJngRl
	VPJePye8Ry2ULqpKvrpWRPI0hnHXvdHV0i6M1EmKIBBcXVysJNTKUcSHJ05HbRuthBet95ApUw9
	+iwWgvRvtlwtvnSB44rOrGvgTrgDmEW0=
X-Gm-Gg: ASbGncvUgmysJhIFKkGrqheRVwkrt8NgIH62lf7T1alpq466WAdjX77o12BK10FOQlQ
	eE8alyBPf+5P47Ma3vbHMs85Ufu6FVpVveYpV2RCaXvQEo+M3RlrcznADtYagHNbsvGoNP1A2rR
	5f3NFmSdkXFD/pkNF+EC8lk7wyfdQCoYZ2EIkz0XrGiu9Ue4CrFeKHTvQ6MpPNtiKcX6AarRykl
	7w9tIQ=
X-Google-Smtp-Source: AGHT+IFdsEW+IENwPRijll82h/DPiknLKACQZ/o9KWIJ/PhoBk1+OGng4Q7CbEgSQ8dHEzo+wdS/ckXYJp2kTJF5j88=
X-Received: by 2002:a05:651c:1509:b0:32a:739d:fac with SMTP id
 38308e7fff4ca-3338144cd8fmr3796161fa.36.1754455075078; Tue, 05 Aug 2025
 21:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250805142622.560992-1-snovitoll@gmail.com> <20250805142622.560992-6-snovitoll@gmail.com>
 <e15e1012-566f-45a7-81d5-fd504af780da@gmail.com>
In-Reply-To: <e15e1012-566f-45a7-81d5-fd504af780da@gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 6 Aug 2025 09:37:38 +0500
X-Gm-Features: Ac12FXyJN7pElMlaw_o-aZoTkQ3byDjTMvUiVf1-1J0u8uF_nrAwTbgiBAXxjhE
Message-ID: <CACzwLxj0nOQT0+Z+AFDG3Cvun5jGaET6C3mp9PnLbCHjdw51Pg@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] kasan/loongarch: select ARCH_DEFER_KASAN and call kasan_init_generic
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
X-CRM114-CacheID: sfid-20250805_213757_110426_57F4DC3C 
X-CRM114-Status: GOOD (  29.18  )
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

On Tue, Aug 5, 2025 at 10:18=E2=80=AFPM Andrey Ryabinin <ryabinin.a.a@gmail=
.com> wrote:
>
>
>
> On 8/5/25 4:26 PM, Sabyrzhan Tasbolatov wrote:
> > LoongArch needs deferred KASAN initialization as it has a custom
> > kasan_arch_is_ready() implementation that tracks shadow memory
> > readiness via the kasan_early_stage flag.
> >
> > Select ARCH_DEFER_KASAN to enable the unified static key mechanism
> > for runtime KASAN control. Call kasan_init_generic() which handles
> > Generic KASAN initialization and enables the static key.
> >
> > Replace kasan_arch_is_ready() with kasan_enabled() and delete the
> > flag kasan_early_stage in favor of the unified kasan_enabled()
> > interface.
> >
> > Note that init_task.kasan_depth =3D 0 is called after kasan_init_generi=
c(),
> > which is different than in other arch kasan_init(). This is left
> > unchanged as it cannot be tested.
> >
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217049
> > Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> > ---
> > Changes in v4:
> > - Replaced !kasan_enabled() with !kasan_shadow_initialized() in
> >   loongarch which selects ARCH_DEFER_KASAN (Andrey Ryabinin)
> > ---
> >  arch/loongarch/Kconfig             | 1 +
> >  arch/loongarch/include/asm/kasan.h | 7 -------
> >  arch/loongarch/mm/kasan_init.c     | 8 ++------
> >  3 files changed, 3 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index f0abc38c40a..f6304c073ec 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -9,6 +9,7 @@ config LOONGARCH
> >       select ACPI_PPTT if ACPI
> >       select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
> >       select ARCH_BINFMT_ELF_STATE
> > +     select ARCH_DEFER_KASAN
> >       select ARCH_DISABLE_KASAN_INLINE
> >       select ARCH_ENABLE_MEMORY_HOTPLUG
> >       select ARCH_ENABLE_MEMORY_HOTREMOVE
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
> > index d2681272d8f..57fb6e98376 100644
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
> > +     if (!kasan_shadow_initialized()) {
> >               return (void *)(kasan_early_shadow_page);
> >       } else {
> >               unsigned long maddr =3D (unsigned long)addr;
> > @@ -298,8 +296,6 @@ void __init kasan_init(void)
> >       kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_S=
TART),
> >                                       kasan_mem_to_shadow((void *)KFENC=
E_AREA_END));
> >
> > -     kasan_early_stage =3D false;
> > -
>
> There is a reason for this line to be here.
> Your patch will change the result of the follow up kasan_mem_to_shadow() =
call and
> feed the wrong address to kasan_map_populate()

Thanks, I've missed it. Here the upcoming v5 for this:

diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.=
c
index d2681272d8f..0e6622b57ce 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -40,11 +40,9 @@ static pgd_t kasan_pg_dir[PTRS_PER_PGD] __initdata
__aligned(PAGE_SIZE);
#define __pte_none(early, pte) (early ? pte_none(pte) : \
((pte_val(pte) & _PFN_MASK) =3D=3D (unsigned long)__pa(kasan_early_shadow_p=
age)))
-bool kasan_early_stage =3D true;
-
void *kasan_mem_to_shadow(const void *addr)
{
- if (!kasan_arch_is_ready()) {
+ if (!kasan_shadow_initialized()) {
return (void *)(kasan_early_shadow_page);
} else {
unsigned long maddr =3D (unsigned long)addr;
@@ -298,7 +296,10 @@ void __init kasan_init(void)
kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
kasan_mem_to_shadow((void *)KFENCE_AREA_END));
- kasan_early_stage =3D false;
+ /* Enable KASAN here before kasan_mem_to_shadow() which checks
+ * if kasan_shadow_initialized().
+ */
+ kasan_init_generic();
/* Populate the linear mapping */
for_each_mem_range(i, &pa_start, &pa_end) {
@@ -329,5 +330,4 @@ void __init kasan_init(void)
/* At this point kasan is fully initialized. Enable error messages */
init_task.kasan_depth =3D 0;
- pr_info("KernelAddressSanitizer initialized.\n");
}
--=20
2.34.1

>
>
> >       /* Populate the linear mapping */
> >       for_each_mem_range(i, &pa_start, &pa_end) {
> >               void *start =3D (void *)phys_to_virt(pa_start);
> > @@ -329,5 +325,5 @@ void __init kasan_init(void)
> >
> >       /* At this point kasan is fully initialized. Enable error message=
s */
> >       init_task.kasan_depth =3D 0;
> > -     pr_info("KernelAddressSanitizer initialized.\n");
> > +     kasan_init_generic();
> >  }
>


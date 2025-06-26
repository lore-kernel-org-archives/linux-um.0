Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D8AC7EE30
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zlpUNKK3G9db+EdwcDWwBbzYx+1GRPZcFPyn0Q/NIe0=; b=z7qw0CUYjNxtqmcezQFMjG9E3m
	EVI8q9vC7DZ3oVJgpdhNlXPjmtacvJHo97F9Poj6Jea7uj3duTOuUmwwp01OvTyfBRlu7tXlz9yJJ
	Xes28eBd5vHVJ07xH/OfElKHANvKuMzLPP1yIP3KoJswXDYY3SYZ+pvGVjN5ZNjiD2n6Eou/DPmIp
	Kj/IryPBezDWNX0Jcp5ei2AyP/b9UH25Anwd9P1xGphGtlytpCeGhhqLyfIvos/EEkzCPQ9OAKyGj
	hjOhEqYiW92c5TvlSrvZOs0cx2Zo2MITwk5LTuaqSaZU2TWfSewKEZQsdj3l0HNt2/69RWIY29gdY
	X5o293Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUn4k-0000000BnkY-3wQv;
	Thu, 26 Jun 2025 13:55:38 +0000
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUn2Q-0000000BlNR-24Bh;
	Thu, 26 Jun 2025 13:53:15 +0000
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-32adebb15c5so7869121fa.3;
        Thu, 26 Jun 2025 06:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750945992; x=1751550792; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlpUNKK3G9db+EdwcDWwBbzYx+1GRPZcFPyn0Q/NIe0=;
        b=eBBZ9ri6i5I/sW0sY881Hkm1BN0W9u07vdHq+Z8xgPmXmD1skr7+D2Vf0U7PqdTvMo
         83O/p9y+tPG9oTeUhkyuA6QCbxm9296ph8l0r1C9kunn4zgqSmbrcLLy99Dip0KYz5f1
         TKuxPvEG6DkHfBRE7WTKZYMGRhkVc+BIbf2k7AHxpS2iu+LFnY46lKniQuh68XBzCxyG
         xF8Q0yhlPzDBXP/y7ZVXQM9Z7pXOFC0JExPdPDHnHXZo1zbVjNm1KKDAJ7aZhXvLr1Sa
         fZWrvmzVLsMW7dgU7jTRIMKafnSjf0jhi4sekJoEh+J0NF+EM+v/jjjjUrrc1CDwjuAv
         fA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750945992; x=1751550792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlpUNKK3G9db+EdwcDWwBbzYx+1GRPZcFPyn0Q/NIe0=;
        b=VNlbwjcrO8kpNgYuUiW0FHCJhLX/XkI5YslqhHnBLZEbXj+Vq7uhk37Q7RWxNlZE2e
         WyG/mDW2MWWGWOtkOonPzEKI5lNlqZ0hckOF/n1W9zmpVJrEK7UB670nP3jpXImn5EK1
         PYz89cBYLWW5Ta3e8FyCFkBgs+3DD3hW2LVqJydrbMzR9slGIPOrOkLa0BPCHzKb53B1
         h9Do1ZTcvdMYr/12kDhYzfB47HP+Y/Rf+xMTG16R6DusoMnSSK9KXD0I+pwoARCxCy8e
         E1fKJZ8aQRd8PsA/CX8ucMtetsgAu8PjADwXGEnjH0ZwA0nk0eJmuqWjStZ0wgFnpS3i
         Qo4w==
X-Forwarded-Encrypted: i=1; AJvYcCUI9hYjkQQ449Y1Go0B1r9arND/TL50Jh1D6BNYyRyDPe3U9RTgTMF5fciAwuUS1qd44X9UFZhaVW2Xudd8IQZZ@lists.infradead.org, AJvYcCXNfaPjzDBX8VaAJXCJsJPvT/edUBplb3hw0/G2m8G/TrUwGX9UX+jlLyyyBtAIPmJET6bW62cupIY=@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3aV5mdj2BmSTVSQ6kvitSEN5qQb7h9qCnnmALOyiddabQPUdJ
	rVKqeWroIw8Qly20D7VyPByRAisO1KVfVyR1ecNA23d8WSGCuwsU6lWm1EhrAGREXj7nnm1RBMA
	2w2BQS0fUUr7ERE7x1yAVRMBF2f+BSys=
X-Gm-Gg: ASbGnctoDAwgAEUaP23aCEQvQY/CEeLlepUyi9WQByjOnONo1DE4nppOiFhwWA85jVs
	glpSoGj9NhjJP9kTMxUyn/5aZ0jzL/QI97WNwfp7MWsYCEWVbkOG8gqRuGEm3oe50OTEOM6ku2M
	0i2rihNl+kl3Ag/MoY36hnYwCjWwDRUBY/qWgUewMSrA==
X-Google-Smtp-Source: AGHT+IFp5i/0Kq3rabH9rf2kY42MbESDKtULRW6uJMn5QRZ8/Z9H2i8ntSIcRhBigiGO2NXAKYlXjXFM6g03B8Baa18=
X-Received: by 2002:a05:651c:f0b:b0:32b:7284:88 with SMTP id
 38308e7fff4ca-32cc6497155mr12421921fa.7.1750945991880; Thu, 26 Jun 2025
 06:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250625095224.118679-1-snovitoll@gmail.com> <20250625095224.118679-6-snovitoll@gmail.com>
 <20250626132943.GJ1613200@noisy.programming.kicks-ass.net>
In-Reply-To: <20250626132943.GJ1613200@noisy.programming.kicks-ass.net>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Thu, 26 Jun 2025 18:52:53 +0500
X-Gm-Features: Ac12FXynXHan9NKB65s06xjAcLer_ajNs_gE1LBlTEt_pC6nGG6YTexJKgab6gM
Message-ID: <CACzwLxj3WLTK+A7YLcYvg5ZwvQdvoBuZL3bmEF+ELinFZgU=Pg@mail.gmail.com>
Subject: Re: [PATCH 5/9] kasan/loongarch: call kasan_init_generic in kasan_init
To: Peter Zijlstra <peterz@infradead.org>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	chris@zankel.net, jcmvbkbc@gmail.com, akpm@linux-foundation.org, 
	guoweikang.kernel@gmail.com, geert@linux-m68k.org, rppt@kernel.org, 
	tiwei.btw@antgroup.com, richard.weiyang@gmail.com, benjamin.berg@intel.com, 
	kevin.brodsky@arm.com, kasan-dev@googlegroups.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_065314_537084_F58A8FD0 
X-CRM114-Status: GOOD (  26.06  )
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

On Thu, Jun 26, 2025 at 6:29=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Jun 25, 2025 at 02:52:20PM +0500, Sabyrzhan Tasbolatov wrote:
> > Call kasan_init_generic() which enables the static flag
> > to mark generic KASAN initialized, otherwise it's an inline stub.
> >
> > Replace `kasan_arch_is_ready` with `kasan_enabled`.
> > Delete the flag `kasan_early_stage` in favor of the global static key
> > enabled via kasan_enabled().
> >
> > printk banner is printed earlier right where `kasan_early_stage`
> > was flipped, just to keep the same flow.
> >
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218315
> > Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> > ---
> >  arch/loongarch/include/asm/kasan.h | 7 -------
> >  arch/loongarch/mm/kasan_init.c     | 7 ++-----
> >  2 files changed, 2 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/includ=
e/asm/kasan.h
> > index 7f52bd31b9d..b0b74871257 100644
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
> >               return (void *)(kasan_early_shadow_page);
> >       } else {
> >               unsigned long maddr =3D (unsigned long)addr;
> > @@ -298,7 +296,7 @@ void __init kasan_init(void)
> >       kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_S=
TART),
> >                                       kasan_mem_to_shadow((void *)KFENC=
E_AREA_END));
> >
> > -     kasan_early_stage =3D false;
> > +     kasan_init_generic();
> >
> >       /* Populate the linear mapping */
> >       for_each_mem_range(i, &pa_start, &pa_end) {
> > @@ -329,5 +327,4 @@ void __init kasan_init(void)
> >
> >       /* At this point kasan is fully initialized. Enable error message=
s */
> >       init_task.kasan_depth =3D 0;
> > -     pr_info("KernelAddressSanitizer initialized.\n");
> >  }
>
> This one is weird because its the only arch that does things after
> marking early_state false.
>
> Is that really correct, or should kasan_init_generic() be last, like all
> the other architectures?

It really differs from other arch kasan_init(). I can't verify that
kasan_init_generic()
can be placed at the end of kasan_init() because right after
switching the KASAN flag, there's kasan_enabled() check in
kasan_mem_to_shadow().

In arch/loongarch/mm/kasan_init.c:

void *kasan_mem_to_shadow(const void *addr)
{
        if (!kasan_enabled()) {
                return (void *)(kasan_early_shadow_page);
        } else {
...
}

void __init kasan_init(void)
{
...
        kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_STA=
RT),
        kasan_mem_to_shadow((void *)KFENCE_AREA_END));

        kasan_init_generic();

        /* Populate the linear mapping */
        for_each_mem_range(i, &pa_start, &pa_end) {
....
        kasan_map_populate((unsigned long)kasan_mem_to_shadow(start),
}

>
> Also, please move init_task.kasan_depth =3D 0 into the generic thing.
> ARM64 might have fooled you with the wrapper function, but they all do
> this right before that pr_info you're taking out.

Please check "[PATCH 1/9] kasan: unify static kasan_flag_enabled across mod=
es",
where I've replied to Christophe:
https://lore.kernel.org/all/CACzwLxj3KWdy-mBu-te1OFf2FZ8eTp5CieYswF5NVY4qPW=
D93Q@mail.gmail.com/

I can try to put `init_task.kasan_depth =3D 0;` in kasan_init_generic(),
but in ARM64 kasan_init() we'll still need to have this line for
HW_TAGS, SW_TAGS mode.


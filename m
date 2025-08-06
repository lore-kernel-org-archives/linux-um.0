Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442F9C87FCA
	for <linux-um@archiver.kernel.org>; Wed,  6 Aug 2025 04:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dyl+4iOlTi/aeKebUp39F24cwHyqM1kxjjt1F2AMIE8=; b=IEGRYYYGAXqEfCk47+VLUJfmz5
	M3/m7TNPxkOaAwkn84AmsilSQ1jqT+kLEIe8HTCcjPpPPxOCVAnjv4KugsZb6gMLyM3Ci+pPPq3V7
	mD8ZdSawtuLLrtV/EUEmivOzFtjLS0dOMhuAtgDkFzadHYmwG290J7+GG4Skt1Z/wUGzmG/AoyNDa
	YXc+GtnDspZqL//w9kHVgmVaLokWeIsBL2hx8H2TuZ8LSQmVGUgbZEckleJ10/Dun4VLPaiG9BIQZ
	RS8us1p2DgNlD38cg230DXVOOWtccq137E3D4bdaFjMWGzDncwzgE7T8uE5oO+LFpwh3lCKLxb8eK
	+ovP7zBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujVse-0000000EHLE-2jZK;
	Wed, 06 Aug 2025 04:36:00 +0000
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujVsb-0000000EHKj-1RbL;
	Wed, 06 Aug 2025 04:35:58 +0000
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-332559ace6eso38270441fa.1;
        Tue, 05 Aug 2025 21:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754454955; x=1755059755; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyl+4iOlTi/aeKebUp39F24cwHyqM1kxjjt1F2AMIE8=;
        b=E6sd8qNKvd2Xzebrv6Q9NrPUKkMzFOEEdBNeawH/y2CxdFB0QBqxlA0o0NUiNh0kQw
         3qQ5S+FNXZoyV3XJTzaABqAvnwSKxWQ9BHyfsUdwse836fKrRNI3VJjMG9iFLM06kAjN
         pCr3g+cYtMLdZI01JpkUw37cbwoZpuqSvHgldvfimjpU/driFyYXE3GXjSUGJduD584N
         P3baPiDhcTSJhphQUJajfYRltZzGZPH0bN2zaCSRFKRwicZVXWWIvfE1CXwu0UtHMaVn
         RKuoLnVWB5hM72I4NlMbmP65fLQ6pLfT+SSD4d7DwpHlTkohtXG2vl/ywW0alBT8Vjph
         9J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754454955; x=1755059755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyl+4iOlTi/aeKebUp39F24cwHyqM1kxjjt1F2AMIE8=;
        b=KYtEVc1tETU1H8BoMLb/7T5ug27xxzCOcdwPDjGgC7cwygBG/JW1ld8Mnzfd74VQEx
         mOJvH3CX3Ha3wRkvu7voO4hXHNmGqRAijqdz0kity5TnmoNWeD7ftAkbZYUhU/oq0Hog
         vRphecWYTcuHGGKZbJ0auyTvhIgsZsSGek1abpRvIHfhi/9LOF9BTQvkAVRVpwEQT5pV
         BRe06OD6JqnvJ9SQWIaUBDxKHJnPe6h/nL9kyUigWdkKmJCfd1HLV/Siewz3YFtJnMju
         NksaXXxnZQk5oc0F55S0odB4IM8rBY+E+9G/3fWgfMgSPSwvHfJNyouzVQb7vkqU6OCZ
         VzUw==
X-Forwarded-Encrypted: i=1; AJvYcCU7bEnqFyXRmIlrFD+9hoDiV0J/Eateid0bOIP2WU1gDvSiLKB92jTB7w5DiasJQ6U7I2oLvWQ4ABs=@lists.infradead.org, AJvYcCWm99J8yBoiFB37UrJi2sNTR5OLPAaFjvyTN9R5ThFqU0tQnOXskEjEaNKNR8sa9iE8JEWbNxhQo+QXzA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxsYNgOoQE877T0qIfNYBiWqoirM6n/WFORM3Q6XVm+b3rLLgyE
	hwbqeQHZ/DTy4/8f96QN4UCMJo20R7C6K7SPMARdaqYvd4FD903sAyRIbOnjMPOPnNcuyf+BW+d
	x2Ffgf6GNPUyL4wNFlfPOKM7hXx+1JZY=
X-Gm-Gg: ASbGncuw1261ucsDyfNRF4Ocp/wyhO9oh8jfhq7/or69bT+Pm4PGXoq8Bh6FPabcb/r
	f/7Hq2WuefBSWhG7/kV4jZ2EcnjAdiq0t9ykKEgMf8lyxiioDERV9z9PYI4IIqgBFJn6XlVvj6N
	17r52zO4tnWOrkLVcC0+H/bz+n9QEaMOY7e1TFsBeEMUdTjNSX8ShCHfJp019EYS6OTEEXbUhf/
	kPQ1lc=
X-Google-Smtp-Source: AGHT+IELREFbM69cWDMgkv0oAyeZWfUsogtR626ngafWyGyn4A7prZJUgwVT4kX8m1x5U9hUnIU0ztH0bEfAmGCquxc=
X-Received: by 2002:a05:651c:f0e:b0:32c:e253:20cc with SMTP id
 38308e7fff4ca-3338128c651mr2551171fa.11.1754454955157; Tue, 05 Aug 2025
 21:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250805142622.560992-1-snovitoll@gmail.com> <20250805142622.560992-7-snovitoll@gmail.com>
 <60895f3d-abe2-4fc3-afc3-176a188f06d4@gmail.com>
In-Reply-To: <60895f3d-abe2-4fc3-afc3-176a188f06d4@gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 6 Aug 2025 09:35:38 +0500
X-Gm-Features: Ac12FXwBfBQD8yoFidSr60fw7LigvE8ZBweRU29uoAzLmmdybvheO1FdbNA_5DM
Message-ID: <CACzwLxhs+Rt9-q6tKi3Kvu7HpZ2VgZAc4XEXZ4MEB60UbFjDKg@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] kasan/um: select ARCH_DEFER_KASAN and call kasan_init_generic
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
X-CRM114-CacheID: sfid-20250805_213557_384138_2141A784 
X-CRM114-Status: GOOD (  14.68  )
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

On Tue, Aug 5, 2025 at 10:19=E2=80=AFPM Andrey Ryabinin <ryabinin.a.a@gmail=
.com> wrote:
>
>
>
> On 8/5/25 4:26 PM, Sabyrzhan Tasbolatov wrote:
> >
> > diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> > index 9083bfdb773..8d14c8fc2cd 100644
> > --- a/arch/um/Kconfig
> > +++ b/arch/um/Kconfig
> > @@ -5,6 +5,7 @@ menu "UML-specific options"
> >  config UML
> >       bool
> >       default y
> > +     select ARCH_DEFER_KASAN
>
> select ARCH_DEFER_KASAN if STATIC_LINK

As pointed out in commit 5b301409e8bc("UML: add support for KASAN
under x86_64"),

: Also note that, while UML supports both KASAN in inline mode
(CONFIG_KASAN_INLINE)
: and static linking (CONFIG_STATIC_LINK), it does not support both at
the same time.

I've tested that for UML,
ARCH_DEFER_KASAN works if STATIC_LINK && KASAN_OUTLINE
ARCH_DEFER_KASAN works if KASAN_INLINE && !STATIC_LINK

ARCH_DEFER_KASAN if STATIC_LINK, and KASAN_INLINE=3Dy by default from defco=
nfig
crashes with SEGFAULT here (I didn't understand what it is, I think
the main() constructors
is not prepared in UML):

 =E2=96=BA 0       0x609d6f87 strlen+43
   1       0x60a20db0 _dl_new_object+48
   2       0x60a24627 _dl_non_dynamic_init+103
   3       0x60a25f9a __libc_init_first+42
   4       0x609eb6b2 __libc_start_main_impl+2434
   5       0x6004a025 _start+37

Since this is the case only for UML, AFAIU, I don't think we want to change
conditions in lib/Kconfig.kasan. Shall I leave UML Kconfig as it is? e.g.

select ARCH_DEFER_KASAN

>
> >       select ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >       select ARCH_HAS_CACHE_LINE_SIZE
> >       select ARCH_HAS_CPU_FINALIZE_INIT
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


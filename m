Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61A6CCD184
	for <linux-um@archiver.kernel.org>; Thu,  9 Oct 2025 15:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WQBxmURKiGaN3QIqBhTff7pEbZ70mJ9TllMgftPCUcQ=; b=qZNfJ79vQ164coYUdzhtZqQoJo
	GPM6ojcGMDncJSPEq5IOO7bFewBcmUZ8Oqs0j6M5ObovYAE+eyE0PGwCOWIv5jb8EUlxolZqweY4q
	2KKy/3RONpeqwbwJ32F9VbY7PtOXHofqo08V1G13MYMzIJDcvR3NgxZIvMuPQmrNXjkUOB9wxDe0q
	A7Zh5a94RLqbEc1KANCmv38wiiC2atlusSCFZmsW/ugLFRnh4Dur5WntOKsZrRAo8aeRpt8uOB0sf
	KxVXGdjkjgGsQmufWnpA80dXOlFqjov8mCh/8ecfEyme7pE7mQm00lPI/PVgduIspnO1MPic8yMZb
	WSojD3tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6t3c-00000006baV-38QW;
	Thu, 09 Oct 2025 15:59:56 +0000
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6t3Y-00000006bUA-1bUV
	for linux-um@lists.infradead.org;
	Thu, 09 Oct 2025 15:59:54 +0000
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-57a604fecb4so1408215e87.1
        for <linux-um@lists.infradead.org>; Thu, 09 Oct 2025 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760025590; x=1760630390; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQBxmURKiGaN3QIqBhTff7pEbZ70mJ9TllMgftPCUcQ=;
        b=cZyEhQhMSD7X3uXeVIKIPHao30plBnq+20CatvCysbsJla9gICClJVAukc93fqDAcf
         EgdiWLujWg2rzz/PqNQUJuZYnV6ecXrhyIBLCVAqLBI8Q5jfnsU1A9abnOIZVoDiq+S+
         nOB6Z/ybvXYNWb5vRoQpvPG4G7z9PYoOuRQiKrvc/bau21EOrvTHQsSfIZ4Oi3+XxM4J
         CW8yF+D9zYUBfS+qSioxRImqOtwafbUsPdFGd9XRZUvKe4FRDq8aXL+QutojSH6319IX
         2xzFAOEjPOfoyIoBfpKz0KjnwWtWh3095e1mS0zRUgjkEvpfVbjGgknfK5hPEa9nro4j
         loiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760025590; x=1760630390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQBxmURKiGaN3QIqBhTff7pEbZ70mJ9TllMgftPCUcQ=;
        b=os+27BxvrDfJHoZS/2XJTFzlRJM4xaIZFLdFW8zLILDMV/qFdwjOJiyNf4FI9QVcJO
         cxZLieoR39M463Z7+PW9s7ARTrbgTsYNOlErX6M9nhqn/mAphEsri3Ef1wix1hvzxSGu
         yIiubtDYZW2Cok5riQPMYhp9BAwdYDqpsXGNWtL/FNYJuGkvIVj0MjLxJWiKchigokyr
         g7+jQPPX1cERRZGmskg5bZvusK5X6pIvbXwsV1eIgX1enYpgI0LLmjIxgRe8YOqhlfwo
         pk9BP8x6sbmkomZuOi60G2DUARU5Q1HxMq/5f4xIl4sp9A0jrbDWmxtyLBH0GVgYOJuE
         PP1g==
X-Forwarded-Encrypted: i=1; AJvYcCV+I0H44Lp26C9RG1ZWbi/FvVdOGHDW4QqNJ6goCR+zzIuOd+sVcQ03eokeZm5G7LeXRZ0sX+S91g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzUNq0HWCI+TIEoQpbgeqZByM+fk4tNS4YHZBTf/dHSvf9cEy8r
	mH7R1WutGORQ/5UcTJa2iZS+78QBP0AkfOyQVjsVcttTEbv3jUYr/c8dbsjq3oJuxY0ijsnQxRt
	4qkHR6zoULjRp0e9a4eBIkz0IRHksQUw=
X-Gm-Gg: ASbGncvswGDCyBfTInovvOTJWR5Dl4smn8MNHhlkJkz1QNc6/owyLMAGJdAxaEMwkuz
	xUd3VDF2Lme/5pTMDJHGh6fhHoo/Bb3ZTdEOekmvPsHJ4w1oLh5+P+Q9UqKRELddN84yLnVWk/p
	bxekbwMBfv4PRZkUCsVZeXFsBj7kxZW6RabDMWIqrIHc85PV1QjeJ6q9OQD53f/Vi22kJvdp/d/
	GQ/EnuskVRhy2IayDw5JeFJKJHSlCI4bkRuIOFp/Q==
X-Google-Smtp-Source: AGHT+IFiOw5ablsLgUKfCaNuQJri4wcztl+zI4ly3LRjrgaXjzgOnqWcpR8ZMzuTHWFg5QDe7h9JoAEutSyQKhvfT4w=
X-Received: by 2002:a05:6512:1291:b0:57d:ffa4:56f4 with SMTP id
 2adb3069b0e04-5906dae5904mr2393608e87.41.1760025589415; Thu, 09 Oct 2025
 08:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250810125746.1105476-1-snovitoll@gmail.com> <20250810125746.1105476-2-snovitoll@gmail.com>
 <87ldmv6p5n.ritesh.list@gmail.com>
In-Reply-To: <87ldmv6p5n.ritesh.list@gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Thu, 9 Oct 2025 20:59:32 +0500
X-Gm-Features: AS18NWAnJdcYDP3fsUmpv8ZuZnvVnkv1zMHsU4QWH3X3orZoE8748Ur0FWZohd0
Message-ID: <CACzwLxia6xMcQ=vsYG7SE+pUO8=4DiRWD_Omq3wzRyuhDjGcPQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: ryabinin.a.a@gmail.com, christophe.leroy@csgroup.eu, bhe@redhat.com, 
	hca@linux.ibm.com, andreyknvl@gmail.com, akpm@linux-foundation.org, 
	zhangqing@loongson.cn, chenhuacai@loongson.cn, davidgow@google.com, 
	glider@google.com, dvyukov@google.com, alexghiti@rivosinc.com, alex@ghiti.fr, 
	agordeev@linux.ibm.com, vincenzo.frascino@arm.com, elver@google.com, 
	kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_085952_439255_80158209 
X-CRM114-Status: GOOD (  15.68  )
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

On Thu, Sep 4, 2025 at 5:38=E2=80=AFAM Ritesh Harjani <ritesh.list@gmail.co=
m> wrote:
>
>
> Only book3s64 needs static keys here because of radix v/s hash mode
> selection during runtime. The changes in above for powerpc looks good to
> me. It's a nice cleanup too.
>

Hello,
Thanks for the review and sorry for the late reply. This has already
been merged.
AFAIU, in arch/powerpc/Kconfig

config PPC
...
        select ARCH_NEEDS_DEFER_KASAN if PPC_RADIX_MMU

and in arch/powerpc/platforms/Kconfig.cputype:

config PPC_RADIX_MMU
        bool "Radix MMU Support"
        depends on PPC_BOOK3S_64
        select ARCH_HAS_GIGANTIC_PAGE
        default y

So the KASAN static key is enabled only for PPC_BOOK3S_64 by this
Kconfig selection.
In other git changes like:
arch/powerpc/mm/kasan/init_32.c
arch/powerpc/mm/kasan/init_book3e_64.c

, where we call kasan_init_generic() -> kasan_enable() does nothing because
CONFIG_ARCH_DEFER_KASAN is not selected.

> So feel free to take:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> #powerpc
>
> However I have few comments below...
>
> > @@ -246,7 +255,7 @@ static inline void poison_slab_object(struct kmem_c=
ache *cache, void *object,
> >  bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
> >                               unsigned long ip)
> >  {
> > -     if (!kasan_arch_is_ready() || is_kfence_address(object))
> > +     if (is_kfence_address(object))
>
> For changes in mm/kasan/common.c.. you have removed !kasan_enabled()
> check at few places. This seems to be partial revert of commit [1]:
>
>   b3c34245756ada "kasan: catch invalid free before SLUB reinitializes the=
 object"
>
> Can you please explain why this needs to be removed?

kasan_arch_is_ready() was removed here because in
commit 1e338f4d99e6("kasan: introduce ARCH_DEFER_KASAN and unify
static key across modes")
I've unified the check with kasan_enabled() which is already called in
the __wrapper
__kasan_slab_pre_free in include/linux/kasan.h

> Also the explaination of the same should be added in the commit msg too.
>
> [1]: https://lore.kernel.org/all/20240809-kasan-tsbrcu-v8-1-aef4593f9532@=
google.com/
>


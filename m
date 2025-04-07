Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CD7C3601E
	for <linux-um@archiver.kernel.org>; Mon,  7 Apr 2025 08:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=em0yD0kIpDtyZFKdGXKgNdHuMfrDjAXLZIWfYU3VNv0=; b=gk9MIvzA4dSdJe5BbVmfhGtJ6e
	adEsbt36EWJsFKttzsDbPL222qpS5IEg86cNh2Q4hqJ1ojzOsl4HJ7kM6qD4rjgCjkzbmkjLA9iWX
	/EWu/6RGzgPEG36FOBiNKDIBrMsYfFsa/UuAWrwN3xucXF/qEvFH1O1/jmJNOFxiQ+e82gmyJFQAe
	EIi+/XhTqMJkjqZS26o1rgsdTG6qgo8oNBBP09rBiCMB9LNRoWV3wuiJsW9Xm6NGng7gJoMuKGcpK
	aBwSU0wVi7E+k/xcL0glxeezBvdzfUsmb1d0gB7QLyTY9uj1F/QhE+Z6cG96lUBQ3WYBN8YXX/zaK
	8DLxIGlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1hcU-0000000Gwx3-0nM7;
	Mon, 07 Apr 2025 08:14:14 +0000
Received: from mail-vk1-f175.google.com ([209.85.221.175])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1hUp-0000000Gvf5-3PeY;
	Mon, 07 Apr 2025 08:06:21 +0000
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-523de5611a3so1808877e0c.1;
        Mon, 07 Apr 2025 01:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744013177; x=1744617977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=em0yD0kIpDtyZFKdGXKgNdHuMfrDjAXLZIWfYU3VNv0=;
        b=slp7KPyMfSOPGg93zcSuTtaL3cyTFaEiilNp93X9wn9xSxFojx0ybw3AZ8bUqQVFqV
         lX54eOhNgwRyl5ly5htUVRgPTGcJ18l9ZRjMk15K28ZItoIXWxZYCyCt7lymMHxRzaOo
         EblDXnukOBAuoEpnhXuCXoWYSczLV0F45ZbauHUq7cDPArY9xouwUT39TWcVZeRxmHBJ
         KGVocCDIy2KzWmBRA5WGVdjvFC6rXHtAb1USx+TdkTyccExZiiEapBFHWpRZyE/rBOgx
         ZsvnXoZvACLjFca3feDMIq7NQd0u/BjZLON5Nl8TrA1SShLlk1nhikeGQDfbj/kOONpq
         jwSg==
X-Forwarded-Encrypted: i=1; AJvYcCU4AJRa4x4WREWCEKpLRWiqu8LLILLxWP6T2Im58j7D3tZjKQzWxIM+Lb7TLlTXuv6C4rQDmSz11tZqJkSi51s=@lists.infradead.org, AJvYcCW+jjbtCghQ47LJiW1Kw3lJGIj6iEtl2z/Se5AHRSfgN8EJ/+na50Wd66OYWnoNjkmWT0o56hXMFwDsbNv7cZvs@lists.infradead.org, AJvYcCWP/WEIC9vuDGfMtI/rVg5cDgCHixN8da26wHCkAEPQO6t46Cq0jm/gTDsjxvVIw9Z1ERj9YBd+JhaCgkg=@lists.infradead.org, AJvYcCX404Kq9BwND+HMyfQF9lqjxeVc//j8n3Yrrj9uruNw7HQLNaZKFy5KmXmZBP7mGTVx49xYw0EO9OY=@lists.infradead.org
X-Gm-Message-State: AOJu0Yw3shT3pCUTAulHMx8H04qt6upVW65zdZgEOeTe41nfafyxmAI2
	fKrDJmBx0rRqXa0rusvPJJUiApQNE1bTeRfGnpzsHvWf/ZxzBGi2z9zDl+tx
X-Gm-Gg: ASbGncu3ZGZbtsIM1cAUbetc0EnfYj1FAY9e4iKxvLrVhHIFRHs9ZuMi2JmO7i0VOv6
	JoXYH+14SdLg2jsoLxrXQt/4k+87lXwbWgqyYPdhytY7Hvu3Q5NRTSIotqxpLsehcJYuD15Zgv8
	o5efg5gcrl0TwsmOB+3AODhKIZEFXMTzQvrGcdfga+oBgSlkln1mAIgYSk4IW/xl17AHsfCLNZ6
	GW+kyON1SfGVK/XL9d7BVU90Va1Q8qRNdOgRch1toSx6X0TebfSNRvMbsNnEupAzv5xn0qFP4X8
	EmbP1G+92BDfnBtTf0BwswPk44XJeKHChQjuElgDeJr3Uknp5580xOCbHbHWd2dvohEXN2f/HZb
	/9tP3pmY=
X-Google-Smtp-Source: AGHT+IHQ+MYl5RRJTujY4oYX2pqJBFucZEPAxztRZsOKcEJits9/HLTYm00mNvzDiTYFp+0w9ImMAQ==
X-Received: by 2002:a05:6122:2217:b0:520:420a:a07a with SMTP id 71dfb90a1353d-5276455eeddmr7822992e0c.8.1744013176947;
        Mon, 07 Apr 2025 01:06:16 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52767d8f9f8sm1303026e0c.37.2025.04.07.01.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 01:06:16 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86cce5dac90so1702787241.0;
        Mon, 07 Apr 2025 01:06:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIi6f9oSmZrdne1woPlGE0JyJaxaV6VcuFhDl5GhNL2taN0XR2LAq2YaOvxYbzIPa0Cd6OFeClCIPeZTuxZd4=@lists.infradead.org, AJvYcCWtbSGX0eKzXetFLunlb3uOx8vFxkB7wvpiRN/QcHn4Sj6Pt0dRXZKnGbL+1AhFh0PGLTq5GQU6w0D0uBU=@lists.infradead.org, AJvYcCX+Q+J8WPIUCEOvMKnjw2VbBzgygbxfWTSt3vYedSsyRIYNEcgISSpdhQSyZRKCowP9cB/1jRn/3tw=@lists.infradead.org, AJvYcCXKMlboZ0SfK3t2KaG3pO/Qml+MxpllDVRQko2XFl+u/Nz88kIIS6f1wOclgF23pxexAQGawpyLlqC6h/h3Ia25@lists.infradead.org
X-Received: by 2002:a05:6102:1622:b0:4c3:221:8f47 with SMTP id
 ada2fe7eead31-4c8553d0fafmr8533368137.13.1744013176401; Mon, 07 Apr 2025
 01:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250218175735.19882-1-linmag7@gmail.com> <20250218175735.19882-2-linmag7@gmail.com>
 <4209b9816551367f8e5670cc5a08e139f0f2c215.camel@physik.fu-berlin.de>
In-Reply-To: <4209b9816551367f8e5670cc5a08e139f0f2c215.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Apr 2025 10:06:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWLVw8aUY8aCowgOz+puxjrDqcbUXUAoVXGi8=FpTHwrA@mail.gmail.com>
X-Gm-Features: ATxdqUEtUaFZruSQ19joR0gbmVyVokHgxasQdxoPHK2-UPmtdbKL5noyYxpgMcc
Message-ID: <CAMuHMdWLVw8aUY8aCowgOz+puxjrDqcbUXUAoVXGi8=FpTHwrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: pgtable: fix pte_swp_exclusive
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Magnus Lindholm <linmag7@gmail.com>, richard.henderson@linaro.org, mattst88@gmail.com, 
	ink@unseen.parts, kees@kernel.org, arnd@arndb.de, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, chris@zankel.net, 
	dinguyen@kernel.org, jcmvbkbc@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	loongarch@lists.linux.dev, monstr@monstr.eu, sparclinux@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_010619_852610_8AAD8DAD 
X-CRM114-Status: GOOD (  25.15  )
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

Hi Adrian,

On Sat, 5 Apr 2025 at 19:22, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Tue, 2025-02-18 at 18:55 +0100, Magnus Lindholm wrote:
> > Make pte_swp_exclusive return bool instead of int. This will better reflect
> > how pte_swp_exclusive is actually used in the code. This fixes swap/swapoff
> > problems on Alpha due pte_swp_exclusive not returning correct values when
> > _PAGE_SWP_EXCLUSIVE bit resides in upper 32-bits of PTE (like on alpha).
>
> Minor nitpick:
>
> "when _PAGE_SWP_EXCLUSIVE" => "when the _PAGE_SWP_EXCLUSIVE"
>
> >
> > Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

> > --- a/arch/alpha/include/asm/pgtable.h
> > +++ b/arch/alpha/include/asm/pgtable.h
> > @@ -334,7 +334,7 @@ extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
> >  #define __pte_to_swp_entry(pte)      ((swp_entry_t) { pte_val(pte) })
> >  #define __swp_entry_to_pte(x)        ((pte_t) { (x).val })
> >
> > -static inline int pte_swp_exclusive(pte_t pte)
> > +static inline bool pte_swp_exclusive(pte_t pte)
> >  {
> >       return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
> >  }

> > --- a/arch/xtensa/include/asm/pgtable.h
> > +++ b/arch/xtensa/include/asm/pgtable.h
> > @@ -355,7 +355,7 @@ ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
> >  #define __pte_to_swp_entry(pte)      ((swp_entry_t) { pte_val(pte) })
> >  #define __swp_entry_to_pte(x)        ((pte_t) { (x).val })
> >
> > -static inline int pte_swp_exclusive(pte_t pte)
> > +static inline bool pte_swp_exclusive(pte_t pte)
> >  {
> >       return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
> >  }
>
> I'm not so sure about this implicit cast from unsigned long to bool though.
>
> Is this verified to work correctly on all architectures? I wonder why this

Should work fine: any non-zero value is mapped to one.

> bug was not caught earlier on alpha on the other hand.

On Alpha, "pte_val(pte) & _PAGE_SWP_EXCLUSIVE" is either
_PAGE_SWP_EXCLUSIVE == 0x8000000000UL or zero.  Due to the return
type being int, the return value was truncated, and the function always
returned zero.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


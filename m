Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE438ECD6EC
	for <linux-um@archiver.kernel.org>; Wed, 11 Feb 2026 20:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=28hr9LjidhOb4+7vDtUZiT7dYr2nuAMqMlceW5mXuOg=; b=tiXgCQG0qcqPGVY22+eaAsOPtW
	+4NrEqdaiezLrtlwU8BXsePtdNHUYTX0NZ+vfc+A1nvk2LaPtmSN5EzICTQzN89mLaCkAX9jRhcQi
	QMFY0P//qImauk/3HdKr85l4RP8bdH+w9jwJxRVgMlidKyUbit38KaHJDs4bBic5OOAl1wNF9gjcj
	HbenGUVSkpIqoOM8TP8mE+uF8DHcyd0QkleMgkF+3mqNDkzalaNp8ctkNeVr2oEft94DyVTzVnyqs
	HG3mPDqM2N5iQk2zd/zgwQRwwNQtkCTJ7ECILWYnglIlrqBdfTGqVxH/7XLtwOhouKzZOOyywEuTR
	j4hB382w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqGbe-000000010fe-0qLE;
	Wed, 11 Feb 2026 20:14:38 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqGba-000000010dx-283K
	for linux-um@lists.infradead.org;
	Wed, 11 Feb 2026 20:14:36 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-b8ea3d15580so781118266b.0
        for <linux-um@lists.infradead.org>; Wed, 11 Feb 2026 12:14:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770840872; cv=none;
        d=google.com; s=arc-20240605;
        b=eYkSaqG8tsTBNawiwkQIzzFtPV4wUmRQmQlhVdzmGJGoaMg6+Ksvz2rRQob/m7rg5g
         tmvysSJ7N8IpLuO4XHovOfkppstqL1sonw69TA5Tw5NpZ1SvUa41bfnVVIPOefcDEcoq
         kMsGLdLLs9vjKAiJD70Gzwi5sJU/E+hNYvP3JCbtLhFUAhAEY4t855kcQDqBCAX7XUbF
         3E28KS6mfaVSKgtyhEmLmD238WPF2Ucfqo/QdUVXbsNUqtdh4v/Fih/YSZS8iHHtI0jP
         782b/8EG0ILYwk1jx3mIvrvnkkqbF3LK1cVySo/if72cv+BmJAVvfYYUao5U81mBgbrk
         WW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=28hr9LjidhOb4+7vDtUZiT7dYr2nuAMqMlceW5mXuOg=;
        fh=K0qo5XzOhiYSBiLV+FXhtsWLLRwb4O48AWC1mBHK9V4=;
        b=AEifils+MJPNlvK2jkp+tgsWf17uliAXIvmzSxm+e6TllDiX+dHQT3QcDah8Du0MOC
         Z1YWdiy+DVvhszjtD75XGJaGsSQdEL0BvaXraZMgKXEBFzMxIX+btMjPfud2RpiDz11M
         kw3PA/IVDM91l1SQIqLPXlV8JZKSWf+8sajLEt0mI+hLnKUYXXT76s/mPJ4JBUH39B9z
         cIYVqHUYrNz9+CEpiSnGUkTgofqvqrNxHG9x5aIP0pkq4P/IhYj39T5uSdn/5BAI2qKi
         LBr1ufp5k39lAjjCFVfOAKCeaOp9smLlvwj6EMxcPOqOHs6XvO/S+gBeeGWED1Uoll+M
         TcNA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770840872; x=1771445672; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28hr9LjidhOb4+7vDtUZiT7dYr2nuAMqMlceW5mXuOg=;
        b=cXL7OPgzZLeP94p5p8qWFFSXO7o0jh96MfDHM6vJWTiHC7Pt3CTNoeNxfyf8R4ILs3
         02+IhsD4n6oPnNI8la1R6Kx9+GN9INgLHns/t75kDBjnyRAyMFbTM9p+Y/Cn5UQCPNX/
         Fq5bizvlixPJbXMKwYLvq91x5eZgKXsLM8VHYHxWrOgHDpWLU5IN1SfcJgIQ0yQJ7Kw6
         L9aE1KbcZ71sWEI7omRQJm/xu7BHJz05gPSPDMJRpGAJD+NADZHp35Q6U4EJInurkrIF
         qU5yi6ie58qTQwxRi45pC4n64vJH6hxEQUVgtVAfA8+eb/Hg8u+W8NK1Li0rUeKnVDxq
         hSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770840872; x=1771445672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=28hr9LjidhOb4+7vDtUZiT7dYr2nuAMqMlceW5mXuOg=;
        b=MgO09roLD/8+S9uExgQ3QDM1go3r/lxrJMYkbQ4bxuYghI/XEpI4Xw7x2KToOu/CJH
         n27WKP9A/epZVq7Vw3fsqGzm30gOO64RyKbgVzNfejwzZ0MB0kCuqvZ0JTuFL/eFpQX1
         Zdvmh0uWarOYjG+sx/rCIqJTxNwYfiynJk3CaBYoIJkN9AJaywyKmydG5BPJ90dGOVOA
         /r/bM47EFcWY43wQYs/IlYpMTLt9N3TbHD1JuLZh+liUsWhizNrcOSBHwz6ua/TFL+Vd
         QBonV/NFaY7xmf5VPmA3Dg6RGNudNxu9M81M2L/OzSRL+3L/FVzONRdJb3bHh8s685wC
         vuvg==
X-Forwarded-Encrypted: i=1; AJvYcCUBfv3D3Wag1cFc+AdxlHZP+8O5GPJZ+L8mpFe5YCu1NXER6yXgd4uJ4pJtC8Ah7fYFGkprlm9nsg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxEgabTKABHH/tmFwZdz2AOLTZL78f+ZjNDGSyNFtrv3PYpAFCe
	upZN9OISswLhdgPUKIY2GU2XTXxjY0fN62XVfDF0AsZPs1dqT5Tc7qYrfFS66jYAD6awbot8ClP
	f1CnSkDcb1tZYAnmxHQL1rePYxnZlipA=
X-Gm-Gg: AZuq6aJJs1msXRNE0nmI8SdQxW17L3l2ECICu6cx20krr1eNPLqH64uKwh1JOyeFtaS
	Vd+vcnBzILloYtLBGAZJXenymnRuEaeD3Uj1XCnVL8wCpnYobqb0NaQ8UJbS5x/L74hEkjNSK0D
	3+Q7dX0n9ZUUtSU9v3fmXhg9GNrguSc9R85YJgXaytNpoGA4MWm67Do7qEw4C6hOf3IYG71oTqN
	2TSAJ+kMgBf7CaWF0Lq3RvZQ/Q07NjMUNUkC37z1Gd2ca2zKX2FA1CMHgm11cJYYNURk3pnltZf
	FfCQm9K+f4GRJ1BkWGO3Thc2lu890sHHxbx4GfJ3Mw==
X-Received: by 2002:a17:907:a08a:b0:b8e:64e:1ed with SMTP id
 a640c23a62f3a-b8f8f72d91emr17643566b.50.1770840871149; Wed, 11 Feb 2026
 12:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20260211103141.3215197-1-rppt@kernel.org> <20260211103141.3215197-4-rppt@kernel.org>
In-Reply-To: <20260211103141.3215197-4-rppt@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 11 Feb 2026 21:14:19 +0100
X-Gm-Features: AZwV_QgdPAvH3hw0825YIt93LQPupYFvh_AV-2zMkwGhubC87cSa2iVxpdoZwag
Message-ID: <CA+=Fv5T07oBJweU3tURD4Nuh7VRWovsf0zjHtA1nDAVNmO=D2w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arch, mm: consolidate empty_zero_page
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@kernel.org>, 
	Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_121434_566418_021D007E 
X-CRM114-Status: GOOD (  23.80  )
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

On Wed, Feb 11, 2026 at 11:32=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Reduce 22 declarations of empty_zero_page to 3 and 23 declarations of
> ZERO_PAGE() to 4.
>
> Every architecture defines empty_zero_page that way or another, but for t=
he
> most of them it is always a page aligned page in BSS and most definitions
> of ZERO_PAGE do virt_to_page(empty_zero_page).
>
> Move Linus vetted x86 definition of empty_zero_page and ZERO_PAGE() to th=
e
> core MM and drop these definitions in architectures that do not implement
> colored zero page (MIPS and s390).
>
> ZERO_PAGE() remains a macro because turning it to a wrapper for a static
> inline causes severe pain in header dependencies.
>
> For the most part the change is mechanical, with these being noteworthy:
>
> * alpha: aliased empty_zero_page with ZERO_PGE that was also used for boo=
t
>   parameters. Switching to a generic empty_zero_page removes the aliasing
>   and keeps ZERO_PGE for boot parameters only
> * arm64: uses __pa_symbol() in ZERO_PAGE() so that definition of
>   ZERO_PAGE() is kept intact.
> * m68k/parisc/um: allocated empty_zero_page from memblock,
>   although they do not support zero page coloring and having it in BSS
>   will work fine.
> * sparc64 can have empty_zero_page in BSS rather allocate it, but it
>   can't use virt_to_page() for BSS. Keep it's definition of ZERO_PAGE()
>   but instead of allocating it, make mem_map_zero point to
>   empty_zero_page.
> * sh: used empty_zero_page for boot parameters at the very early boot.
>   Rename the parameters page to boot_params_page and let sh use the gener=
ic
>   empty_zero_page.
> * hexagon: had an amusing comment about empty_zero_page
>
>         /* A handy thing to have if one has the RAM. Declared in head.S *=
/
>
>   that unfortunately had to go :)
>
> Acked-by: Helge Deller <deller@gmx.de>   # parisc
> Tested-by: Helge Deller <deller@gmx.de>  # parisc
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/alpha/include/asm/pgtable.h          |  6 ------

> diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pg=
table.h
> index 90e7a9539102..12a3c5f8ece8 100644
> --- a/arch/alpha/include/asm/pgtable.h
> +++ b/arch/alpha/include/asm/pgtable.h
> @@ -125,12 +125,6 @@ struct vm_area_struct;
>   */
>  #define pgprot_noncached(prot) (prot)
>
> -/*
> - * ZERO_PAGE is a global shared page that is always zero:  used
> - * for zero-mapped memory areas etc..
> - */
> -#define ZERO_PAGE(vaddr)       (virt_to_page(ZERO_PGE))
> -
>  /*
>   * On certain platforms whose physical address space can overlap KSEG,
>   * namely EV6 and above, we must re-twiddle the physaddr to restore the

This looks good from an Alpha perspective

Acked-by: Magnus Lindholm <linmag7@gmail.com>


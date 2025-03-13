Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A668DC35FF3
	for <linux-um@archiver.kernel.org>; Thu, 13 Mar 2025 18:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n3DVX2jUUT8USovuBtaAWfLwoCZG/vTo0soqbEn/R/c=; b=GKr9WOS7WXV1D6sSWuFcvQYPGg
	kER5F3StKCJHqCy+66Kgq8KWMo9FDt3BTpF1eEUV98z4aSzF2+6UgjB8kEgvrWtjxmWHHsxF8d64Y
	mDNsJ/pBssgFoy+MoFUvuzbNIj5ONdgKjGay1SMxWC/LcOmQ7KIECDC3dpvH7AEh+zqIqJ0q/uit/
	+O2lZ9zZWxdJg4GVbgO3BaZUYnoGhQUYNjemSfpymWDX0vlvwMuxa+RlfR1wAlKjhvTBP0W2vrho7
	b6luK6+3rCx7ljEVBIvT4i9V4ZQ0Z5DPgkyp20ZVEz2hoDCQZJHmS8/JAdJ5Q1r5FcnJJqr179wuZ
	7Uk9LNBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsnfN-0000000CETu-3Ysj;
	Thu, 13 Mar 2025 18:52:25 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsm8z-0000000BxZq-16qG;
	Thu, 13 Mar 2025 17:14:54 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so2202728a91.2;
        Thu, 13 Mar 2025 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741886092; x=1742490892; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3DVX2jUUT8USovuBtaAWfLwoCZG/vTo0soqbEn/R/c=;
        b=fuAlenHWcZRaMs56E9QcHHK7bWc+EU7oy/WUYbrZ/QsT0va1cIyv/3GaVdvJhduBbN
         URUdQk9NJhwZZS29iC6LAJVgXhCaKcEaEn2WR87Yox9NpXsMwDyh4q0ht6ewsnNElEIo
         ReChVBkQkt1+PveprCvwIwbPPHw/8gYFHdmhwzwtm+0R9FtofxbOvzJXeJgjx7GF8bko
         b6bi1j+FoAeeOzNxX9tRkgi16Fu/5H4vtNeGIO7wPLH6A3OYeUFkWTQUf2K0J6QZbGU4
         vqiGYe4YUIBDT/OGZpG6zBh3IfmWM4nAKc3WPORb9dblOemhLRDHxr1ofiJNts+O8sBK
         RBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741886092; x=1742490892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3DVX2jUUT8USovuBtaAWfLwoCZG/vTo0soqbEn/R/c=;
        b=BT9T3PGjYJ2pavm4Gfd7/vJHQ42XHinzVmqEDiW0YctTUHltd5wV6+YVHIICJq1P4k
         Kw7qIfETZY6sFDYxF9thbmOqobD2FSsshUmtyDW9NFNGNOav+4Qv52iFvjX0qVAJsM6G
         X9mEkfIQHiY/EhgTascnvP9bk8aI0GmLjtZBybcfHoPYR5mNeivzKPzA1X0kQ3HLSQ5X
         PXOaXpfSo3gUP90xtAopJYjL8CuuipMtdQUtqzhv4y6A4KXnxqkHzAOqWRUJMKPMyP3v
         9LQRJHU04i66gnBj2JI0JufudT+MhvoJfREMqjmr5ix2F2Gf2WgqMTR2RyM72om2LYOK
         VeRg==
X-Forwarded-Encrypted: i=1; AJvYcCUrTEwX6qpXVmn4+q2L3TOmExyCRES6+9FzhlGSXjyPN/jGBE8RVBXLzxpI+xte1k3pnNkcsHMEXF11zjsK+mi4@lists.infradead.org, AJvYcCUtsKn827xdrhem+rmbnSPY2l4OH2olDdO1NjZXniOT0henUebpPpaizkhnFN0OlggzosGHKpF3f2r7VRb/izw=@lists.infradead.org, AJvYcCVRA7HjtxyirAfOyuE+XD0vfJZ7SFwDE7GYL8eIe/XV0CD54yxTVPS2n83tqswE1p+Meq5o+65Chn2z7es=@lists.infradead.org, AJvYcCW+bILCKki+pnmloSgkp7e1/hqFiTrF+RZ36W448i7m4aSiNSPPHvK1To2gv5yyODerNIl3KoVvg2g=@lists.infradead.org
X-Gm-Message-State: AOJu0Yx8y0AAipLwbsoPd3xBkvfEhP7dcaR2NAlncQA4QiF7pX7o24Wk
	Aiv9HvLsyQS8LS/w0epjj9ekTvpOPvIi+hUgGigl32izDEuPkJGjWK386hYDe00budP1PPTyali
	FCc762anii1Oz1EtbSUbR6CyCbpY=
X-Gm-Gg: ASbGncshH2juEdKso4+SpsQToq4XQZePd1HV9VIKwIDUEhq5tesV4PMOAb0L7c2BPKF
	HZAjXSun7fHBD4vW48QY4ebMEGzpKe9qvcgZ1jqtfmXVYdKOfsmyRvIQTKiyyoUi1S2pFpJfoE0
	zNlfWUDsatKZqWbcnxW5rVTjd4JbE=
X-Google-Smtp-Source: AGHT+IE1qRePjrPlGe/k7DXmrY+KtJaOvGWQ1A7tyU5eLBTz7VxuSMi4hxEC/EMElopjpnT6L0bRBsC6lDv+GByhQbc=
X-Received: by 2002:a17:90b:5608:b0:2fe:b8ba:62e1 with SMTP id
 98e67ed59e1d1-3014ea24aa4mr365923a91.28.1741886091572; Thu, 13 Mar 2025
 10:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250313135003.836600-1-rppt@kernel.org> <20250313135003.836600-9-rppt@kernel.org>
In-Reply-To: <20250313135003.836600-9-rppt@kernel.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 13 Mar 2025 20:14:39 +0300
X-Gm-Features: AQ5f1JpOtVR6fLnH8b4t6Wo35MeP6GXSndMXHGPmpker_QqVMpVf1FbK9Hm_3_Y
Message-ID: <CAMo8Bf+_8QdcWmk-k6dpUUnvVtVsYCgcviK+fF=CsKjT3nFxHg@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] xtensa: split out printing of virtual memory
 layout to a function
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Mark Brown <broonie@kernel.org>, Matt Turner <mattst88@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_101453_401239_D1A08E0E 
X-CRM114-Status: GOOD (  11.44  )
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

On Thu, Mar 13, 2025 at 4:52=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> This will help with pulling out memblock_free_all() to the generic
> code and reducing code duplication in arch::mem_init().
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/xtensa/mm/init.c | 97 ++++++++++++++++++++++---------------------
>  1 file changed, 50 insertions(+), 47 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max


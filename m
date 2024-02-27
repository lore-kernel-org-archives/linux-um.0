Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37675C5478C
	for <linux-um@archiver.kernel.org>; Tue, 27 Feb 2024 08:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uzwNvfzqcMx0O3hVp46LgRJMNTPfRBstut9NEe744kY=; b=fK4AMLhC74r441GICgiNE46K0Z
	FDFWjZTYwonCxu4GX9Lf7kZ7yXrwLcXSdihYUzskEx3yUlzGvKyuNELmG4Kx/Mp8uZOtn1YcuX0B+
	OAt5UtWl01aqu90LJ8aotySdAGEOg/fFBPnkVaLKgFuZU6yqPnz5GAv2TdevyU4VJzHDpg1qsa2mi
	0MEcS2eQPNmkVfavCZtAKyYvXLVnF9YsgWBJ+0dpNGvm7h2XHl8eomJOJT1KzmOIOI1uv3VxHlDen
	nlCHGYQDtiBVM2ljnXxro6hicLfliNJuO/MhqDZer6y7Y4NmELyp/YWe+K3tTe0a/S4py9nSkJjjX
	tOxsjHZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ret5r-00000004N41-1DHb;
	Tue, 27 Feb 2024 08:45:43 +0000
Received: from mail-oi1-f175.google.com ([209.85.167.175])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ret5l-00000004Myk-25HE;
	Tue, 27 Feb 2024 08:45:39 +0000
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bb9b28acb4so2787732b6e.2;
        Tue, 27 Feb 2024 00:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709023534; x=1709628334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzwNvfzqcMx0O3hVp46LgRJMNTPfRBstut9NEe744kY=;
        b=n4W3W5SgACNjI13cKv0BoQZGsL347W8oX+mxL7Yju0NwU2PyTBMrXjDmozIKRThQEy
         uRsRMdcTwEzkTCpLK50yhHItDNIvZKO3KPLyA4sIuOcGLP7PV5f0W2J0yBw36Okuql2k
         k9SGgMsOKJxwVllk+ebnuGyoaLgHzLe6nY9HRCDmGLpZ1P7sBnR5MGdSxc6qJlDPWyRt
         LW3OMgMnWpDxsbww+edAW1MQ0sNVwn211baRwP158ovJvcpsOMCFCstJ5rTGKoPshFE4
         NmNw23p0EkI2d4+NcOMMsRobDUcImPF5JQiAhMJ5Tx7Pi7oEuiB+MYWQ9uzu6srkxkEk
         SbUg==
X-Forwarded-Encrypted: i=1; AJvYcCURQg+UNHwA6sizK/M8OiqPexdV8w+ZxhAJ7abjHc6aOUCCe9sFs9jEgdtJKy9ijecTGVJRiskb08B3L8OlC/xb3/JFiHwG956lWIb0j6X8fLRXyzYpYeYRQaot/wP01F5wV5KDKOerw1GLhc14qmZ3K5zvqAWRCdxJiLV9uIqLRTSPY26u72J4Cxnt0/qWbZJg6MGR9Sd/hs46uWB69sMIeLVsw/kf+yzeBVPuil4duuZVBtBOsIU=
X-Gm-Message-State: AOJu0YzrvLcAJ4rd2P1YVF2ltiixbt1AGU2Auw2tqSeYgaePgj/UPqcz
	cwfd4yI+1Fg5m2jmNTDX64X+ergfasypncGaW0LZ+jJTQnv1SlGovQwV4+Ov/h22zQ==
X-Google-Smtp-Source: AGHT+IH5xqThb3ZlvGh2FopJouv01FecqxQOUdkn/wizntoYYvZ4pCciwQFLdO+9HGP5lnOSs3nTpw==
X-Received: by 2002:a05:6870:b027:b0:21f:aad7:6882 with SMTP id y39-20020a056870b02700b0021faad76882mr9141384oae.35.1709023534029;
        Tue, 27 Feb 2024 00:45:34 -0800 (PST)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id nw15-20020a056870bb0f00b0021ebd810c92sm1966473oab.41.2024.02.27.00.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:45:33 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a035a1124dso1491134eaf.1;
        Tue, 27 Feb 2024 00:45:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXoH+kWjworULD3x4UELUtoAtxH9NFSN6E1BrJfIlcgXOwRCSUMwpxV5PxqxkIP+ammptwj5NCXEc6e45VuO9Y8gb5fShGTAwIql4z3z+EsAtHORaEpPBll5lQjq5qnJffPzLmMP3E2s/CmSMKKEZTLLbwnPogKRerlgTn+1abuBMg35BT8S3qsFn+wAH+35aZ/HtRpWOX3haztH8mdOnISBUjNrgqWuZ8X/986l2XbU34xwrVH0Zc=
X-Received: by 2002:a25:84c7:0:b0:dc7:496e:42e1 with SMTP id
 x7-20020a2584c7000000b00dc7496e42e1mr1414712ybm.51.1709023513209; Tue, 27 Feb
 2024 00:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20240226161414.2316610-1-arnd@kernel.org> <20240226161414.2316610-2-arnd@kernel.org>
In-Reply-To: <20240226161414.2316610-2-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 09:45:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVCWF50SO1TK5F5Q8sN08THKJ+F6gt9u5pD05gJUZ+E9w@mail.gmail.com>
Message-ID: <CAMuHMdVCWF50SO1TK5F5Q8sN08THKJ+F6gt9u5pD05gJUZ+E9w@mail.gmail.com>
Subject: Re: [PATCH 1/4] arch: consolidate existing CONFIG_PAGE_SIZE_*KB definitions
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Kees Cook <keescook@chromium.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, x86@kernel.org, Max Filippov <jcmvbkbc@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_004537_567260_BCEF3A20 
X-CRM114-Status: GOOD (  18.32  )
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

Hi Arnd,

On Mon, Feb 26, 2024 at 5:14=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
> From: Arnd Bergmann <arnd@arndb.de>
>
> These four architectures define the same Kconfig symbols for configuring
> the page size. Move the logic into a common place where it can be shared
> with all other architectures.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/arch/Kconfig
> +++ b/arch/Kconfig

> +config PAGE_SIZE_4KB
> +       bool "4KB pages"

Now you got rid of the 4000-byte ("4kB") pages and friends, please
do not replace these by Kelvin-bytes, and use the official binary
prefixes =3D> "4 KiB".

> +       depends on HAVE_PAGE_SIZE_4KB

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


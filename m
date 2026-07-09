Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296D7C44507
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 08:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O3mkBNkViagFAJs3obyg41kBlrTMtmvpPUP/R2gZOPo=; b=4MVgnDaK9qH4OiJJ3mslpOSCO5
	PzitzlfWYnG5yTRO2Y143iMAZzhNuAFcj9Wf1bCbLR7Z7J2rOOhVG8wrhPEdoTL3w6venX2F8+FNB
	nyj1ft2CMixUUUgCtGTOCcLHPyzoX8zoXOgdNcqVYEY1JMa2CwDtjjoAJB6XWVK6fbYRKn8cLq3np
	Yer0WXFpd+YMVBCreeO5NaCHK+tGDyu9eNRoJpSi4Wbp58gjPFzEgbGM4jfXyK6zhjjg15HSg0eqC
	yXHqQdSz7YMG/gD+FIOc3PdxCx6Z2x3gK5mejMzflYgFXKBgf1yi+yaxVC2LSQf8WFEasNDT99ZIS
	2wKqNlLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whkWo-00000001ePC-0OcO;
	Thu, 09 Jul 2026 08:54:42 +0000
Received: from mail-pf1-f177.google.com ([209.85.210.177])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whkST-00000001ZJG-3nXa
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 08:50:23 +0000
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so432959b3a.2
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 01:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783587013; x=1784191813;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O3mkBNkViagFAJs3obyg41kBlrTMtmvpPUP/R2gZOPo=;
        b=FIkh7CL/aj3HuqfFUifo/tMpW8rijfptimh+BWRD+igNS0hhhyCoXXJP0N3SepsM1X
         +tuF6aKRgC7TH1ryVhklHetLH59VMeBwQGz4ByRkORWMhaaTBo3rQjYBa5JrJNFZmhca
         Bjuu/r0TOznvCDwwDR7xOIBlD+W+Banme65BTmsmzIZfwL1TuKiww2j4Qfkw9Ji5QCyZ
         3DXMp3VYmGd40Wk5X4TgUYlCfJS56gL3yimltP5amuRsH87DHe+klrXzsQOKDddvA5NS
         pZ4NftiVh964xZiB6qkjPLyPwMGFfxXtPeoCg/NBzT04BCt81HWihauSBsTtlUrt2UnS
         Lqfg==
X-Forwarded-Encrypted: i=1; AHgh+RpH7XApi4Cq3YzWteNhrviJK2N7mLwFalw1PKT0/8ZQT49QGIgjtVoJuUXBuMffXa/OpuI2CRxcvw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxCmwANaTtVXWqkSjOiDdd8/26RKg/ODdogHv0bhB4KGIAluyLr
	y5njOmNbXY3S0AWu2i70bQSsEjLZnELiAUrpr0BxewoRL7R+04ifJrCkwaM+zEfGHgs=
X-Gm-Gg: AfdE7cl2deLJ6ftUMJuVyKE8o+tLffYYhtL590po3HV4/ppQQ2p5gqkwZz17lEFt/2h
	ZHhC2MaU0M6UkODvA/YXlF9JfvW2Si15VaWdmFrBXxOSYAZmxCwx3aHHqzjOJC5WPQeGpPIEC1t
	70xt3wDJ3eamEotgolCnoKpgSr6TcHBStgixhioUaTYF3w9P/Xqm14cyo0uZ3Dq01Klenv9RZca
	9GwxkTnR8DyVAx6oTYlT3BJdHniqHKn6Bi1oqZ84wJ0ug80o8/C+pLfvTCQEqi6Man/fp8FSGIh
	F7mjm0gKvdjidFoTjlqTmjnMhC2qYW7aoAMLQkMbLUwGiEnk8fbplYyOdv1+oYKLedurHAN/GoJ
	RzXwAGXM2zvyvdjRlWYv8znK8cQaJ4BzGC9TJYrY4WlPMQ/aQ16u+LdhjitkGkt1VcKp26HfXXS
	5209oiFdQ8MUa73jnd4rIP606KxInM1ciH0aSq2Ind+qNU7tjjQR6iuA==
X-Received: by 2002:a05:6a00:9469:b0:848:599f:26b with SMTP id d2e1a72fcca58-848599f0bb0mr1791411b3a.14.1783587012921;
        Thu, 09 Jul 2026 01:50:12 -0700 (PDT)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com. [209.85.214.169])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5afbc14a9sm3397562a12.10.2026.07.09.01.50.12
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:50:12 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cabc0a1ab6so22154105ad.0
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 01:50:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqbOvkS7BoYox0G4How1gIVGfVSGlKsTCIzkuHEbklCUiL7/y2VdRqR7iicYQNIdX0+QYQ2Cjo+WA==@lists.infradead.org
X-Received: by 2002:a05:6102:6895:b0:738:9dd5:9b03 with SMTP id
 ada2fe7eead31-744e03a337dmr3306957137.20.1783586528282; Thu, 09 Jul 2026
 01:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org> <20260707190254.280015701@kernel.org>
In-Reply-To: <20260707190254.280015701@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 10:41:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWe1D0CZrav5h6EhDDbeJzgJcHvT89jrs6109Bdj-pdTw@mail.gmail.com>
X-Gm-Features: AUfX_mw8w2Kp5VuAYozzfDNS6gDbdKhQdYzfXsv-G72F3LS58UBytbGwOmplITc
Message-ID: <CAMuHMdWe1D0CZrav5h6EhDDbeJzgJcHvT89jrs6109Bdj-pdTw@mail.gmail.com>
Subject: Re: [patch 12/18] ptrace, treewide: Rename ptrace_report_syscall_entry()
 to ptrace_report_syscall_permit_entry()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Chris Zankel <chris@zankel.net>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Richard Weinberger <richard@nod.at>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_015014_019218_57A50C9C 
X-CRM114-Status: GOOD (  19.19  )
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

On Tue, 7 Jul 2026 at 21:06, Thomas Gleixner <tglx@kernel.org> wrote:
> The return value of that function is boolean and tells the caller whether
> to permit the syscall processing or not.
>
> Rename the function so the purpose is clear and make the return type bool.

>  arch/m68k/kernel/ptrace.c       |    2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


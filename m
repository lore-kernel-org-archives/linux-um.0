Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44176E7718E
	for <linux-um@archiver.kernel.org>; Sun, 22 Dec 2024 06:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=htlpToW+3tDMXYk9LHSjN7kEjprwT0u1X/m/1Vl/oro=; b=xSrLubR+OX/pv+hrK83wwwWKzU
	BtZb9HvZtDJ2HvLl+fpaeGSkuOE6figovhaDWiS3n6Gz3jM6BBUy4ZxRuKgTkbqEtTmPiHlWc6wIy
	LTDx5FeUfFgbpCZqYRFIP9/niE2NYXItblXoA7DVzF3Idwtjj3b56dMHOQX3kZqKcBMdo70ieDSGa
	2bkw/JfvNdGMkSGD8Yx1w5IKP/1gWWj31M+VX6eUtlV+xXbx5RL/zfcIfVKJkIaOpBpluJ2bPivJz
	Gj+T58IwtDFlSJTPVkhJv7CCTUmT0Hv7YCEedwNY5GdPclPSwPaHG33hqJ8r130G2FSVgyvhLpo6S
	Q1oW58EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPF7b-00000007sfR-2RFd;
	Sun, 22 Dec 2024 06:07:23 +0000
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPF7X-00000007sds-3sKh;
	Sun, 22 Dec 2024 06:07:21 +0000
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-e3fd6cd9ef7so3434401276.1;
        Sat, 21 Dec 2024 22:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734847639; x=1735452439; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=htlpToW+3tDMXYk9LHSjN7kEjprwT0u1X/m/1Vl/oro=;
        b=m8DZr3HZ8JZ7+4rWcxw7nqe7K2Ftkl9Ue3dvSh4PDgbc9YcEJb75jRAvelcEN9HMet
         o/4JXbR0CRaFscfc6Uw4+s0KafC76XvmV+KwpTSSirD1saCeZ86Au+swHF+bcrwU/fjc
         V9QrgBun2T08WXxIY6Y5bTbQL30v/dDt/oyi7/BT7Lf9DNsQTQ+1Apt6tCXrTfWDFLF0
         IYOG7rsH/m7NPkOFGmQQVyPfqT0X4aaATTFWk8xsxLFAwF4AoT/Pvlhah7aojL9CQjxK
         Oz7WEW5FFk5rGGyUt0BUKFhcv6VTOeH1HvS8+X7EGn7AvXap8byRMW0qT7LHm3S6l9UX
         mkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734847639; x=1735452439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htlpToW+3tDMXYk9LHSjN7kEjprwT0u1X/m/1Vl/oro=;
        b=iOD4Bsp6iTNhiHpsaHf+4h+OswdklkrllXkydMa3+ImuaMPITtdF7C7fxgRhqwf8k0
         krj7jidgGPmgQljFGx0Nd3yOX5Yu+esBHfU6BpCAZqOLExUqYb/e0Cn6i2MSj3ix/Br5
         gViaBnhmhl9ZxviX/ltmdOjDzHG5n4USMlO3gDMSqNmho6bLdx6LU9cwipfMLg4bQbNb
         E7159TBXdvS1lB2Gv2UtaOEGneZ+Pjhnyep4f+BTvVzXHKf49DOSNBBuFgG99ftsDfqK
         o5sdi3nD61s0WD5pEWM3bfMcLEB/HStyNyLNCyG4TFMgfFmYgkwc+jgyaB9N2EoZfuue
         QS0g==
X-Forwarded-Encrypted: i=1; AJvYcCUT7uigDRoPzJE1Armom7g2m066t2ZyGrzcy4F715qIunOT0EmqFPMV07A7gWv4G+YMzv/ovoCjMdxL0tJXO+cR@lists.infradead.org, AJvYcCVkVfcmd5nyOu/BjJLH0cpecepm/K7sRyOHhYLLgJrOBd7kGJfWWS0RZnhbtiOnX0X7eAYFKMhEt5g=@lists.infradead.org, AJvYcCWNul6quiuH9nxQkFIsLRqGacbuwGa8hPE53iQHMirfh3yyfGh6YptIPAIiWAAomZHr8gEQknI08yfJqEQ=@lists.infradead.org
X-Gm-Message-State: AOJu0YwVz2P2JPhB5AisgtfZW3wjeIXAK4r6c6KpkhrYaj9i9o6/OWj/
	jUzWx7goHgd7+MEHkLuPLz2sFERb58CTcQbMnW52kfx1tjaznoqw37wBh4KoDRgKNqiJO6329RC
	F27kUUmRv94t6gulBTZQbwdHaWac=
X-Gm-Gg: ASbGncuGnz0e2esaLOMMUAkrOSlCc/3mw6j70LmOaovfvJCuWa09rH3SMmX11Byi4BA
	TYOzFY/bfZqaJEGnucdjFPoJ/7SFUJp/JwTbtNW0=
X-Google-Smtp-Source: AGHT+IHTObibTWvFBx2RCqB+bk/1ZpT+xydtv33cOquvAas7ggMPQiaYSrqKqDsv5/UZU90VEPoAsSH6qDx1lw2KYn4=
X-Received: by 2002:a05:690c:6908:b0:664:74cd:5548 with SMTP id
 00721157ae682-6f3e2a65668mr105552167b3.1.1734847638651; Sat, 21 Dec 2024
 22:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20241222054331.2705948-1-guoweikang.kernel@gmail.com> <02d042a6590ddb1fadb9f98d95de169c4683b9e7.camel@xry111.site>
In-Reply-To: <02d042a6590ddb1fadb9f98d95de169c4683b9e7.camel@xry111.site>
From: Weikang Guo <guoweikang.kernel@gmail.com>
Date: Sun, 22 Dec 2024 14:07:09 +0800
Message-ID: <CAOm6qnk0KYJXuCLU=7Y10wjMjWnUQ+n_RDsJZv5rAqBmq9bkug@mail.gmail.com>
Subject: Re: [PATCH v6] mm/memblock: Add memblock_alloc_or_panic interface
To: Xi Ruoyao <xry111@xry111.site>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Sam Creasey <sammy@sammy.net>, 
	Huacai Chen <chenhuacai@kernel.org>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	rafael.j.wysocki@intel.com, Palmer Dabbelt <palmer@rivosinc.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Easwar Hariharan <eahariha@linux.microsoft.com>, 
	Johannes Berg <johannes.berg@intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@intel.com>, Christian Brauner <brauner@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	WANG Xuerui <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Helge Deller <deller@gmx.de>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Geoff Levand <geoff@infradead.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, kasan-dev@googlegroups.com, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241221_220719_961531_6CFDA70E 
X-CRM114-Status: GOOD (  15.06  )
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

Xi Ruoyao <xry111@xry111.site> wrote on Sunday, 22 December 2024 13:51:
>
> On Sun, 2024-12-22 at 13:43 +0800, Guo Weikang wrote:
> > Before SLUB initialization, various subsystems used memblock_alloc to
> > allocate memory. In most cases, when memory allocation fails, an immediate
> > panic is required. To simplify this behavior and reduce repetitive checks,
> > introduce `memblock_alloc_or_panic`. This function ensures that memory
> > allocation failures result in a panic automatically, improving code
> > readability and consistency across subsystems that require this behavior.
> >
> > Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
> > ---
>
>
> Please try to avoid bumping the patch revision number so quickly.
>
you are right,  I'll pay more attention to this in the future.
> And if you must do it, you should embed a ChangeLog of your patch (below
> this "---" line) so people can know what has been changed.
>
The update was indeed due to my problem. CI prompted me that there
were some compilation warnings that needed to be dealt with, so this
update was to fix the CI warnings. Refer to this:
- https://lore.kernel.org/oe-kbuild-all/202412221259.JuGNAUCq-lkp@intel.com/

> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University


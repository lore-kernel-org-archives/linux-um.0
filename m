Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DA5C88E41
	for <linux-um@archiver.kernel.org>; Thu, 10 Sep 2026 06:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UNeh3lUekONIP+bceTcz/qzQUFIH9IGvapVm9Sqamho=; b=t3mWdQO77ba5eIp2o9pGZOTjO5
	4Ta3/zgjr+uNza1UQ7mk34X6eSeEZQqG7CrOyhrtV9Dd26djwlgHhcVCyFzHVXqL3Q7Jud2QaPDwd
	hFsiTFXdJxxRHCYOj9U/WMxiFb1DMIJuSmuJ2bJgNGirENa6xXuQz8qPwxzjNW4OLBCYwR6pZvEe+
	j/F+M9ZUeR2EPyU+7VhHp9vHuUws6VUv6exT5pFeYkOI9yJxY90ZqlokqH0owFK9rbBfip2oLYY6n
	oyBiOLQaMx2qm0GR5fqBCcuS+PFltp/D8mMk3/F3kQ0Bia+eNhkScYupv4zIXbf1uN6YWGNi2gF/T
	hWnnaiMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Yeg-0000000DZTD-0qr2;
	Thu, 10 Sep 2026 06:53:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Yee-0000000DZSa-2XTg
	for linux-um@bombadil.infradead.org;
	Thu, 10 Sep 2026 06:53:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=UNeh3lUekONIP+bceTcz/qzQUFIH9IGvapVm9Sqamho=; b=XXKCSvxvQuYurywdfdebNE7bO7
	q66TTl7I97UjXioUVQyCw6ovG65a4Sd0gi+HqgeO6jFFrwy0Tbf7Dm7otbdp5+mf/qfu3WlMuOG0E
	DCisdQ/65oPnzC91iR88SHkv6TQoje5bHqF96uwzpzOPcQ0ovejQ6irMYFH3n5SIzNZ6qcJJCCcQn
	DrY7c5kvPprk8ajV0vu88VRN4sS3MxcByDvceONAtZL2wQ9BZZ0gjut76c65vVi6Hl9SPKhxUrx+a
	xSvvIusnDWeVBjZX8hdvgKMW7gSWCpbe/dM6nUMn8Ays1a+5zkeI3P/Mrk9xLuVDTOgL+LeHDWnhB
	g5vlBnfg==;
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4Yea-000000026Mw-37F4
	for linux-um@lists.infradead.org;
	Thu, 10 Sep 2026 06:53:03 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so5671789a91.2
        for <linux-um@lists.infradead.org>; Wed, 09 Sep 2026 23:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789023178; x=1789627978; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UNeh3lUekONIP+bceTcz/qzQUFIH9IGvapVm9Sqamho=;
        b=UP3v5y+Tz496z0e9Y1ElEThgJquY6IF9dMmbF2q1zAGPyxj/ayWTQAZMAyMBnl9vlU
         OAvDUhm56q/zF5t1xC5Q54rM6uULtBIPF+1qup9GxvitRxzxGPaoJulZm/opH5U1wFpp
         wghfmSn+pBuM/XDUqM5NYzXgm8MKWneif+GSOServ9lX/kls2Q1hMdDUvocizEN7EDO5
         n9Qv6zgNvapni3PY8y4waiBCLlY7TXkE41Wwvam75wSIKQbj5wzgc6r3U/+OdUfckXGK
         7H0sPu33Nl8OIBeRUyE+v7ZqIxzJ4bOFq6deGmdnGRZjssk/CPO5DowFx8By7ciijD69
         lQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789023178; x=1789627978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UNeh3lUekONIP+bceTcz/qzQUFIH9IGvapVm9Sqamho=;
        b=OKa2ole+BucZBCuBRT1Z7pXcgsI5/pdBKjGGGNkhsLGs9fW741P9pW57cYbpvOYWpx
         sCSliZaiCR7rKOI24WWephh5eC7AkTBv2eeJiY1VJSLLQWZTL58psn387/058hNOximp
         mkn8T9ai7B6QGt5wKDC5HtKykY2eggbGELLIniOxefd50wb9HK1S+PDjgvG6ATLWcCuE
         j3bQ4oVplBhPnmn/jmt1TjBBUJ0fWAl7/dUAoJcWFthhyz5A//jdZXI7UVj0r+JF5k20
         0B4aJAFeD1gnQjzKx035MJh709s9g0CKMbuzOfadZygVs2vyhv3hJmRoM3Yl1YJUWA0h
         Zqlw==
X-Forwarded-Encrypted: i=1; AKwUvBwr2dOHxS7mMZOBNzQzc9T91/ciAwxzj3R+8MQxAkLZIcLVsb2XyhdCi/HydyL8unEWKD3aC3Em3Q==@lists.infradead.org
X-Gm-Message-State: AFuF++l4V1gmzxCecPCSlCJ/3uTXpzZkDo7O1IkR3nXv5jiWXSSk0PE3
	oAR9F+zv1kRD2SlzSDu41rQPTnU7LuKd84/PYS1E7eOsVdMggEzH5/Iz
X-Gm-Gg: AYBFou2azSNAiV13nWcKLG8gEFsJmbZdq2QPR018758tEMdRAyGQq4mp0u7iaXgUnE5
	fYoe6DE6rJSbmB+hohWyQq6mQnwqMVbihPkD6kaXRs8vmUU3dnJ01vT7c4jCOJRLzX6dila80a8
	QWyeAu1X6GCzyVD/OgPqLvPDjvuRYm+DoJ5fS4ZXAb7lME3ceWFYRxMZN79aSlYA7KHpTWzVblS
	FRz9hQ6LtD3E3OdqtS4nT1c1LP/FElEPT99ixFLdHTDwq3q2yrFtdHkq7sD3yjtT/MRXpm2k847
	+3VlVQjvERzSfO9MUbxeWY8ym4JzczIjMc0UTaSl7ZHchYf2/+GnkC3nbNjy8U8QkNdCAtl+/G9
	epgUsbCkrHHGA2DKj6VX3GFWHQujs3XPac8EDhcwx/vmgAsxGRnB/9CKrPgYIRBfXdvFAMVQ7fP
	M6It1jCk5lY7Ke8/VpDch30mAnfUS3B5n6zI5QtCJY+xw+SDIskdMN1F9s1VGLbxDOoaO5JgbBM
	B6JSRnVnAR+AaD24Zgbo20h9Wr3wLnL0MbMVcrZ9HI=
X-Received: by 2002:a17:90b:3d92:b0:398:bf7e:b267 with SMTP id 98e67ed59e1d1-39b2614df9dmr61606265a91.2.1789023178292;
        Wed, 09 Sep 2026 23:52:58 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7e77498csm2694423a91.3.2026.09.09.23.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:52:57 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:22:33 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Christophe Leroy <chleroy@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 12/24] vdso: Add the vdsocheck tool
Message-ID: <aqJS61DbuUI3xoY3@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_075301_010736_BD94514C 
X-CRM114-Status: GOOD (  23.01  )
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

On Tue, Sep 08, 2026 at 08:33:46AM +0200, Thomas Weiﬂschuh wrote:
> All vDSO code needs to be completely position independent. Symbol
> references are marked as hidden so the compiler emits PC-relative
> relocations. However there are cases where the compiler may still
> emit absolute relocations, as they are valid in regular PIC DSO code.
> These would be resolved by the linker and will break at runtime.
> This has been observed on arm64, see commit 0c314cda9325 ("arm64: vdso:
> Work around invalid absolute relocations from GCC")
> 
> Introduce a tool to check for absolute relocations during the build,
> as the current inline-shell logic is not expressive enough.
> The check is done on the object files as the relocations will not exist
> anymore in the final DSO. As there is no extension point for the
> compilation of each object file, perform the validation in vdso_check.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  Makefile                    |  19 ++
>  lib/vdso/Kconfig            |   5 +
>  lib/vdso/Makefile           |   2 +
>  lib/vdso/Makefile.include   |  14 ++
>  lib/vdso/check/.gitignore   |   3 +
>  lib/vdso/check/Makefile     |  34 +++
>  lib/vdso/check/elf.rs       | 498 ++++++++++++++++++++++++++++++++++++++++++++
>  lib/vdso/check/vdsocheck.rs | 154 ++++++++++++++
>  8 files changed, 729 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 4ad67b737af7..e6e0dd7818ef 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1559,6 +1559,25 @@ vdso_install: export INSTALL_FILES = $(vdso-install-y)
>  vdso_install:
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vdsoinst
>  
> +# ---------------------------------------------------------------------------
> +# vDSO check
> +
> +ifdef CONFIG_RUST_IS_AVAILABLE
> +ifdef CONFIG_VDSO_CHECK
> +
> +# Build the checker early.
> +prepare: vdsocheck
> +
> +# If the architecture builds the vDSO early, make sure to be earlier.
> +PHONY += vdso_prepare
> +vdso_prepare: vdsocheck
> +
> +PHONY += vdsocheck
> +vdsocheck:
> +	$(Q)$(MAKE) $(build)=lib/vdso/check $@
> +endif
> +endif
> +
>  # ---------------------------------------------------------------------------
>  # Tools
>  
> diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
> index 597f5f0f9681..112b42a5aeb1 100644
> --- a/lib/vdso/Kconfig
> +++ b/lib/vdso/Kconfig
> @@ -23,3 +23,8 @@ config VDSO_GETRANDOM
>  	select VDSO_DATASTORE
>  	help
>  	  Selected by architectures that support vDSO getrandom().
> +
> +config VDSO_CHECK
> +	bool
> +	help
> +	  Selected for architectures that are supported by the 'vdsocheck' progam.
	s/progam/program

Regards,
Mukesh


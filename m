Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8BBC88E40
	for <linux-um@archiver.kernel.org>; Thu, 10 Sep 2026 06:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1toCXFJJyIGT7Bi3z+gvDkztm6+uDMf7He5yX/dqQdk=; b=xEmVPIZ/yRtJ1243c5WShiuSZN
	V5l3KDZNjdl8llVEo2cDesYEpi6uXrfUj26NKFCyUjDo2ubzZjzUvfIifYl/Nx0xvBsZJtVpCHnXU
	Z7MJHe1diJD9YiGPGKB284Mxg1R7cYd5STq2X9coDA0u3A9UesWuf0kIII2pJoOKrpiWOBk+3BMNt
	/DTaDPg5aeXmXli8SVnwHDwV3jCQKiFCXPc/sJPctiTKg1jjKqKulMUeSd7fbPIjtNnreE13cK13x
	125XY14535yrqQaBgM0G06gJlX4v0dtChQxt8VpJnDSFAFK1u5xLx2Btw06PHwh3fxGy0lFiuNlii
	WeBU8h4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4YK9-0000000DWHL-27vX;
	Thu, 10 Sep 2026 06:31:53 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4YK6-0000000DWGR-2tTw
	for linux-um@lists.infradead.org;
	Thu, 10 Sep 2026 06:31:52 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-38759bcd877so7240961a91.2
        for <linux-um@lists.infradead.org>; Wed, 09 Sep 2026 23:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789021910; x=1789626710; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1toCXFJJyIGT7Bi3z+gvDkztm6+uDMf7He5yX/dqQdk=;
        b=OsWgRTYJ43HQA7ibdund2efDhndrmOFVmj242c/zth+F6X1lJgtCYdQRPFBucotGUz
         CX8KAOU5Y7SY1Z4C2ZGE0Kku6h6VPs5IV3W7mDICOhi/tp9B7idFzf2IL70BgtdVpYBW
         mGzSZqBuPiaIXN6tv+qgcG67Xg8KdrjAclo9hEvPfkB9UujZhefTGSt++CLjN58kM2RR
         /VXcRD5C/A94x3bXuwLEI3WGGK4ukMud9iw1bpggFCcuSy65nLqV2zq227GaRt/T3Y3l
         riHflYHL+doLhF92eG0W++2JA3Oi9zpcG25DUSjTRYdxxo1/UkOIaqpC4dkwBcCk10Xl
         jIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789021910; x=1789626710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1toCXFJJyIGT7Bi3z+gvDkztm6+uDMf7He5yX/dqQdk=;
        b=ELSx3DbybHm4b0JFtoF1hqvFjElHhV8CvnsbCaOlyym+jzi7LWotj097hGR2oP/ogg
         pVjoLtagNS8fsJGSLKnth0k5GeCto2IvCquRd2laB05Ce41mYLDWQgnhnN/Hj9CtKOZe
         0jb7vBrNXhkFa6bPWI/Qn5iwc2Lki+RlkgrjerNGLq4zls6zSKrn1bPR53hHxqkhMVyA
         9hCeuI4ub72pyBVQloltr6PShNV3Conk5TXCUg5sdkQe2rA8QVfTajB60y45w8ztqmGD
         0Gf9+EWaXhb1QN6V/8Iq5dx2RHzlzGrTCZ6r2ADeMPyes7ssvKRmEpMeZnlGP/fZg8hn
         b5ng==
X-Forwarded-Encrypted: i=1; AKwUvBzv15GrzEQ5IWE2TcuKGPqusQRi8v12tUHwXchmkzqEqFabxSwUd07WhSKmYiXqewC+pNmQefjHnA==@lists.infradead.org
X-Gm-Message-State: AFuF++k7RUPQF7qxst3ebNUy1fXG8w/nZyRSyp0Ldu3tBAGA9L0q69Kt
	sGmRBao+h32CDst1JDbKZGSe/mw3qLVCayLLaoYyHQmQJbohkPoHOjrg
X-Gm-Gg: AYBFou0qTbKaX80H8FEm+vzaVJKcBqQML+Z5q3ZcR7p8dKgZUB7tIrwkhtWjYKfTNmw
	Hsgu0JSiAfHf3GzNxlJ+UQIMy/7CDpK/tumM9njCYKsqAJCBTkTHNw1/E69ule8OQtN5mo0zUNx
	ivXeZEh0rA6hVgUD4uzfmKl2qWL2oTosv+qAhcfDyROsSD3qOfsxn33GX7/rI5sTp4PLt2OHxkq
	OBEwf2ulTDBTPUM/TTw/rKvaGzbxGgLuIPf/Jx6uVIoEfTa6z5BXZxzlka60yTFuF+Otcklz9sK
	u7iYHoABKEtLh6jepkFfOaw/lyD1+tuq9ZiRZ1hq2OQkL9cxVd4Eb6xk+t/L7zmhEfcwVaiwb4S
	b3ffiV0k/dJ5y0ZT2uTDs8hw238uX/1RuDGzLIdiyW55rV0rP5yf7Va5ACbc/K030VuMLzveO2g
	WBImEcB1MHuk2wbKYsDawvdmUJ56b4UHFYP22IC+xnKlovA5c+TEHd9FBXWWA6zBA7IytBqcrA4
	6UdvpLBOR+bco1FrWfRA92J2jAxz0NSplYRJehfwFY=
X-Received: by 2002:a17:90b:258d:b0:396:4c63:7193 with SMTP id 98e67ed59e1d1-39b261323e0mr64061526a91.11.1789021909725;
        Wed, 09 Sep 2026 23:31:49 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7e834319sm2507639a91.10.2026.09.09.23.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:31:49 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:01:26 +0530
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
Subject: Re: [PATCH v5 01/24] elf, uapi: Add a header for relocation constants
Message-ID: <aqJOscgnnevybiKO@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-1-3a93791af1cf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908-vdso-absolute-reloc-v5-1-3a93791af1cf@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_233150_724035_B910F903 
X-CRM114-Status: GOOD (  22.48  )
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

On Tue, Sep 08, 2026 at 08:33:35AM +0200, Thomas Weiﬂschuh wrote:
> While the numeric constants for relocations are architecture specific,
> it is still useful to get access to them from other architectures.
> Also the definitions are useful for userspace in general.
> For example tools processing elf files during a kernel cross-compilation
> can make use of them.
> 
> Introduce a dedicated header for them, similar to the elf-em.h header.
> For now the header is empty but it will be filled step by step in
> upcomming commits.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  include/uapi/linux/elf-r.h | 5 +++++
>  include/uapi/linux/elf.h   | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
> new file mode 100644
> index 000000000000..2c382c8a4807
> --- /dev/null
> +++ b/include/uapi/linux/elf-r.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_ELF_R_H
> +#define _UAPI_LINUX_ELF_R_H
> +
> +#endif /* _UAPI_LINUX_ELF_R_H */
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index ee30dcd80901..b3e312255552 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/elf-em.h>
> +#include <linux/elf-r.h>
>  
>  /* 32-bit ELF base types. */
>  typedef __u32	Elf32_Addr;
> 
> -- 
> 2.55.0
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>


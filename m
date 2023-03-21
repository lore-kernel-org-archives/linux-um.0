Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1B4C6FD20
	for <linux-um@archiver.kernel.org>; Tue, 21 Mar 2023 20:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1lGsjEM2OKgaEwAsfEERG4aiqtMFyn+9ZFLtnxbp1o0=; b=T8qVGdN7zdp4ek
	JhAZ5qKV/ki32+CAASbbEsaGdwMMl2W6MyiPjZaWOnKgjm7aZSLOVkCjy0dP5AsNSIpTsCkG137Ko
	juSCdbBaeWwkthRaB0WMEnJwnoJCFeKpIZZUxFu+chQc23Z1wUGfUC4QD4Ag72S/z2+Aap+M/xlbL
	1J3NkJSYZaMN4eAqQxs1E86hrKpGKiEDAFIz9UWQFBnSfN8ISb41yA0lRjVNK5tGBsVfJSqNSIASc
	moRfCveK5CX9uZX5B3hFPFwhPH7Z0XPwpXXQf+kfs73TZZfw8EG9rR6p3Lkgqy18yHKVGYdi4UHct
	itW8XYvbisgDerEieXvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peiLB-00DcLt-38;
	Tue, 21 Mar 2023 20:12:17 +0000
Received: from mx1.riseup.net ([198.252.153.129])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peiL8-00DcKN-2G
	for linux-um@lists.infradead.org;
	Tue, 21 Mar 2023 20:12:16 +0000
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.riseup.net", Issuer "R3" (not verified))
	by mx1.riseup.net (Postfix) with ESMTPS id 4Ph2nh23XDzDqGt;
	Tue, 21 Mar 2023 20:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1679429528; bh=+4hKPyRMH2aAK35R9DtVSpBun70VepUerw2XjaTytxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cnch0x4zGxsR9VcUGElrbA7sE/iBGr3H+sdwfYJ4+SiLz3Odfgd7jOUhGap+KYViM
	 zi1bsUKERut+p8wrLXb3bAC/JUBiyoqP9DSKFbqqoXm+jMhRuyOd+Hzvo3D/ltY8ts
	 FEnJ/T9QtDnPvc5H9n/Ci5fvDIdLLCWA33tXns78=
X-Riseup-User-ID: 1C3CD006F550256050AEC2FA37B1A54058F970E2E8F94543F974B5CEED22D817
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews2.riseup.net (Postfix) with ESMTPSA id 4Ph2nP1MWTz1y8Z;
	Tue, 21 Mar 2023 20:11:52 +0000 (UTC)
Message-ID: <a7313cdd-c54e-cbbf-e8e9-8330184912ac@riseup.net>
Date: Tue, 21 Mar 2023 17:11:47 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] arch:um: Only disable SSE on clang to work around old GCC
 bugs
Content-Language: en-US
To: David Gow <davidgow@google.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, SeongJae Park <sj@kernel.org>
Cc: linux-um@lists.infradead.org, x86@kernel.org, llvm@lists.linux.dev,
 rust-for-linux@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
References: <20230318041555.4192172-1-davidgow@google.com>
From: Arthur Grillo Queiroz Cabral <arthurgrillo@riseup.net>
In-Reply-To: <20230318041555.4192172-1-davidgow@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_131214_799790_999A3EA1 
X-CRM114-Status: GOOD (  15.12  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 18/03/23 01:15, 'David Gow' via KUnit Development wrote:
> As part of the Rust support for UML, we disable SSE (and similar flags)
> to match the normal x86 builds. This both makes sense (we ideally want a
> similar configuration to x86), and works around a crash bug with SSE
> generation under Rust with LLVM.
> 
> However, this breaks compiling stdlib.h under gcc < 11, as the x86_64
> ABI requires floating-point return values be stored in an SSE register.
> gcc 11 fixes this by only doing register allocation when a function is
> actually used, and since we never use atof(), it shouldn't be a problem:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99652
> 
> Nevertheless, only disable SSE on clang setups, as that's a simple way
> of working around everyone's bugs.
> 
> Fixes: 884981867947 ("rust: arch/um: Disable FP/SIMD instruction to match x86")
> Reported-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
> Link: https://lore.kernel.org/linux-um/6df2ecef9011d85654a82acd607fdcbc93ad593c.camel@huaweicloud.com/
> Tested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
> Tested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  arch/x86/Makefile.um | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
> index b70559b821df..2106a2bd152b 100644
> --- a/arch/x86/Makefile.um
> +++ b/arch/x86/Makefile.um
> @@ -3,9 +3,14 @@ core-y += arch/x86/crypto/
>  
>  #
>  # Disable SSE and other FP/SIMD instructions to match normal x86
> +# This is required to work around issues in older LLVM versions, but breaks
> +# GCC versions < 11. See:
> +# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99652
>  #
> +ifeq ($(CONFIG_CC_IS_CLANG),y)
>  KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
>  KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
> +endif
>  
>  ifeq ($(CONFIG_X86_32),y)
>  START := 0x8048000

Tested-by: Arthur Grillo <arthurgrillo@riseup.net>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

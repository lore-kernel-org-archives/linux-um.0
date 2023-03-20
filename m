Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52FEC6FD1D
	for <linux-um@archiver.kernel.org>; Mon, 20 Mar 2023 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iWWmDVb1ARRQksKbziBp+ltFUSlpKOcjKD87WlhSnAs=; b=TwG7owkwQzOe77
	I7Hxv8/n6dCrze2WMzuVN8EthOYBfr3HOg8COZ+vjvuia/STzTikZXGQEDqgMvAKME2K1PIE3CTrJ
	iKRHpE2jyqtNDM3G9GERDLvoaHGv8jHgCCxiETlUOzAOriVenrfU3WgeXd5mBleVThfH7pD2gTRDc
	I1A4eh7iEM7Jka5bZbbr+3e0GE506WYRyJzZGMSdqcYHvlGu0Kj+xyiKxclkG7Cq+OKOGpTKUAsld
	VdhvBsTaMlMN3jvdbhTWgMKcsJc56qIEl1N/ZN/4FwvgIulxV62eNF+GjongQXaAJWbzlbgvVnb7R
	QxSrivrO1nky00LWWIRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peJDH-009yPE-2P;
	Mon, 20 Mar 2023 17:22:27 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peJDE-009yNv-2R
	for linux-um@lists.infradead.org;
	Mon, 20 Mar 2023 17:22:26 +0000
Received: by mail-wr1-x42e.google.com with SMTP id h17so11121434wrt.8
        for <linux-um@lists.infradead.org>; Mon, 20 Mar 2023 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679332940;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxjjxaJTXTboGVrfO6rMCJaEH+UFkfq+cnWcxaf6bDM=;
        b=e7NNTBrcXYI6ZeGCPVcm1gqNsy0fhqmhF1hY5CpuPfiD09pAc8mDyuSPHZ2abjnEQs
         5MeUNkf9+Qpn/gJ0TIQFqf1B8wOb7ZAewpBP6p+pX/q3NXaUD16HbZZC6fkbtWE4igUE
         HWYwcgk257n6oww6LsojLHml+jZ/D96pSwk1dP8Uuj9PqRCNSJNie0HouKYdgrWY57o5
         jZsA6U7EfydUc7Q6aytVYpqsZh/KZNqpOnrHIaSJlajFx+HXsoQLIx9/GdPjDA5F6HEj
         stbisFtVA6wAsC+WofyDQyT68vLvYIkMy8kzd+rhsPvwKhzPQY7SiMlZf2Q1sXeDo345
         evxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332940;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lxjjxaJTXTboGVrfO6rMCJaEH+UFkfq+cnWcxaf6bDM=;
        b=idg77lenLOIFzZJzEfi6I48ISucz/eMLZ1fWgk/hu8rTZILpkQV9iuAum629vyi5Q0
         3gJqdw3uv8+UlHqCn1spmwjRR7kdYx2n4mN9BmWz0BPN0ZFXgrtIGfNKwIrCJc9Vg/Fx
         Ia6HibBocJ61eEBePjX16BE5ur0dsrCxjMdDgSq54peLRssQTYMxxE0QpcWlSpkP+XCk
         xw9Hj5ujvCOZMYKG1MT/SZFcMOO24maDa8fBg6WsonvmrWAGrh8LpogYGMtozR7o0VWW
         f9uWDvrBz8P491KZu8rPIhG5/RRWUtBpYfdRSQjZGyoSHgAUe3BqnwEsEoPiJcjR4//C
         W0gw==
X-Gm-Message-State: AO0yUKU+DFSyI7LCBVcFyMRCKsKvkuOWY0fudlT8dNbjO6cfpgFXJAkI
	7MAEyi4xeu1ZLPCHDFnBy4Y=
X-Google-Smtp-Source: AK7set/ymi8bJFB2BEvtQ2c1G0ARXELEvqljjbsIS1JkE7eUXiLHhggKQZscZsry8GAlEe38EPXVMw==
X-Received: by 2002:a05:6000:1081:b0:2d4:53d7:ea7f with SMTP id y1-20020a056000108100b002d453d7ea7fmr121431wrw.3.1679332940533;
        Mon, 20 Mar 2023 10:22:20 -0700 (PDT)
Received: from localhost (93-55-83-125.ip262.fastwebnet.it. [93.55.83.125])
        by smtp.gmail.com with ESMTPSA id p17-20020adfcc91000000b002c71dd1109fsm9426966wrj.47.2023.03.20.10.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:22:20 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 20 Mar 2023 18:22:18 +0100
Message-Id: <CRBDUDH0574S.1JGPTCYLLSBMC@vincent-arch>
Cc: <linux-um@lists.infradead.org>, <x86@kernel.org>,
 <llvm@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch:um: Only disable SSE on clang to work around old
 GCC bugs
From: "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To: "David Gow" <davidgow@google.com>, "Richard Weinberger"
 <richard@nod.at>, "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>, "Nick Desaulniers"
 <ndesaulniers@google.com>, "Nathan Chancellor" <nathan@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Roberto Sassu" <roberto.sassu@huaweicloud.com>,
 "SeongJae Park" <sj@kernel.org>
References: <20230318041555.4192172-1-davidgow@google.com>
In-Reply-To: <20230318041555.4192172-1-davidgow@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_102224_817894_0A30104E 
X-CRM114-Status: GOOD (  14.45  )
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
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog


Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51BBEE57DF
	for <linux-um@archiver.kernel.org>; Mon, 11 Sep 2023 08:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N/88tllEBHWTmVmadMNfpBsONV0eE08wsILmzn4I3G4=; b=uEx8sSDs6LU7YA
	Z7KRkUx27fpm52wyquHX2tKubIamdv2Y7248+Kjzc6Dt3rmb131fWmdpO4g9WtUJnjfSVd4L6NzqN
	pz+0GsTs24Xn5/qfqRvqq1AtQWZUIutPCuoHey/sX/XTUouJSRbSHLbfQBe3MeUcQ36rxjAb2231w
	OhiWPiGyEy4+ogCeb4r9L5FOKIQVgcYlFEJyxa8FWdltVYNsvPK5RJuz+vjgm3lmzSNlZbLWexJKY
	myYVEzQhH7lsT4vVPh38YWvgjPuwn70xNMu+OnDryasm1EKcCsmyfoevSaW/E5/9CmyYcdlAnlLQ+
	fly3ztBkKlZwxqgz5/Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfcis-00HZvU-2R;
	Mon, 11 Sep 2023 08:56:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfcir-00HZvI-2W
	for linux-um@bombadil.infradead.org;
	Mon, 11 Sep 2023 08:56:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LyggSFNgiy14BwIsDV/0K7QQu/1ltroH4K6t5ZXh5Ko=; b=KynaWtg4Ji1mqWYGq5dur9t/Y+
	E+1k3GfenBxgLToV59RYvKzPzAvJkUEL1pWHhlI/xwgf6Ri0egTBJih9teF65YcC9rgFu2/n3qve/
	6slJk/uLntE79CQfZryu3e0oewX/IFH4q1zToOqquqrivvO3CD6Atk0rD7V4bt1JbAyaAg/DMc+a8
	Ew5iQPhcCoPl4PQx3/ynBhRDx8Baiq3TqdO36SFBAceY6tixLmIulmF8ysuW1muiWLz2utEM049D4
	GxzeqrdK1EDoaDQJPJFN+Z3crp6dfW4vLUFMhiWMAV2slUDPwFMgY6w5z/m/1nm2vLPDONedlsOmg
	Gml0+ZZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qfcii-004rWA-1F;
	Mon, 11 Sep 2023 08:56:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7B134300321; Mon, 11 Sep 2023 10:56:37 +0200 (CEST)
Date: Mon, 11 Sep 2023 10:56:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	kernel@axis.com
Subject: Re: [PATCH] x86: Fix build of UML with KASAN
Message-ID: <20230911085637.GA9098@noisy.programming.kicks-ass.net>
References: <20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com>
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

On Fri, Jun 09, 2023 at 01:18:54PM +0200, Vincent Whitchurch wrote:
> Building UML with KASAN fails since commit 69d4c0d32186 ("entry, kasan,
> x86: Disallow overriding mem*() functions") with the following errors:
> 
>  $ tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
>  ...
>  ld: mm/kasan/shadow.o: in function `memset':
>  shadow.c:(.text+0x40): multiple definition of `memset';
>  arch/x86/lib/memset_64.o:(.noinstr.text+0x0): first defined here
>  ld: mm/kasan/shadow.o: in function `memmove':
>  shadow.c:(.text+0x90): multiple definition of `memmove';
>  arch/x86/lib/memmove_64.o:(.noinstr.text+0x0): first defined here
>  ld: mm/kasan/shadow.o: in function `memcpy':
>  shadow.c:(.text+0x110): multiple definition of `memcpy';
>  arch/x86/lib/memcpy_64.o:(.noinstr.text+0x0): first defined here
> 
> If I'm reading that commit right, the !GENERIC_ENTRY case is still
> supposed to be allowed to override the mem*() functions, so use weak
> aliases in that case.
> 
> Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  arch/x86/lib/memcpy_64.S  | 4 ++++
>  arch/x86/lib/memmove_64.S | 4 ++++
>  arch/x86/lib/memset_64.S  | 4 ++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
> index 8f95fb267caa7..5dc265b36ef0b 100644
> --- a/arch/x86/lib/memcpy_64.S
> +++ b/arch/x86/lib/memcpy_64.S
> @@ -40,7 +40,11 @@ SYM_TYPED_FUNC_START(__memcpy)
>  SYM_FUNC_END(__memcpy)
>  EXPORT_SYMBOL(__memcpy)
>  
> +#ifdef CONFIG_GENERIC_ENTRY
>  SYM_FUNC_ALIAS(memcpy, __memcpy)
> +#else
> +SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
> +#endif
>  EXPORT_SYMBOL(memcpy)
>  
>  SYM_FUNC_START_LOCAL(memcpy_orig)

Urgh... 

Can we use CONFIG_UML here to clarify things? It's a bit of a bother UML
is diverging to much, but oh well.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

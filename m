Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWhRO-0000pq-Il
 for linux-um@lists.infradead.org; Tue, 11 Dec 2018 12:47:12 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] x86/um/vdso: Drop implicit common-page-size linker flag
Date: Tue, 11 Dec 2018 13:46:48 +0100
Message-ID: <1633144.08IGjMOzBB@blindfold>
In-Reply-To: <20181210222718.19926-1-ndesaulniers@google.com>
References: <20181210222718.19926-1-ndesaulniers@google.com>
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: ndesaulniers@google.com
Cc: jdike@addtoit.com, x86@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

Am Montag, 10. Dezember 2018, 23:27:16 CET schrieb ndesaulniers@google.com:
> GNU linker's -z common-page-size's default value is based on the target
> architecture. arch/x86/entry/vdso/Makefile sets it to the architecture
> default, which is implicit and redundant. Drop it.
> 
> Link: https://lkml.kernel.org/r/20181206191231.192355-1-ndesaulniers@google.com
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/x86/um/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
> index 822ccdba93ad..bf94060fc06f 100644
> --- a/arch/x86/um/vdso/Makefile
> +++ b/arch/x86/um/vdso/Makefile
> @@ -26,7 +26,7 @@ targets += vdso.so vdso.so.dbg vdso.lds $(vobjs-y)
>  CPPFLAGS_vdso.lds += -P -C
>  
>  VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
> -       -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
> +       -Wl,-z,max-page-size=4096

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


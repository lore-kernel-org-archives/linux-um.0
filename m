Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUOTy-0007FY-Ez
 for linux-um@lists.infradead.org; Fri, 01 May 2020 05:45:08 +0000
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 0415iglV011355
 for <linux-um@lists.infradead.org>; Fri, 1 May 2020 14:44:43 +0900
Received: by mail-vs1-f49.google.com with SMTP id x136so5755652vsx.2
 for <linux-um@lists.infradead.org>; Thu, 30 Apr 2020 22:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200417180455.1174340-1-masahiroy@kernel.org>
In-Reply-To: <20200417180455.1174340-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 1 May 2020 14:44:06 +0900
Message-ID: <CAK7LNAQNwHW8=UQPCs7D=bEx2qKwfoNxVVMmHiOwmPy3j4aaGQ@mail.gmail.com>
Subject: Re: [PATCH] um: do not evaluate compiler's library path when cleaning
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Erel Geron <erelx.geron@intel.com>, Nick Desaulniers <ndesaulniers@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alex Dewar <alex.dewar@gmx.co.uk>, Nathan Chancellor <natechancellor@gmail.com>

On Sat, Apr 18, 2020 at 3:06 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Since commit a83e4ca26af8 ("kbuild: remove cc-option switch from
> -Wframe-larger-than="), 'make ARCH=um clean' emits an error message
> as follows:
>
>   $ make ARCH=um clean
>   gcc: error: missing argument to '-Wframe-larger-than='
>
> We do not care compiler flags when cleaning.
>
> Use the '=' operator for lazy expansion because we do not use
> LDFLAGS_pcap.o or LDFLAGS_vde.o when cleaning.
>
> While I was here, I removed the redundant -r option because it
> already exists in the recipe.
>
> Fixes: a83e4ca26af8 ("kbuild: remove cc-option switch from -Wframe-larger-than=")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/um/drivers/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
> index a290821e355c..2a249f619467 100644
> --- a/arch/um/drivers/Makefile
> +++ b/arch/um/drivers/Makefile
> @@ -18,9 +18,9 @@ ubd-objs := ubd_kern.o ubd_user.o
>  port-objs := port_kern.o port_user.o
>  harddog-objs := harddog_kern.o harddog_user.o
>
> -LDFLAGS_pcap.o := -r $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
> +LDFLAGS_pcap.o = $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
>
> -LDFLAGS_vde.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
> +LDFLAGS_vde.o = $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
>
>  targets := pcap_kern.o pcap_user.o vde_kern.o vde_user.o
>
> --
> 2.25.1
>


Applied to linux-kbuild.


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


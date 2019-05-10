Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-06.nifty.com ([210.131.2.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hOvq5-0002il-Jy
 for linux-um@lists.infradead.org; Fri, 10 May 2019 03:04:51 +0000
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id x4A34XfP008479
 for <linux-um@lists.infradead.org>; Fri, 10 May 2019 12:04:34 +0900
Received: by mail-vk1-f170.google.com with SMTP id h127so1119235vkd.12
 for <linux-um@lists.infradead.org>; Thu, 09 May 2019 20:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-7-brendanhiggins@google.com>
In-Reply-To: <20190501230126.229218-7-brendanhiggins@google.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 10 May 2019 12:03:57 +0900
Message-ID: <CAK7LNAQ+SRMn8UFjW1dZv_TrL0qjD2v2S=rXgtUpiA-urr1DDA@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] kbuild: enable building KUnit
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, amir73il@gmail.com, dri-devel <dri-devel@lists.freedesktop.org>, Alexander.Levin@microsoft.com, Michael Ellerman <mpe@ellerman.id.au>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "Cc: Shuah Khan" <shuah@kernel.org>, Rob Herring <robh@kernel.org>, linux-nvdimm@lists.01.org, Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>, kieran.bingham@ideasonboard.com, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, rientjes@google.com, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, DTML <devicetree@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Tim Bird <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Kevin Hilman <khilman@baylibre.com>

On Thu, May 2, 2019 at 8:03 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Add KUnit to root Kconfig and Makefile allowing it to actually be built.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

You need to make sure
to not break git-bisect'abililty.


With this commit, I see build error.

  CC      kunit/test.o
kunit/test.c:11:10: fatal error: os.h: No such file or directory
 #include <os.h>
          ^~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.build;279: kunit/test.o] Error 1
make: *** [Makefile;1763: kunit/] Error 2








> ---
>  Kconfig  | 2 ++
>  Makefile | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Kconfig b/Kconfig
> index 48a80beab6853..10428501edb78 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -30,3 +30,5 @@ source "crypto/Kconfig"
>  source "lib/Kconfig"
>
>  source "lib/Kconfig.debug"
> +
> +source "kunit/Kconfig"
> diff --git a/Makefile b/Makefile
> index 2b99679148dc7..77368f498d84c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -969,7 +969,7 @@ endif
>  PHONY += prepare0
>
>  ifeq ($(KBUILD_EXTMOD),)
> -core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
> +core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/ kunit/
>
>  vmlinux-dirs   := $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
>                      $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
> --
> 2.21.0.593.g511ec345e18-goog
>


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


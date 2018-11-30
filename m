Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSZlH-0006ou-D0
 for linux-um@lists.infradead.org; Fri, 30 Nov 2018 03:46:40 +0000
Received: by mail-pf1-f196.google.com with SMTP id c123so2109946pfb.0
 for <linux-um@lists.infradead.org>; Thu, 29 Nov 2018 19:46:27 -0800 (PST)
Date: Thu, 29 Nov 2018 19:46:23 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC v3 16/19] arch: um: make UML unflatten device tree when
 testing
Message-ID: <20181130034623.GQ18410@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-17-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128193636.254378-17-brendanhiggins@google.com>
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
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, frowand.list@gmail.com, linux-nvdimm@lists.01.org, richard@nod.at, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, joel@jms.id.au, jdike@addtoit.com, Tim.Bird@sony.com, keescook@google.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Wed, Nov 28, 2018 at 11:36:33AM -0800, Brendan Higgins wrote:
> Make UML unflatten any present device trees when running KUnit tests.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  arch/um/kernel/um_arch.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index a818ccef30ca2..bd58ae3bf4148 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -13,6 +13,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/task.h>
>  #include <linux/kmsg_dump.h>
> +#include <linux/of_fdt.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/processor.h>
> @@ -347,6 +348,9 @@ void __init setup_arch(char **cmdline_p)
>  	read_initrd();
>  
>  	paging_init();
> +#if IS_ENABLED(CONFIG_OF_UNITTEST)
> +	unflatten_device_tree();
> +#endif

*Why?*

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


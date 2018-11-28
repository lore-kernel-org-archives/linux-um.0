Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com> <20181128193636.254378-17-brendanhiggins@google.com>
In-Reply-To: <20181128193636.254378-17-brendanhiggins@google.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 28 Nov 2018 15:16:34 -0600
Message-ID: <CAL_JsqK5cG=QzMBFSZ31_-3ujnxqxv=jj3XYajbRLT7yWYZbfw@mail.gmail.com>
Subject: Re: [RFC v3 16/19] arch: um: make UML unflatten device tree when testing
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@google.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, shuah@kernel.org, Joel Stanley <joel@jms.id.au>, Michael Ellerman <mpe@ellerman.id.au>, Joe Perches <joe@perches.com>, brakmo@fb.com, Steven Rostedt <rostedt@goodmis.org>, "Bird, Timothy" <Tim.Bird@sony.com>, Kevin Hilman <khilman@baylibre.com>, Julia Lawall <julia.lawall@lip6.fr>, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, Dan Williams <dan.j.williams@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Frank Rowand <frowand.list@gmail.com>, knut.omang@oracle.com
List-ID: <linux-um.lists.infradead.org>

On Wed, Nov 28, 2018 at 1:38 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
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
>         read_initrd();
>
>         paging_init();
> +#if IS_ENABLED(CONFIG_OF_UNITTEST)
> +       unflatten_device_tree();
> +#endif

Kind of strange to have this in the arch code. I'd rather have this in
the unittest code if possible. Can we have an initcall conditional on
CONFIG_UM in the unittest do this? Side note, use a C if with
IS_ENABLED() whenever possible instead of pre-processor #if.

I'll take a fix separately as it was on my todo to fix. I've got the
unit tests running in a gitlab CI job now[1].

Rob

[1] https://gitlab.com/robherring/linux-dt-unittest/pipelines


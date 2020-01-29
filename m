Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwguR-0004aH-J0
 for linux-um@lists.infradead.org; Wed, 29 Jan 2020 06:33:08 +0000
MIME-Version: 1.0
In-Reply-To: <20200128072002.79250-7-brendanhiggins@google.com>
References: <20200128072002.79250-1-brendanhiggins@google.com>
 <20200128072002.79250-7-brendanhiggins@google.com>
From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1 6/7] kunit: Add 'kunit_shutdown' option
Date: Tue, 28 Jan 2020 22:33:06 -0800
Message-Id: <20200129063307.19CB4206F0@mail.kernel.org>
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
To: Brendan Higgins <brendanhiggins@google.com>, akpm@linux-foundation.org, alan.maguire@oracle.com, anton.ivanov@cambridgegreys.com, arnd@arndb.de, davidgow@google.com, frowand.list@gmail.com, jdike@addtoit.com, keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com, skhan@linuxfoundation.org, yzaikin@google.com
Cc: linux-arch@vger.kernel.org, knut.omang@oracle.com, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, linux-kselftest@vger.kernel.org, logang@deltatee.com, Brendan Higgins <brendanhiggins@google.com>, kunit-dev@googlegroups.com

Quoting Brendan Higgins (2020-01-27 23:20:01)
> From: David Gow <davidgow@google.com>
> 
> Add a new kernel command-line option, 'kunit_shutdown', which allows the
> user to specify that the kernel poweroff, halt, or reboot after
> completing all KUnit tests; this is very handy for running KUnit tests
> on UML or a VM so that the UML/VM process exits cleanly immediately
> after running all tests without needing a special initramfs.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

Two nitpicks below

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 7fd16feff157e..d3ec1265a72fd 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  #include <kunit/test.h>
> +#include <linux/reboot.h>

Should this include come before kunit/test.h? I imagine the order of
includes would be linux, kunit, local?

>  
>  /*
>   * These symbols point to the .kunit_test_suites section and are defined in
> @@ -11,6 +12,23 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
>  
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  
> +static char *kunit_shutdown;
> +core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
> +
> +static void kunit_handle_shutdown(void)
> +{
> +       if (!kunit_shutdown)
> +               return;
> +
> +       if (!strcmp(kunit_shutdown, "poweroff")) {
> +               kernel_power_off();
> +       } else if (!strcmp(kunit_shutdown, "halt")) {
> +               kernel_halt();
> +       } else if (!strcmp(kunit_shutdown, "reboot")) {
> +               kernel_restart(NULL);
> +       }

Kernel style would be to not have braces on single line if statements.

> +}
> +
>  static void kunit_print_tap_header(void)
>  {
>         struct kunit_suite * const * const *suites, * const *subsuite;

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


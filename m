Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nP8c6-000LJh-R3
 for linux-um@lists.infradead.org; Tue, 01 Mar 2022 19:56:52 +0000
Received: by mail-pf1-x42a.google.com with SMTP id g21so8951230pfj.11
 for <linux-um@lists.infradead.org>; Tue, 01 Mar 2022 11:56:47 -0800 (PST)
MIME-Version: 1.0
References: <20220227184517.504931-1-keescook@chromium.org>
 <20220227184517.504931-8-keescook@chromium.org>
In-Reply-To: <20220227184517.504931-8-keescook@chromium.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 1 Mar 2022 14:56:35 -0500
Message-ID: <CAFd5g46usCBp_a_eTpgY=-mD5bLZTzyBt+aO-FTDBNkAAc9=UA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] UAPI: Introduce KUnit userspace compatibility
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
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Vitor Massaru Iha <vitor@massaru.org>, Daniel Latypov <dlatypov@google.com>, David Gow <davidgow@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, KUnit Development <kunit-dev@googlegroups.com>, llvm@lists.linux.dev, x86@kernel.org, linux-hardening@vger.kernel.org, shuah <shuah@kernel.org>

+Bart Van Assche - I don't know if you are still working on those
configfs tests, but I wonder if this would be interesting to you.

On Sun, Feb 27, 2022 at 1:45 PM Kees Cook <keescook@chromium.org> wrote:
>
> The original lib/test_stackinit.c, which exclusively tests toolchain
> features, was designed to also be built without the full Linux kernel
> sources so that compiler developers and distro maintainers had an easy
> way to check for toolchain behaviors. When it was ported to KUnit, this
> mode was removed to simplify the code.
>
> Add a small header that provides a minimally operational KUnit API that
> can allow unit tests that don't depend on kernel-specific behaviors
> to build and run strictly from userspace without kernel sources. Add
> userspace-build support back to the renamed lib/stackinit_kunit.c test.

Very cool. I was hoping to achieve a true UAPI KUnit via LKL, but
that's clearly a long way out. Besides you have a point with being
able to distribute just a couple of files.

My initial thought is that a UAPI for KUnit would mostly be useful for
testing parts of the kernel that have very few dependencies. However,
I remembered that Bart (cc'ed) was working on some KUnit tests that
would probably be better as userspace tests. I think there might be
some potential for a KUnit UAPI in decoupling the test library from
the test environment.

I have been thinking off and on for a little while about enabling some
kind of KUnit kselftest fusion tests, where you could manage an
environment in kselftest and use KUnit for testing in kernel
structures. I think this is kind of going from the opposite direction,
but is probably an easier place to start.

I will refrain myself from getting into too many wild ideas, but I
like where this is going. I think it is reasonable to just start off
with a duplicate implementation of KUnit as you have done here: we can
see if this has any legs, and if so, we can do something more
complicated later.

> Signed-off-by: Kees Cook <keescook@chromium.org>

I have some thoughts for some things that can be improved, but after
thinking about it; I think they are all things that make sense once we
see if there are other potential users. I think as an initial version,
this looks pretty good.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

(leaving the rest of the email unclipped for Bart's benefit)

> ---
> v1: https://lore.kernel.org/lkml/20220224055145.1853657-1-keescook@chromium.org
> v2:
>  - split from stackinit_kunit.c refactoring patch
>  - add missing returns (Daniel)
>  - report expression mismatch in assert msg (Daniel)
>  - emulate kunit_test_suites() (Daniel)
>  - emit valid KTAP (David)
> ---
>  include/uapi/misc/kunit.h | 181 ++++++++++++++++++++++++++++++++++++++
>  lib/stackinit_kunit.c     |  11 +++
>  2 files changed, 192 insertions(+)
>  create mode 100644 include/uapi/misc/kunit.h
>
> diff --git a/include/uapi/misc/kunit.h b/include/uapi/misc/kunit.h
> new file mode 100644
> index 000000000000..afdffda583ae
> --- /dev/null
> +++ b/include/uapi/misc/kunit.h
> @@ -0,0 +1,181 @@
> +#ifndef __UAPI_MISC_KUNIT_H__
> +#define __UAPI_MISC_KUNIT_H__
> +/*
> + * This is a light-weight userspace drop-in replacement for the in-kernel
> + * KUnit API. It seeks to implement a minimal subset of features so that
> + * a concisely written KUnit test can be made to run entirely in userspace
> + * when it doesn't actually depend on any real kernel internals.
> + *
> + * Additionally contains many refactored kernel-isms to support building
> + * and running in userspace without full kernel source.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdbool.h>
> +#include <errno.h>
> +#include <sys/types.h>
> +
> +#define __user                 /**/
> +#define noinline               __attribute__((__noinline__))
> +#define __aligned(x)           __attribute__((__aligned__(x)))
> +#ifdef __clang__
> +# define __compiletime_error(message) /**/
> +#else
> +# define __compiletime_error(message) __attribute__((__error__(message)))
> +#endif
> +#define __compiletime_assert(condition, msg, prefix, suffix)           \
> +       do {                                                            \
> +               extern void prefix ## suffix(void) __compiletime_error(msg); \
> +               if (!(condition))                                       \
> +                       prefix ## suffix();                             \
> +       } while (0)
> +#define _compiletime_assert(condition, msg, prefix, suffix) \
> +       __compiletime_assert(condition, msg, prefix, suffix)
> +#define compiletime_assert(condition, msg) \
> +       _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> +#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> +#define BUILD_BUG_ON(condition) \
> +       BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> +
> +#define ARRAY_SIZE(a)          (sizeof (a) / sizeof ((a)[0]))
> +
> +#define MODULE_LICENSE(str)    /* str */
> +
> +typedef uint8_t                        u8;
> +typedef uint16_t               u16;
> +typedef uint32_t               u32;
> +typedef uint64_t               u64;
> +
> +#define TEST_PASS      0
> +#define TEST_SKIP      1
> +#define TEST_FAIL      2
> +struct kunit {
> +       int status;
> +       char *msg;
> +};
> +struct kunit_case {
> +        void (*run_case)(struct kunit *test);
> +        const char *name;
> +};
> +struct kunit_suite {
> +       const char *name;
> +       const struct kunit_case *test_cases;
> +};
> +#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
> +
> +#define KUNIT_ASSERT_TRUE_MSG(test, expr, fmt, ...)                    \
> +do {                                                                   \
> +       if (!(expr)) {                                                  \
> +               if (test->status != TEST_SKIP)                          \
> +                       test->status = TEST_FAIL;                       \
> +               if (test->msg)                                          \
> +                       free(test->msg);                                \
> +               asprintf(&test->msg, fmt, ##__VA_ARGS__);               \
> +               return;                                                 \
> +       }                                                               \
> +} while (0)
> +
> +#define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)               \
> +       KUNIT_ASSERT_TRUE_MSG(test, (left) == (right),                  \
> +                             #left " != " #right ": " fmt,             \
> +                             ##__VA_ARGS__)
> +
> +#define kunit_skip(test, fmt, ...)                                     \
> +do {                                                                   \
> +       test->status = TEST_SKIP;                                       \
> +       if (test->msg)                                                  \
> +               free(test->msg);                                        \
> +       asprintf(&test->msg, fmt, ##__VA_ARGS__);                       \
> +       return;                                                         \
> +} while (0)
> +
> +static int do_kunit_test_suite(struct kunit_suite *suite)
> +{
> +       const struct kunit_case *test_case;
> +       int pass = 0, fail = 0, skip = 0;
> +       int rc = 0;
> +       size_t i = 0;
> +
> +       printf("  TAP version 14\n");
> +       for (test_case = suite->test_cases; test_case->run_case; test_case++)
> +               i++;
> +       printf("  1..%zu\n", i);
> +       i = 0;
> +       for (test_case = suite->test_cases; test_case->run_case; test_case++) {
> +               struct kunit test = { };
> +
> +               i++;
> +               test_case->run_case(&test);
> +               switch (test.status) {
> +               default:
> +               case TEST_FAIL:
> +                       fprintf(stderr, "  not ok %zu - %s%s%s",
> +                               i, test_case->name,
> +                               test.msg ? " # ERROR " : "",
> +                               test.msg ?: "\n");
> +                       rc = 1;
> +                       fail++;
> +                       break;
> +               case TEST_SKIP:
> +                       fprintf(stdout, "  ok %zu - %s # SKIP%s%s",
> +                               i, test_case->name,
> +                               test.msg ? " " : "",
> +                               test.msg ?: "\n");
> +                       skip++;
> +                       break;
> +               case TEST_PASS:
> +                       fprintf(stdout, "  ok %zu - %s\n",
> +                               i, test_case->name);
> +                       pass++;
> +                       break;
> +               }
> +               if (test.msg)
> +                       free(test.msg);
> +       }
> +       printf("# %s: pass:%d fail:%d skip:%d total:%zu\n",
> +               suite->name, pass, fail, skip, i);
> +       return rc;
> +}
> +
> +static int run_suites(char *name, struct kunit_suite *suites[], size_t count)
> +{
> +       int pass = 0, fail = 0, skip = 0;
> +       int one, ret = 0;
> +       size_t i;
> +
> +       printf("TAP version 14\n");
> +       printf("1..%zu\n", count);
> +       for (i = 0; i < count; ++i) {
> +               one = do_kunit_test_suite(suites[i]);
> +               switch (one) {
> +               case TEST_SKIP:
> +                       skip++;
> +                       break;
> +               case TEST_PASS:
> +                       pass++;
> +                       break;
> +               default:
> +                       fail++;
> +                       break;
> +               }
> +               printf("%sok %zu - %s\n",
> +                       one == TEST_FAIL ? "not " : "",
> +                       i + 1, suites[i]->name);
> +               ret |= one;
> +       }
> +       printf("# %s: pass:%d fail:%d skip:%d total:%zu\n",
> +               name, pass, fail, skip, count);
> +       return ret;
> +}
> +
> +#define kunit_test_suites(suite...)                            \
> +int main(int argc, char *argv[]) {                             \
> +       static struct kunit_suite *suites[] = { suite };        \
> +       return run_suites(argv[0], suites, ARRAY_SIZE(suites)); \
> +}
> +
> +#endif /* __UAPI_MISC_KUNIT_H__ */
> diff --git a/lib/stackinit_kunit.c b/lib/stackinit_kunit.c
> index 35c69aa425b2..6d468630c90a 100644
> --- a/lib/stackinit_kunit.c
> +++ b/lib/stackinit_kunit.c
> @@ -8,7 +8,13 @@
>   *             --make_option LLVM=1 \
>   *             --kconfig_add CONFIG_INIT_STACK_ALL_ZERO=y
>   *
> + * External build example:
> + *     clang -O2 -Wall -ftrivial-auto-var-init=pattern \
> + *             -o stackinit_kunit stackinit_kunit.c
> + *     ./stackinit_kunit
> + *
>   */
> +#ifdef __KERNEL__
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
>  #include <kunit/test.h>
> @@ -17,6 +23,11 @@
>  #include <linux/module.h>
>  #include <linux/string.h>
>
> +#else
> +/* Userspace KUnit stub header. */
> +#include <misc/kunit.h>
> +#endif
> +
>  /* Exfiltration buffer. */
>  #define MAX_VAR_SIZE   128
>  static u8 check_buf[MAX_VAR_SIZE];
> --
> 2.32.0
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220227184517.504931-8-keescook%40chromium.org.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


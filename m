Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj66k-00EwLo-JY
 for linux-um@lists.infradead.org; Tue, 18 May 2021 20:14:28 +0000
Received: by mail-il1-x135.google.com with SMTP id j30so10245393ila.5
 for <linux-um@lists.infradead.org>; Tue, 18 May 2021 13:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210518035825.1885357-1-davidgow@google.com>
In-Reply-To: <20210518035825.1885357-1-davidgow@google.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Tue, 18 May 2021 13:14:11 -0700
Message-ID: <CAGS_qxoAvQpX=Q4dZe6Rynfwmete6Vek5u9VYud8zLtqonGF8w@mail.gmail.com>
Subject: Re: [PATCH] kunit: arch/um/configs: Enable KUNIT_ALL_TESTS by default
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
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, Shuah Khan <shuah@kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, KUnit Development <kunit-dev@googlegroups.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, May 17, 2021 at 8:58 PM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Make the default .kunitconfig (specified in
> arch/um/configs/kunit_defconfig) specify CONFIG_KUNIT_ALL_TESTS by
> default. KUNIT_ALL_TESTS runs all tests which have satisfied
> dependencies in the current .config (which would be the architecture
> defconfig).
>
> Currently, the default .kunitconfig enables only the example tests and
> KUnit's own tests. While this does provide a good example of what a
> .kunitconfig for running a few individual tests should look like, it
> does mean that kunit_tool runs a pretty paltry collection of tests by
> default.

From the perspective of someone trying out KUnit for the first time,
I'd personally
* try out `kunit.py run`
* then maybe grep for a test/suite name that sounds interesting.

So I'm strongly in favor of the default running a wider variety of tests.
The build and execution time is still very quick, so no complaints there.

I also think this makes the set of (most of) the existing tests more
discoverable then grepping around for #include <kunit/test.h> or
similar indicators.

But I'm also biased in that I like seeing larger numbers of tests.

>
> A default run of ./tools/testing/kunit/kunit.py run now runs 70 tests
> instead of 14.
>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Daniel Latypov <dlatypov@google.com>

> ---
>  arch/um/configs/kunit_defconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
> index 9235b7d42d38..becf3432a375 100644
> --- a/arch/um/configs/kunit_defconfig
> +++ b/arch/um/configs/kunit_defconfig
> @@ -1,3 +1,2 @@
>  CONFIG_KUNIT=y
> -CONFIG_KUNIT_TEST=y
> -CONFIG_KUNIT_EXAMPLE_TEST=y

I think it's maybe still useful to have an example of selecting a specific test.
I'd lean towards keeping one or both of these.

KUNIT_TEST might not be as clear as KUNIT_EXAMPLE_TEST, so I'd lean
towards keeping that one, if we don't want both.


> +CONFIG_KUNIT_ALL_TESTS=y
> --
> 2.31.1.751.gd2f1c929bd-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20210518035825.1885357-1-davidgow%40google.com.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


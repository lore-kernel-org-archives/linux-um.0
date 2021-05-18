Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj73e-00EyJs-R6
 for linux-um@lists.infradead.org; Tue, 18 May 2021 21:15:20 +0000
Received: by mail-pj1-x1032.google.com with SMTP id
 n6-20020a17090ac686b029015d2f7aeea8so2310694pjt.1
 for <linux-um@lists.infradead.org>; Tue, 18 May 2021 14:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210518035825.1885357-1-davidgow@google.com>
In-Reply-To: <20210518035825.1885357-1-davidgow@google.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 18 May 2021 14:15:05 -0700
Message-ID: <CAFd5g47kTYkUudpOTFW6k24yJWzgBQ63-ycksOYhqkhAW2P8kQ@mail.gmail.com>
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
Cc: Shuah Khan <shuah@kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, KUnit Development <kunit-dev@googlegroups.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, May 17, 2021 at 8:58 PM David Gow <davidgow@google.com> wrote:
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
>
> A default run of ./tools/testing/kunit/kunit.py run now runs 70 tests
> instead of 14.
>
> Signed-off-by: David Gow <davidgow@google.com>

I am totally on board with what you want to do here, but I have one
minor issue below.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  arch/um/configs/kunit_defconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
> index 9235b7d42d38..becf3432a375 100644
> --- a/arch/um/configs/kunit_defconfig
> +++ b/arch/um/configs/kunit_defconfig

Could we also apply this to
tools/testing/kunit/configs/all_tests.config ? The contents of the
file are identical, and I think are supposed to be for the same
purpose.

> @@ -1,3 +1,2 @@
>  CONFIG_KUNIT=y
> -CONFIG_KUNIT_TEST=y
> -CONFIG_KUNIT_EXAMPLE_TEST=y
> +CONFIG_KUNIT_ALL_TESTS=y
> --
> 2.31.1.751.gd2f1c929bd-goog
>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


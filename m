Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hxK1V-0002cU-QT
 for linux-um@lists.infradead.org; Mon, 12 Aug 2019 23:46:47 +0000
MIME-Version: 1.0
In-Reply-To: <20190812182421.141150-5-brendanhiggins@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-5-brendanhiggins@google.com>
Subject: Re: [PATCH v12 04/18] kunit: test: add assertion printing library
From: Stephen Boyd <sboyd@kernel.org>
Date: Mon, 12 Aug 2019 16:46:44 -0700
Message-Id: <20190812234644.E054D20679@mail.kernel.org>
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
To: Brendan Higgins <brendanhiggins@google.com>, frowand.list@gmail.com, gregkh@linuxfoundation.org, jpoimboe@redhat.com, keescook@google.com, kieran.bingham@ideasonboard.com, mcgrof@kernel.org, peterz@infradead.org, robh@kernel.org, shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com, richard@nod.at, rdunlap@infradead.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org, logang@deltatee.com

Quoting Brendan Higgins (2019-08-12 11:24:07)
> Add `struct kunit_assert` and friends which provide a structured way to
> capture data from an expectation or an assertion (introduced later in
> the series) so that it may be printed out in the event of a failure.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Just some minor nits below

> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> new file mode 100644
> index 0000000000000..55f1b88b0cb4d
> --- /dev/null
> +++ b/include/kunit/assert.h
> @@ -0,0 +1,183 @@
[...]
> +                           struct string_stream *stream);
> +
> +struct kunit_fail_assert {
> +       struct kunit_assert assert;
> +};
> +
> +void kunit_fail_assert_format(const struct kunit_assert *assert,
> +                             struct string_stream *stream);
> +
> +#define KUNIT_INIT_FAIL_ASSERT_STRUCT(test, type) {                           \
> +               .assert = KUNIT_INIT_ASSERT_STRUCT(test,                       \
> +                                                  type,                       \
> +                                                  kunit_fail_assert_format)   \

This one got indented one too many times?

> +}
> +
> +struct kunit_unary_assert {
> +       struct kunit_assert assert;
> +       const char *condition;
> +       bool expected_true;
> +};
> +
> +void kunit_unary_assert_format(const struct kunit_assert *assert,
> +                              struct string_stream *stream);
> +
[...]
> +#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,                             \
> +                                           type,                              \
> +                                           op_str,                            \
> +                                           left_str,                          \
> +                                           left_val,                          \
> +                                           right_str,                         \
> +                                           right_val) {                       \
> +       .assert = KUNIT_INIT_ASSERT_STRUCT(test,                               \
> +                                          type,                               \
> +                                          kunit_binary_str_assert_format),    \
> +       .operation = op_str,                                                   \
> +       .left_text = left_str,                                                 \
> +       .left_value = left_val,                                                \
> +       .right_text = right_str,                                               \
> +       .right_value = right_val                                               \
> +}

It would be nice to have kernel doc on these macros so we know how to
use them.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


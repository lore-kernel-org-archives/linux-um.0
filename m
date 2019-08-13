Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hxOwg-0005rY-T0
 for linux-um@lists.infradead.org; Tue, 13 Aug 2019 05:02:08 +0000
MIME-Version: 1.0
In-Reply-To: <20190813003352.GA235915@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-6-brendanhiggins@google.com>
 <20190812235701.533E82063F@mail.kernel.org>
 <20190813003352.GA235915@google.com>
Subject: Re: [PATCH v12 05/18] kunit: test: add the concept of expectations
From: Stephen Boyd <sboyd@kernel.org>
Date: Mon, 12 Aug 2019 22:02:05 -0700
Message-Id: <20190813050206.2A49C206C2@mail.kernel.org>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, peterz@infradead.org, amir73il@gmail.com, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, yamada.masahiro@socionext.com, mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, linux-nvdimm@lists.01.org, frowand.list@gmail.com, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, jpoimboe@redhat.com, kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at, gregkh@linuxfoundation.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org, logang@deltatee.com, khilman@baylibre.com

Quoting Brendan Higgins (2019-08-12 17:33:52)
> On Mon, Aug 12, 2019 at 04:57:00PM -0700, Stephen Boyd wrote:
> > Quoting Brendan Higgins (2019-08-12 11:24:08)
> > > + */
> > > +#define KUNIT_EXPECT_TRUE(test, condition) \
> > > +               KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)
> > 
> > A lot of these macros seem double indented.
> 
> In a case you pointed out in the preceding patch, I was just keeping the
> arguments column aligned.
> 
> In this case I am just indenting two tabs for a line continuation. I
> thought I found other instances in the kernel that did this early on
> (and that's also what the Linux kernel vim plugin wanted me to do).
> After a couple of spot checks, it seems like one tab for this kind of
> line continuation seems more common. I personally don't feel strongly
> about any particular version. I just want to know now what the correct
> indentation is for macros before I go through and change them all.
> 
> I think there are three cases:
> 
> #define macro0(param0, param1) \
>                 a_really_long_macro(...)
> 
> In this first case, I use two tabs for the first indent, I think you are
> telling me this should be one tab.

Yes. Should be one.

> 
> #define macro1(param0, param1) {                                               \
>         statement_in_a_block0;                                                 \
>         statement_in_a_block1;                                                 \
>         ...                                                                    \
> }
> 
> In this case, every line is in a block and is indented as it would be in
> a function body. I think you are okay with this, and now that I am
> thinking about it, what I think you are proposing for macro0 will make
> these two cases more consistent.
> 
> #define macro2(param0,                                                         \
>                param1,                                                         \
>                param2,                                                         \
>                param3,                                                         \
>                ...,                                                            \
>                paramn) ...                                                     \
> 
> In this last case, the body would be indented as in macro0, or macro1,
> but the parameters passed into the macro are column aligned, consistent
> with one of the acceptable ways of formatting function parameters that
> don't fit on a single line.
> 
> In all cases, I put 1 space in between the closing parameter paren and
> the line continuation `\`, if only one `\` is needed. Otherwise, I align
> all the `\s` to the 80th column. Is this okay, or would you prefer that
> I align them all to the 80th column, or something else?
> 

This all sounds fine and I'm not nitpicking this style. Just the double
tabs making lines longer than required.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


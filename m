Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gKCeX-0006Nz-Gs
 for linux-um@lists.infradead.org; Wed, 07 Nov 2018 01:29:09 +0000
Received: by mail-ot1-x335.google.com with SMTP id k98so3174562otk.3
 for <linux-um@lists.infradead.org>; Tue, 06 Nov 2018 17:28:55 -0800 (PST)
MIME-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com>
 <20181023235750.103146-2-brendanhiggins@google.com>
 <017b111f-d960-c1ef-46ae-eb0eb639fe5b@kernel.org>
In-Reply-To: <017b111f-d960-c1ef-46ae-eb0eb639fe5b@kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 6 Nov 2018 17:28:43 -0800
Message-ID: <CAFd5g45KNNGPVh4EBm8vKGdVhqajZZA0TU=CFbceJziYufb0Ug@mail.gmail.com>
Subject: Re: [RFC v2 01/14] kunit: test: add KUnit test runner core
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
To: shuah@kernel.org
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, Rob Herring <robh@kernel.org>, linux-nvdimm@lists.01.org, richard@nod.at, kieran.bingham@ideasonboard.com, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mcgrof@kernel.org, Daniel Vetter <daniel@ffwll.ch>, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Fri, Nov 2, 2018 at 11:44 AM Shuah Khan <shuah@kernel.org> wrote:
>
> On 10/23/2018 05:57 PM, Brendan Higgins wrote:
<snip>
> > + * Example:
> > + *
> > + * .. code-block:: c
> > + *
> > + *   void add_test_basic(struct test *test)
> > + *   {
> > + *           TEST_EXPECT_EQ(test, 1, add(1, 0));
> > + *           TEST_EXPECT_EQ(test, 2, add(1, 1));
> > + *           TEST_EXPECT_EQ(test, 0, add(-1, 1));
> > + *           TEST_EXPECT_EQ(test, INT_MAX, add(0, INT_MAX));
> > + *           TEST_EXPECT_EQ(test, -1, add(INT_MAX, INT_MIN));
> > + *   }
> > + *
> > + *   static struct test_case example_test_cases[] = {
> > + *           TEST_CASE(add_test_basic),
> > + *           {},
> > + *   };
> > + *
> > + */
> > +struct test_case {
> > +     void (*run_case)(struct test *test);
> > +     const char name[256];
> > +
> > +     /* private: internal use only. */
> > +     bool success;
> > +};
> > +
>
> Introducing a prefix kunit_* might be a good idea for the API.
> This comment applies to the rest of patches as well.

What about kunit_* instead of test_* and kmock_* instead of mock_*?
Does that seem reasonable?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


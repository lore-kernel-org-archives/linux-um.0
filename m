Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hZK6a-00028h-LG
 for linux-um@lists.infradead.org; Fri, 07 Jun 2019 19:00:50 +0000
MIME-Version: 1.0
In-Reply-To: <CAAXuY3p4qhKVsSpQ44_kQeGDMfg7OuFLgFyxhcFWS3yf-5A_7g@mail.gmail.com>
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-18-brendanhiggins@google.com>
 <20190517182254.548EA20815@mail.kernel.org>
 <CAAXuY3p4qhKVsSpQ44_kQeGDMfg7OuFLgFyxhcFWS3yf-5A_7g@mail.gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 17/18] kernel/sysctl-test: Add null pointer test for
 sysctl.c:proc_dointvec()
Date: Fri, 07 Jun 2019 12:00:47 -0700
Message-Id: <20190607190047.C3E7A20868@mail.kernel.org>
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
To: Iurii Zaikin <yzaikin@google.com>
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, peterz@infradead.org, amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, yamada.masahiro@socionext.com, mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, linux-nvdimm@lists.01.org, frowand.list@gmail.com, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, jpoimboe@redhat.com, kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at, gregkh@linuxfoundation.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org, logang@deltatee.com, khilman@baylibre.com

Quoting Iurii Zaikin (2019-06-05 18:29:42)
> On Fri, May 17, 2019 at 11:22 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-05-14 15:17:10)
> > > diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> > > new file mode 100644
> > > index 0000000000000..fe0f2bae66085
> > > --- /dev/null
> > > +++ b/kernel/sysctl-test.c
> > > +
> > > +
> > > +static void sysctl_test_dointvec_happy_single_negative(struct kunit *test)
> > > +{
> > > +       struct ctl_table table = {
> > > +               .procname = "foo",
> > > +               .data           = &test_data.int_0001,
> > > +               .maxlen         = sizeof(int),
> > > +               .mode           = 0644,
> > > +               .proc_handler   = proc_dointvec,
> > > +               .extra1         = &i_zero,
> > > +               .extra2         = &i_one_hundred,
> > > +       };
> > > +       char input[] = "-9";
> > > +       size_t len = sizeof(input) - 1;
> > > +       loff_t pos = 0;
> > > +
> > > +       table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > +       KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len, &pos));
> > > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
> > > +       KUNIT_EXPECT_EQ(test, -9, *(int *)table.data);
> >
> > Is the casting necessary? Or can the macro do a type coercion of the
> > second parameter based on the first type?
>  Data field is defined as void* so I believe casting is necessary to
> dereference it as a pointer to an array of ints. I don't think the
> macro should do any type coercion that == operator wouldn't do.
>  I did change the cast to make it more clear that it's a pointer to an
> array of ints being dereferenced.

Ok, I still wonder if we should make KUNIT_EXPECT_EQ check the types on
both sides and cause a build warning/error if the types aren't the same.
This would be similar to our min/max macros that complain about
mismatched types in the comparisons. Then if a test developer needs to
convert one type or the other they could do so with a
KUNIT_EXPECT_EQ_T() macro that lists the types to coerce both sides to
explicitly.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


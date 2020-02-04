Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iz6nE-0003Uj-T0
 for linux-um@lists.infradead.org; Tue, 04 Feb 2020 22:35:42 +0000
Received: by mail-pl1-x643.google.com with SMTP id p11so7883572plq.10
 for <linux-um@lists.infradead.org>; Tue, 04 Feb 2020 14:35:40 -0800 (PST)
MIME-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-4-brendanhiggins@google.com>
 <11977708-bb18-e322-db7a-9f21d7cdec54@gmail.com>
In-Reply-To: <11977708-bb18-e322-db7a-9f21d7cdec54@gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 4 Feb 2020 14:35:28 -0800
Message-ID: <CAFd5g47d3=drrSAOMpn_BOf8Gw94mfdJ6NrmroRf4a__=PCEWg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] kunit: test: create a single centralized executor
 for all tests
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
To: Frank Rowand <frowand.list@gmail.com>
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>, Knut Omang <knut.omang@oracle.com>, rppt@linux.ibm.com, Iurii Zaikin <yzaikin@google.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, KUnit Development <kunit-dev@googlegroups.com>, Alan Maguire <alan.maguire@oracle.com>, Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Logan Gunthorpe <logang@deltatee.com>

On Tue, Feb 4, 2020 at 2:27 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 1/30/20 5:08 PM, Brendan Higgins wrote:
> > From: Alan Maguire <alan.maguire@oracle.com>
> >
> > Add a centralized executor to dispatch tests rather than relying on
> > late_initcall to schedule each test suite separately.  Centralized
> > execution is for built-in tests only; modules will execute tests
> > when loaded.
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > Co-developed-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  include/kunit/test.h | 73 +++++++++++++++++++++++++++-----------------
> >  lib/kunit/Makefile   |  3 +-
> >  lib/kunit/executor.c | 36 ++++++++++++++++++++++
> >  3 files changed, 83 insertions(+), 29 deletions(-)
> >  create mode 100644 lib/kunit/executor.c
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 2dfb550c6723a..8a02f93a6b505 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
>
> The following fragment does not match the test.h in Linux 5.5 or 5.4-rc1 (as one
> possible earlier version).  And we are not to Linux 5.5-rc1 yet.  (Simple way
> to check for the mis-match - 5.5 has kunit_test_suite() instead of
> kunit_test_suites().)
>
> I know that there is an alternate tree where some of the development occurs.
> Can you please add a link in MAINTAINERS?  And please note (at least in
> patch 0) what tree the series is developed against?

Yep, I was planning on sending an update to the MAINTAINERS with that
and some other updates soon.

In future revisions, I will put a link to the tree I developed
against. In the meantime, we send pull-requests from here:

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=kunit

And that is what I used as my development base for this series.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k33A4-0008Fn-RK
 for linux-um@lists.infradead.org; Tue, 04 Aug 2020 20:03:49 +0000
Received: by mail-pg1-x543.google.com with SMTP id j19so23028555pgm.11
 for <linux-um@lists.infradead.org>; Tue, 04 Aug 2020 13:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-2-brendanhiggins@google.com>
 <202006261416.F4EAAE47E3@keescook>
 <CAFd5g47vu5vmrXnS0sLu+hdC2HmYz7GY82sE8rhcHfNkuC1NRw@mail.gmail.com>
 <20200708043128.GY4332@42.do-not-panic.com>
In-Reply-To: <20200708043128.GY4332@42.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 4 Aug 2020 13:03:35 -0700
Message-ID: <CAFd5g45vE7CvgEKYNJeLUiyZb=6Ps52nSqQPJ35+EyC7Y3wkdw@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] vmlinux.lds.h: add linker section for KUnit test
 suites
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
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, catalin.marinas@arm.com, jcmvbkbc@gmail.com, will@kernel.org, Paul Mackerras <paulus@samba.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>, rppt@linux.ibm.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Iurii Zaikin <yzaikin@google.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, linuxppc-dev@lists.ozlabs.org, David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, KUnit Development <kunit-dev@googlegroups.com>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Alan Maguire <alan.maguire@oracle.com>

On Tue, Jul 7, 2020 at 9:31 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Jun 26, 2020 at 02:22:11PM -0700, Brendan Higgins wrote:
> > On Fri, Jun 26, 2020 at 2:20 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Fri, Jun 26, 2020 at 02:09:06PM -0700, Brendan Higgins wrote:
> > > > Add a linker section where KUnit can put references to its test suites.
> > > > This patch is the first step in transitioning to dispatching all KUnit
> > > > tests from a centralized executor rather than having each as its own
> > > > separate late_initcall.
> > > >
> > > > Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> > > > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > > > ---
> > > >  include/asm-generic/vmlinux.lds.h | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > > > index db600ef218d7d..4f9b036fc9616 100644
> > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > +++ b/include/asm-generic/vmlinux.lds.h
> > > > @@ -881,6 +881,13 @@
> > > >               KEEP(*(.con_initcall.init))                             \
> > > >               __con_initcall_end = .;
> > > >
> > > > +/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
> > >
> > > Nit on naming:
> > >
> > > > +#define KUNIT_TEST_SUITES                                            \
> > >
> > > I would call this KUNIT_TABLE to maintain the same names as other things
> > > of this nature.
> > >
> > > > +             . = ALIGN(8);                                           \
> > > > +             __kunit_suites_start = .;                               \
> > > > +             KEEP(*(.kunit_test_suites))                             \
> > > > +             __kunit_suites_end = .;
> > > > +
> > > >  #ifdef CONFIG_BLK_DEV_INITRD
> > > >  #define INIT_RAM_FS                                                  \
> > > >       . = ALIGN(4);                                                   \
> > > > @@ -1056,6 +1063,7 @@
> > > >               INIT_CALLS                                              \
> > > >               CON_INITCALL                                            \
> > > >               INIT_RAM_FS                                             \
> > > > +             KUNIT_TEST_SUITES                                       \
> > > >       }
> > >
> > > Nack: this must be in INIT_DATA, not in INIT_DATA_SECTION. Not all
> > > architectures use the INIT_DATA_SECTION macro (e.g. arm64), but everything
> > > uses INIT_DATA.
> >
> > Oh, maybe that would eliminate the need for the other linkerscript
> > patches? That would be nice.

Sorry for the delayed response. I got pulled into some other things.

> Curious, did changing it as Kees suggest fix it for m68k?

It did! There are still some architectures I cannot test due to a lack
of GCC or QEMU support, but it seems to work on everything else now.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i0DTV-0003nE-Uh
 for linux-um@lists.infradead.org; Tue, 20 Aug 2019 23:23:39 +0000
Received: by mail-pl1-x643.google.com with SMTP id f19so248711plr.3
 for <linux-um@lists.infradead.org>; Tue, 20 Aug 2019 16:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190814055108.214253-1-brendanhiggins@google.com>
 <5b880f49-0213-1a6e-9c9f-153e6ab91eeb@kernel.org>
 <20190820182450.GA38078@google.com>
 <e8eaf28e-75df-c966-809a-2e3631353cc9@kernel.org>
 <CAFd5g44JT_KQ+OxjVdG0qMWuaEB0Zq5x=r6tLsqJdncwZ_zbGA@mail.gmail.com>
In-Reply-To: <CAFd5g44JT_KQ+OxjVdG0qMWuaEB0Zq5x=r6tLsqJdncwZ_zbGA@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 20 Aug 2019 16:23:25 -0700
Message-ID: <CAFd5g44aO40G7Wc-51EPyhWZgosN4ZHwwSjKe7CU_vi2OD7eKA@mail.gmail.com>
Subject: Re: [PATCH v13 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
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
To: shuah <shuah@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michael Ellerman <mpe@ellerman.id.au>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird, Timothy  <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt" <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>

On Tue, Aug 20, 2019 at 2:26 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Aug 20, 2019 at 12:08 PM shuah <shuah@kernel.org> wrote:
> >
> > On 8/20/19 12:24 PM, Brendan Higgins wrote:
> > > On Tue, Aug 20, 2019 at 11:24:45AM -0600, shuah wrote:
> > >> On 8/13/19 11:50 PM, Brendan Higgins wrote:
> > >>> ## TL;DR
> > >>>
> > >>> This revision addresses comments from Stephen and Bjorn Helgaas. Most
> > >>> changes are pretty minor stuff that doesn't affect the API in anyway.
> > >>> One significant change, however, is that I added support for freeing
> > >>> kunit_resource managed resources before the test case is finished via
> > >>> kunit_resource_destroy(). Additionally, Bjorn pointed out that I broke
> > >>> KUnit on certain configurations (like the default one for x86, whoops).
> > >>>
> > >>> Based on Stephen's feedback on the previous change, I think we are
> > >>> pretty close. I am not expecting any significant changes from here on
> > >>> out.
> > >>>
> > >>
> > >> Hi Brendan,
> > >>
> > >> I found checkpatch errors in one or two patches. Can you fix those and
> > >> send v14.
> > >
> > > Hi Shuah,
> > >
> > > Are you refering to the following errors?
> > >
> > > ERROR: Macros with complex values should be enclosed in parentheses
> > > #144: FILE: include/kunit/test.h:456:
> > > +#define KUNIT_BINARY_CLASS \
> > > +       kunit_binary_assert, KUNIT_INIT_BINARY_ASSERT_STRUCT
> > >
> > > ERROR: Macros with complex values should be enclosed in parentheses
> > > #146: FILE: include/kunit/test.h:458:
> > > +#define KUNIT_BINARY_PTR_CLASS \
> > > +       kunit_binary_ptr_assert, KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT
> > >
> > > These values should *not* be in parentheses. I am guessing checkpatch is
> > > getting confused and thinks that these are complex expressions, when
> > > they are not.
> > >
> > > I ignored the errors since I figured checkpatch was complaining
> > > erroneously.
> > >
> > > I could refactor the code to remove these macros entirely, but I think
> > > the code is cleaner with them.
> > >
> >
> > Please do. I am not veru sure what value these macros add.
>
> Alright, I will have something for you later today.

I just sent a new revision with the fix.

Cheers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


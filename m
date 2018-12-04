Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHbB-0002ww-IC
 for linux-um@lists.infradead.org; Tue, 04 Dec 2018 20:47:19 +0000
Received: by mail-pg1-f196.google.com with SMTP id s198so7924459pgs.2
 for <linux-um@lists.infradead.org>; Tue, 04 Dec 2018 12:47:07 -0800 (PST)
Date: Tue, 4 Dec 2018 12:47:01 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
Message-ID: <20181204204701.GT28501@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-12-brendanhiggins@google.com>
 <841cf4ae-501b-05ae-5863-a51010709b67@ideasonboard.com>
 <CAFd5g47x-UNja72k-CWPmWz9+LTn8pF8Wj5Poq+2FJ93E=vymA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFd5g47x-UNja72k-CWPmWz9+LTn8pF8Wj5Poq+2FJ93E=vymA@mail.gmail.com>
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
To: Brendan Higgins <brendanhiggins@google.com>, Kent Overstreet <kent.overstreet@gmail.com>, Matthew Wilcox <willy@infradead.org>, Eryu Guan <guaneryu@gmail.com>, Eric Sandeen <sandeen@sandeen.net>, jeffm@suse.com, Sasha Levin <Alexander.Levin@microsoft.com>
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm@lists.01.org, richard@nod.at, Knut Omang <knut.omang@oracle.com>, kieran.bingham@ideasonboard.com, Felix Guo <felixguoxiuping@gmail.com>, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, Petr Mladek <pmladek@suse.com>, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, fsdevel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, joe@perches.com, khilman@baylibre.com

On Mon, Dec 03, 2018 at 03:48:15PM -0800, Brendan Higgins wrote:
> On Thu, Nov 29, 2018 at 5:54 AM Kieran Bingham
> <kieran.bingham@ideasonboard.com> wrote:
> >
> > Hi Brendan,
> >
> > Thanks again for this series!
> >
> > On 28/11/2018 19:36, Brendan Higgins wrote:
> > > The ultimate goal is to create minimal isolated test binaries; in the
> > > meantime we are using UML to provide the infrastructure to run tests, so
> > > define an abstract way to configure and run tests that allow us to
> > > change the context in which tests are built without affecting the user.
> > > This also makes pretty and dynamic error reporting, and a lot of other
> > > nice features easier.
> >
> >
> > I wonder if we could somehow generate a shared library object
> > 'libkernel' or 'libumlinux' from a UM configured set of headers and
> > objects so that we could create binary targets directly ?
> 
> That's an interesting idea. I think it would be difficult to figure
> out exactly where to draw the line of what goes in there and what
> needs to be built specific to a test a priori. Of course, that leads
> into the biggest problem in general, needed to know what I need to
> build to test the thing that I want to test.
> 
> Nevertheless, I could definitely imagine that being useful in a lot of cases.

Whether or not we can abstract away the kernel into such a mechanism
with uml libraries is a good question worth exploring.

Developers working upstream do modify their kernels a lot, so we'd have
to update such libraries quite a bit, but I think that's fine too. The
*real* value I think from the above suggestion would be enterprise /
mobile distros or stable kernel maintainers which have a static kernel
they need to support for a relatively *long time*, consider a 10 year
time frame. Running unit tests without qemu with uml and libraries for
respective kernels seems real worthy.

The overhead for testing a unit test for said targets, *ideally*, would
just be to to reboot into the system with such libraries available, a
unit test would just look for the respective uname -r library and mimic
that kernel, much the same way enterprise distributions today rely on
having debugging symbols available to run against crash / gdb. Having
debug modules / kernel for crash requires such effort already, so this
would just be an extra layer of other prospect tests.

All ideaware for now, but the roadmap seems to be paving itself.

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


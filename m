Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTxzc-0006xb-EW
 for linux-um@lists.infradead.org; Mon, 03 Dec 2018 23:51:13 +0000
Received: by mail-oi1-x243.google.com with SMTP id c206so12693623oib.0
 for <linux-um@lists.infradead.org>; Mon, 03 Dec 2018 15:51:01 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-12-brendanhiggins@google.com>
 <20181130034425.GO18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130034425.GO18410@garbanzo.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 3 Dec 2018 15:50:48 -0800
Message-ID: <CAFd5g44L1dV61CPm9GUvOgs-tH_urN-Twm-fj=Pw6h-kgfZ5rQ@mail.gmail.com>
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
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
To: mcgrof@kernel.org
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm@lists.01.org, richard@nod.at, Knut Omang <knut.omang@oracle.com>, kieran.bingham@ideasonboard.com, Felix Guo <felixguoxiuping@gmail.com>, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Thu, Nov 29, 2018 at 7:44 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 28, 2018 at 11:36:28AM -0800, Brendan Higgins wrote:
> > The ultimate goal is to create minimal isolated test binaries; in the
> > meantime we are using UML to provide the infrastructure to run tests, so
> > define an abstract way to configure and run tests that allow us to
> > change the context in which tests are built without affecting the user.
> > This also makes pretty and dynamic error reporting, and a lot of other
> > nice features easier.
> >
> > kunit_config.py:
> >   - parse .config and Kconfig files.
> >
> >
> > kunit_kernel.py: provides helper functions to:
> >   - configure the kernel using kunitconfig.
>
> We get the tools to run the config stuff, build, etc, but not a top
> level 'make kunitconfig' or whatever. We have things like 'make
> kvmconfig' and 'make xenconfig', I think it would be reasonable to
> add similar for this.

Are you just asking for a defconfig for KUnit, or are you asking for a
way to run KUnit from make?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


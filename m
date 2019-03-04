Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h0w4L-0003ro-6O
 for linux-um@lists.infradead.org; Mon, 04 Mar 2019 22:28:22 +0000
Received: by mail-oi1-x243.google.com with SMTP id a81so5204294oii.11
 for <linux-um@lists.infradead.org>; Mon, 04 Mar 2019 14:28:17 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-9-brendanhiggins@google.com>
 <155121334527.260864.5324117081460979741@swboyd.mtv.corp.google.com>
 <CAFd5g46QCisA4PHQXo57-LC6sNdk=OUjBE0O1s4005uBz_Vo6Q@mail.gmail.com>
 <20190228135403.GD9806@kadam>
In-Reply-To: <20190228135403.GD9806@kadam>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 4 Mar 2019 14:28:05 -0800
Message-ID: <CAFd5g46iqZ6+r9BUzPLSrEmomJQfei=Bb0CH1Tb2ZDr3f1s0jQ@mail.gmail.com>
Subject: Re: [RFC v4 08/17] kunit: test: add support for test abort
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
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: brakmo@fb.com, Petr Mladek <pmladek@suse.com>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Richard Weinberger <richard@nod.at>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, "Bird, Timothy" <Tim.Bird@sony.com>, devicetree <devicetree@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, Joe Perches <joe@perches.com>, Kevin Hilman <khilman@baylibre.com>

On Thu, Feb 28, 2019 at 5:55 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Feb 28, 2019 at 01:03:24AM -0800, Brendan Higgins wrote:
> > you could do:
> >
> > if (IS_ERR_OR_NULL(ptr)) {
> >         KUNIT_FAIL(test, "ptr is an errno or null: %ld", ptr);
> >         return;
> > }
>
> It's best to not mix error pointers and NULL but when we do mix them,
> it means that NULL is a special kind of success.  Like we try to load
> a feature and we get back:
>
>     valid pointer <-- success
>     null          <-- feature is disabled.  not an error.
>     error pointer <-- feature is broken.  fail.

Thanks for pointing that out! Will fix.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


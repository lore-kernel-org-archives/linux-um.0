Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTygZ-0005gO-Fj
 for linux-um@lists.infradead.org; Tue, 04 Dec 2018 00:35:37 +0000
Received: by mail-oi1-x242.google.com with SMTP id w13so12730232oiw.9
 for <linux-um@lists.infradead.org>; Mon, 03 Dec 2018 16:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-4-brendanhiggins@google.com>
 <20181130032924.GH18410@garbanzo.do-not-panic.com>
 <20181203105517.vbedwygttxxbdtan@pathway.suse.cz>
In-Reply-To: <20181203105517.vbedwygttxxbdtan@pathway.suse.cz>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 3 Dec 2018 16:35:12 -0800
Message-ID: <CAFd5g47pWbPso4LG93ffRUZjLhxnqws5VfYc5SfFf8FbuYCWvA@mail.gmail.com>
Subject: Re: [RFC v3 03/19] kunit: test: add string_stream a std::stream like
 string builder
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
To: Petr Mladek <pmladek@suse.com>
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm@lists.01.org, richard@nod.at, Knut Omang <knut.omang@oracle.com>, kieran.bingham@ideasonboard.com, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mcgrof@kernel.org, Daniel Vetter <daniel@ffwll.ch>, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Mon, Dec 3, 2018 at 2:55 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2018-11-29 19:29:24, Luis Chamberlain wrote:
> > On Wed, Nov 28, 2018 at 11:36:20AM -0800, Brendan Higgins wrote:
> > > A number of test features need to do pretty complicated string printing
> > > where it may not be possible to rely on a single preallocated string
> > > with parameters.
> > >
> > > So provide a library for constructing the string as you go similar to
> > > C++'s std::string.
> >
> > Hrm, what's the potential for such thing actually being eventually
> > generically useful for printk folks, I wonder? Petr?
>
> printk() is a bit tricky:
>
>    + It should work in any context. Any additional lock adds risk of a
>      deadlock. Especially the NMI and scheduler contexts are problematic.
>      There are problems with any other code that might be called
>      from console drivers and calls printk() under a lock.
>
>    + It should work also when the system is out of memory. Especially
>      atomic context is problematic because we could not wait for
>      memory reclaim or swap.
>
>    + We also do to the best effort to get the message out on the
>      console. It is important when the system is about to die.
>      Any extra buffering layer might cause delay and avoid seeing the
>      message.
>
> From this point of views, this API is not generally usable with printk().

Yeah, that makes sense. I wouldn't really expect this to work well in
those cases.

> Now, the question is how many of the above fits also for unit testing.
> At least, you might need to be careful when allocating memory in
> atomic context.

True, but this is only supposed to be used for constructing
expectation failure messages which should only happen from a
non-atomic context.

>
> BTW: There are more existing printk APIs: Well, I admit the they are
> not easily reusable in unit testing:
>
>    + printk() is old, crappy code, complicated with all the
>      cornercases and consoles.
>
>    + include/linux/seq_buf.h is simple buffering. It is used primary
>      for sysfs output. It might be usable if you add support for
>      loglevel and use big enough buffer. I quess that you should
>      flush the buffer regularly anyway.
>
>    + trace_printk() uses lockless per-CPU buffers. It currently does not
>      support loglevels. But it might be pretty interesting choice as well.
>
>
> I do not say that you have to use one of the existing API. But you
> might consider them if you encouter any problems and maintaining
> your variant gets complicated.

Alright, I will take a look.

Thanks!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


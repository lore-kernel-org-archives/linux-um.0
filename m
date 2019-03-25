Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8XoV-0005kW-JY
 for linux-um@lists.infradead.org; Mon, 25 Mar 2019 22:11:29 +0000
Received: by mail-ot1-x344.google.com with SMTP id u15so9575418otq.10
 for <linux-um@lists.infradead.org>; Mon, 25 Mar 2019 15:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <CAFd5g45F3YUsAjse+Vt5hj5CLjaXrRWgr5zCZZ6CJKc0hboP6Q@mail.gmail.com>
 <0e6eb370-3e62-e1a5-1b91-bccc5868e8e4@gmail.com>
In-Reply-To: <0e6eb370-3e62-e1a5-1b91-bccc5868e8e4@gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 25 Mar 2019 15:11:14 -0700
Message-ID: <CAFd5g46ZW5PqQ1-k0gXRxZ+Zp3ukYWmhGYBz589NoFre7f+kzA@mail.gmail.com>
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
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
To: Frank Rowand <frowand.list@gmail.com>
Cc: brakmo@fb.com, Petr Mladek <pmladek@suse.com>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Richard Weinberger <richard@nod.at>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, "Bird, Timothy" <Tim.Bird@sony.com>, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, Joe Perches <joe@perches.com>, Kevin Hilman <khilman@baylibre.com>

On Thu, Mar 21, 2019 at 6:23 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 3/4/19 3:01 PM, Brendan Higgins wrote:
> > On Thu, Feb 14, 2019 at 1:38 PM Brendan Higgins
< snip >
> > Someone suggested I should send the next revision out as "PATCH"
> > instead of "RFC" since there seems to be general consensus about
> > everything at a high level, with a couple exceptions.
> >
> > At this time I am planning on sending the next revision out as "[PATCH
> > v1 00/NN] kunit: introduce KUnit, the Linux kernel unit testing
> > framework". Initially I wasn't sure if the next revision should be
> > "[PATCH v1 ...]" or "[PATCH v5 ...]". Please let me know if you have a
> > strong objection to the former.
> >
> > In the next revision, I will be dropping the last two of three patches
> > for the DT unit tests as there doesn't seem to be enough features
> > currently available to justify the heavy refactoring I did; however, I
>
> Thank you.
>
>
> > will still include the patch that just converts everything over to
> > KUnit without restructuring the test cases:
> > https://lkml.org/lkml/2019/2/14/1133
>
> The link doesn't work for me (don't worry about that), so I'm assuming
> this is:
>
>    [RFC v4 15/17] of: unittest: migrate tests to run on KUnit

That's correct.

>
> The conversation on that patch ended after:
>
>    >> After adding patch 15, there are a lot of "unittest internal error" messages.
>    >
>    > Yeah, I meant to ask you about that. I thought it was due to a change
>    > you made, but after further examination, just now, I found it was my
>    > fault. Sorry for not mentioning that anywhere. I will fix it in v5.
>
> It is not worth my time to look at patch 15 when it is that broken.  So I
> have not done any review of it.

Right, I didn't expect you to, we were still discussing things on RFC
v3 at the time. I think I got you comments on v3 in a very short time
frame around sending out v4; hence why your comments were not
addressed.

>
> So no, I think you are still in the RFC stage unless you drop patch 15.

Noted. I might split that out into a separate RFC then.

>
> >
> > I should have the next revision out in a week or so.
> >
>

Cheers!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


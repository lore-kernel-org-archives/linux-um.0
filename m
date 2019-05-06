Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hNhet-0005G1-Sh
 for linux-um@lists.infradead.org; Mon, 06 May 2019 17:44:13 +0000
Received: by mail-vs1-xe42.google.com with SMTP id r62so1867798vsc.9
 for <linux-um@lists.infradead.org>; Mon, 06 May 2019 10:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com>
 <20190502110220.GD12416@kroah.com>
 <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
 <a49c5088-a821-210c-66de-f422536f5b01@gmail.com>
 <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
 <1a5f3c44-9fa9-d423-66bf-45255a90c468@gmail.com>
 <CAFd5g45RYm+zfdJXnyp2KZZH5ojfOzy++aq+4zBeE5VDu6WgEw@mail.gmail.com>
 <052fa196-4ea9-8384-79b7-fe6bacc0ee82@gmail.com>
 <CAFd5g47aY-CL+d7DfiyTidY4aAVY+eg1TM1UJ4nYqKSfHOi-0w@mail.gmail.com>
 <63f63c7c-6185-5e64-b338-6a5e7fb9e27c@gmail.com>
In-Reply-To: <63f63c7c-6185-5e64-b338-6a5e7fb9e27c@gmail.com>
From: Kees Cook <keescook@google.com>
Date: Mon, 6 May 2019 10:43:55 -0700
Message-ID: <CAGXu5jJpp2HyEWMtAde+VUt=9ni3HRu69NM4rUQJu4kBrnx9Kw@mail.gmail.com>
Subject: Re: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
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
To: Frank Rowand <frowand.list@gmail.com>, Brendan Higgins <brendanhiggins@google.com>, Shuah Khan <shuah@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird, Timothy  <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt" <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Logan Gunthorpe <logang@deltatee.com>

On Sun, May 5, 2019 at 5:19 PM Frank Rowand <frowand.list@gmail.com> wrote:
> You can see the full version 14 document in the submitter's repo:
>
>   $ git clone https://github.com/isaacs/testanything.github.io.git
>   $ cd testanything.github.io
>   $ git checkout tap14
>   $ ls tap-version-14-specification.md
>
> My understanding is the the version 14 specification is not trying to
> add new features, but instead capture what is already implemented in
> the wild.

Oh! I didn't know about the work on TAP 14. I'll go read through this.

> > ## Here is what I propose for this patchset:
> >
> >  - Print out test number range at the beginning of each test suite.
> >  - Print out log lines as soon as they happen as diagnostics.
> >  - Print out the lines that state whether a test passes or fails as a
> > ok/not ok line.
> >
> > This would be technically conforming with TAP13 and is consistent with
> > what some kselftests have done.

This is what I fixed kselftest to actually do (it wasn't doing correct
TAP13), and Shuah is testing the series now:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=ksft-tap-refactor

I'll go read TAP 14 now...

-- 
Kees Cook

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


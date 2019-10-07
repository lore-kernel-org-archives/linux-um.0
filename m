Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHOZn-00061r-1E
 for linux-um@lists.infradead.org; Mon, 07 Oct 2019 08:41:08 +0000
Received: by mail-pg1-x541.google.com with SMTP id i14so7733068pgt.11
 for <linux-um@lists.infradead.org>; Mon, 07 Oct 2019 01:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org>
 <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org>
 <20191004232955.GC12012@mit.edu>
 <CAFd5g456rBSp177EkYAwsF+KZ0rxJa90mzUpW2M3R7tWbMAh9Q@mail.gmail.com>
 <63e59b0b-b51e-01f4-6359-a134a1f903fd@kernel.org>
 <CAFd5g47wji3T9RFmqBwt+jPY0tb83y46oj_ttOq=rTX_N1Ggyg@mail.gmail.com>
 <544bdfcb-fb35-5008-ec94-8d404a08fd14@kernel.org>
 <CAFd5g467PkfELixpU0JbaepEAAD_ugAA340-uORngC-eXsQQ-g@mail.gmail.com>
 <20191006165436.GA29585@mit.edu>
 <CAHk-=wjcJxypxUOSF-jc=SQKT1CrOoTMyT7soYzbvK3965JmCA@mail.gmail.com>
In-Reply-To: <CAHk-=wjcJxypxUOSF-jc=SQKT1CrOoTMyT7soYzbvK3965JmCA@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 7 Oct 2019 01:40:53 -0700
Message-ID: <CAFd5g45djTX+FaXwn2abve1+6GbtNrv+8EJgDe_TXn1d+pzukA@mail.gmail.com>
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michael Ellerman <mpe@ellerman.id.au>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, shuah <shuah@kernel.org>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "Bird, Timothy  <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt" <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com, "Theodore Y. Ts'o" <tytso@mit.edu>, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Kevin Hilman <khilman@baylibre.com>

On Sun, Oct 6, 2019 at 10:18 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Oct 6, 2019 at 9:55 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > Well, one thing we *can* do is if (a) if we can create a kselftest
> > branch which we know is stable and won't change, and (b) we can get
> > assurances that Linus *will* accept that branch during the next merge
> > window, those subsystems which want to use kself test can simply pull
> > it into their tree.
>
> Yes.
>
> At the same time, I don't think it needs to be even that fancy. Even
> if it's not a stable branch that gets shared between different
> developers, it would be good to just have people do a "let's try this"
> throw-away branch to use the kunit functionality and verify that
> "yeah, this is fairly convenient for ext4".
>
> It doesn't have to be merged in that form, but just confirmation that
> the infrastructure is helpful before it gets merged would be good.

I thought we already had done this satisfactorily.

We have one proof-of-concept test in the branch in the kselftest repo
(proc sysctl test) that went out in the pull request, and we also had
some other tests that were not in the pull request (there is the ext4
timestamp stuff mentioned above, and we also had one against the list
data structure), which we were planning on sending out for review once
Shuah's pull request was accepted. I know the apparmor people also
wrote some tests that they said were useful; however, I have not
coordinated with them on upstreaming their tests. I know of some other
people who are using it, but I don't think the tests are as far along
for upstreaming.

The point is: I thought we had plenty of signal that KUnit would be
useful to have merged into the mainline kernel. I thought the only
reason it was rejected for 5.4 was due to the directory name issue
combined with bad timing.

Please correct me if I missed anything.

Thanks!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


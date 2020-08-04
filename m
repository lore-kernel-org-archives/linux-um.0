Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3386-0007yf-F6
 for linux-um@lists.infradead.org; Tue, 04 Aug 2020 20:01:47 +0000
Received: by mail-pf1-x443.google.com with SMTP id l2so14904723pff.0
 for <linux-um@lists.infradead.org>; Tue, 04 Aug 2020 13:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <202006261442.5C245709@keescook>
In-Reply-To: <202006261442.5C245709@keescook>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 4 Aug 2020 13:01:30 -0700
Message-ID: <CAFd5g46auR=OgQ4j=P=KH7GDerW-SkB8aFGehuYkmgJ2Z+jGCA@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] kunit: create a centralized executor to dispatch
 all KUnit tests
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
To: Kees Cook <keescook@chromium.org>
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, catalin.marinas@arm.com, jcmvbkbc@gmail.com, will@kernel.org, Paul Mackerras <paulus@samba.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>, rppt@linux.ibm.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Iurii Zaikin <yzaikin@google.com>, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, linuxppc-dev@lists.ozlabs.org, David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, KUnit Development <kunit-dev@googlegroups.com>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Logan Gunthorpe <logang@deltatee.com>

On Fri, Jun 26, 2020 at 2:52 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 26, 2020 at 02:09:05PM -0700, Brendan Higgins wrote:
> > This patchset adds a centralized executor to dispatch tests rather than
> > relying on late_initcall to schedule each test suite separately along
> > with a couple of new features that depend on it.

Sorry it took so long to reply. I got sucked into some other stuff again.

> So, the new section looks fine to me (modulo the INIT_DATA change). The
> plumbing to start the tests, though, I think is redundant. Why not just
> add a sysctl that starts all known tests?

We already have that; however, we use debugfs to start the tests -
same difference. I just find it convenient to not have to build and
then maintain a userland for each architecture. It's also really nice
that KUnit "just works out of the box" - you don't have to download
anything other than the kernel source, and you don't need to do any
steps outside of just run "kuit.py run". That seems like a big
advantage to me.

> That way you don't need the plumbing into init/main.c, and you can have
> a mode where builtin tests can be started on a fully booted system too.
>
> i.e. boot with "sysctl.kernel.kunit=start" or when fully booted with
> "echo start > /proc/sys/kernel/kunit"
>
> And instead of the kunit-specific halt/reboot stuff, how about moving
> /proc/sysrq-trigger into /proc/sys instead? Then you (or anything) could
> do:
>
> sysctl.kernel.kunit=start sysctl.kernel.sysrq-trigger=b

I think it might be harder to make a case for the reboot stuff without
the stuff I am working on outside of this patchset. I think I will
probably drop that patch from this patchset and reintroduce it later.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


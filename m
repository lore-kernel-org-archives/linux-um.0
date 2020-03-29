Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIfe5-0008Pa-SD
 for linux-um@lists.infradead.org; Sun, 29 Mar 2020 21:39:07 +0000
Received: by mail-wr1-x441.google.com with SMTP id m11so12973476wrx.10
 for <linux-um@lists.infradead.org>; Sun, 29 Mar 2020 14:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200305183939.256241-1-davidgow@google.com>
 <CAFd5g45XJLXYfXB-FJhFYnBYUdqM4ztC=p=Akj3+GbHXfHxzgQ@mail.gmail.com>
In-Reply-To: <CAFd5g45XJLXYfXB-FJhFYnBYUdqM4ztC=p=Akj3+GbHXfHxzgQ@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 29 Mar 2020 23:38:53 +0200
Message-ID: <CAFLxGvw6Sp899NN3CMvC4R9Uz1dSiKw4mdwnKRUvnGg-mr7ttw@mail.gmail.com>
Subject: Re: [PATCH] um: Fix overlapping ELF segments when statically linked
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Patricia Alfonso <trishalfonso@google.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Gow <davidgow@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Tue, Mar 10, 2020 at 10:24 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Thu, Mar 5, 2020 at 10:39 AM David Gow <davidgow@google.com> wrote:
> >
> > When statically linked, the .text section in UML kernels is not page
> > aligned, causing it to share a page with the executable headers. As
> > .text and the executable headers have different permissions, this causes
> > the kernel to wish to map the same page twice (once as headers with r--
> > permissions, once as .text with r-x permissions), causing a segfault,
> > and a nasty message printed to the host kernel's dmesg:
> >
> > "Uhuuh, elf segment at 0000000060000000 requested but the memory is
> > mapped already"
> >
> > By aligning the .text to a page boundary (as in the dynamically linked
> > version in dyn.lds.S), there is no such overlap, and the kernel runs
> > correctly.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> I can confirm that I am seeing this problem as well. (I know we run
> the same Linux distro; nevertheless, this is a real problem for some
> population of users.)
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Applied, thanks!

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


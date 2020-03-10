Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBmMe-0006Cg-SW
 for linux-um@lists.infradead.org; Tue, 10 Mar 2020 21:24:38 +0000
Received: by mail-pj1-x1042.google.com with SMTP id d8so982402pje.4
 for <linux-um@lists.infradead.org>; Tue, 10 Mar 2020 14:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200305183939.256241-1-davidgow@google.com>
In-Reply-To: <20200305183939.256241-1-davidgow@google.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 10 Mar 2020 14:24:22 -0700
Message-ID: <CAFd5g45XJLXYfXB-FJhFYnBYUdqM4ztC=p=Akj3+GbHXfHxzgQ@mail.gmail.com>
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
To: David Gow <davidgow@google.com>
Cc: Patricia Alfonso <trishalfonso@google.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Thu, Mar 5, 2020 at 10:39 AM David Gow <davidgow@google.com> wrote:
>
> When statically linked, the .text section in UML kernels is not page
> aligned, causing it to share a page with the executable headers. As
> .text and the executable headers have different permissions, this causes
> the kernel to wish to map the same page twice (once as headers with r--
> permissions, once as .text with r-x permissions), causing a segfault,
> and a nasty message printed to the host kernel's dmesg:
>
> "Uhuuh, elf segment at 0000000060000000 requested but the memory is
> mapped already"
>
> By aligning the .text to a page boundary (as in the dynamically linked
> version in dyn.lds.S), there is no such overlap, and the kernel runs
> correctly.
>
> Signed-off-by: David Gow <davidgow@google.com>

I can confirm that I am seeing this problem as well. (I know we run
the same Linux distro; nevertheless, this is a real problem for some
population of users.)

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


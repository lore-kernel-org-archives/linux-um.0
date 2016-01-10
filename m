Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1450470533-13115-1-git-send-email-vegard.nossum@oracle.com>
References: <1450470533-13115-1-git-send-email-vegard.nossum@oracle.com>
Date: Sun, 10 Jan 2016 16:49:13 +0100
Message-ID: <CAFLxGvz=CCv5eqJNbMKrPG5FKY89CtZVUwWE=O7d2oQRVqe9=Q@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] uml: flush stdout before forking
From: Richard Weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Dec 18, 2015 at 9:28 PM, Vegard Nossum <vegard.nossum@oracle.com> wrote:
> I was seeing some really weird behaviour where piping UML's output
> somewhere would cause output to get duplicated:
>
>   $ ./vmlinux | head -n 40
>   Checking that ptrace can change system call numbers...Core dump limits :
>           soft - 0
>           hard - NONE
>   OK
>   Checking syscall emulation patch for ptrace...Core dump limits :
>           soft - 0
>           hard - NONE
>   OK
>   Checking advanced syscall emulation patch for ptrace...Core dump limits :
>           soft - 0
>           hard - NONE
>   OK
>   Core dump limits :
>           soft - 0
>           hard - NONE
>
> This is because these tests do a fork() which duplicates the non-empty
> stdout buffer, then glibc flushes the duplicated buffer as each child
> exits.
>
> A simple workaround is to flush before forking.
>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

Applied and queued for stable!

-- 
Thanks,
//richard


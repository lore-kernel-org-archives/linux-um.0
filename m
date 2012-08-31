Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5040AAAE.30501@gmail.com>
References: <5040AAAE.30501@gmail.com>
Date: Fri, 31 Aug 2012 14:27:09 +0200
Message-ID: <CAFLxGvxh962CZxgF86nL2ULsy-a2BRXFszDHceeSsZm0DTJgfg@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: 3.6rc-3 doesn't compile um arch
To: Marco Stornelli <marco.stornelli@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, torvalds@linux-foundation.org, Linux Kernel <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, martin.partel@gmail.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Aug 31, 2012 at 2:14 PM, Marco Stornelli
<marco.stornelli@gmail.com> wrote:
> Hi,
>
> I'm trying to compile the latest kernel for arch um, using the latest
> Linus's tree, but it doesn't compile due to the commit:
>
> um: pass siginfo to the guest process.
>
> I think the fix is trivial. At line 117 of os-Linux/time.c you find
> this line:
>
>   alarm_handler(SIGVTALRM, NULL);
>
> but it should be:
>
>   alarm_handler(SIGVTALRM, NULL, NULL);
>
> Is it already fixed?

It's known but nobody cared to send a fix for that.
Who wants the credit?

Otherwise I'll fix it in -rc4 or 5.
(Currently I'm on holiday...)

-- 
Thanks,
//richard

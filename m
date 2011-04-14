Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201104132150.05623.richard@nod.at>
References: <201104132150.05623.richard@nod.at>
Date: Thu, 14 Apr 2011 21:43:23 +0700
Message-ID: <BANLkTinj1vtMk4qo-dc46KWXScjDDt4vCg@mail.gmail.com>
From: masterkom masterkom <masterkom33@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: gcc-4.6.0 generates no code for sub_preempt_count()
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi,, I have the project to make Operating System using linux kernel.
That system is multiplatform, which is combine linux and window . This
project hope All people that who has familiar with windows can use
this operating system without sin. This project is free..

I hape there people can help us to done this project ,, thx,,,

On 4/14/11, Richard Weinberger <richard@nod.at> wrote:
> Hi,
>
> I'm facing a very strange issue with gcc-4.6.0 and UML.
> Within __local_bh_enable() gcc generates no code for sub_preempt_count().
>
> See:
> http://userweb.kernel.org/~rw/uml-gcc460/__local_bh_enable-gcc460.txt
> vs.
> http://userweb.kernel.org/~rw/uml-gcc460/__local_bh_enable-gcc431.txt
>
> Interestingly it generates code for add_preempt_count().
> I can reproduce this on x86 and x86_64.
>
> The problem has to do with UML's current_thread_info() function.
> When I replace it with arch/x86's (unportable) variant gcc generates code.
>
> Any ideas whether this is a gcc or a kernel issue?
> Thanks,
> //richard
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

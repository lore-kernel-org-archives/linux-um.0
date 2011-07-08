Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Fri, 8 Jul 2011 12:22:48 +0200
References: <1310056668.3528.51.camel@vivanov> <201107071848.50411.richard@nod.at> <CAGTPOqfT=L4s8-db58mCRXQFvuYOVwNsNDfc4YuRaO7azpZa4A@mail.gmail.com>
In-Reply-To: <CAGTPOqfT=L4s8-db58mCRXQFvuYOVwNsNDfc4YuRaO7azpZa4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201107081222.48376.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 3/3] uml: os-Linux/main.c memory leak fix
To: Vitaliy Ivanov <vitalivanov@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Freitag 08 Juli 2011, 12:16:20 schrieb Vitaliy Ivanov:
> On Thu, Jul 7, 2011 at 7:48 PM, Richard Weinberger <richard@nod.at> wrote:
> > Am Donnerstag 07 Juli 2011, 18:37:48 schrieb Vitaliy Ivanov:
> >> >From 6db3c87f57e3e61d968da79f01fb21ba17fd5bc0 Mon Sep 17 00:00:00 2001
> >> 
> >> From: Vitaliy Ivanov <vitalivanov@gmail.com>
> >> Date: Thu, 7 Jul 2011 19:29:06 +0300
> >> Subject: [PATCH 3/3] uml: os-Linux/main.c memory leak fix
> >> 
> >> We should cleanup memory even though 'putenv' fails.
> >> 
> >> Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
> >> ---
> >>  arch/um/os-Linux/main.c |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >> 
> >> diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
> >> index fb2a97a..67fe012 100644
> >> --- a/arch/um/os-Linux/main.c
> >> +++ b/arch/um/os-Linux/main.c
> >> @@ -107,8 +107,8 @@ static void setup_env_path(void)
> >>       snprintf(new_path, path_len, "PATH=%s" UML_LIB_PATH, old_path);
> >>       if (putenv(new_path)) {
> >>               perror("couldn't putenv to set a new PATH");
> >> -             free(new_path);
> >>       }
> >> +     free(new_path);
> > 
> > Uhhh, this will kill the PATH variable.
> > putenv() does not copy the string...
> 
> That's actually depends on the version of glibc that you use. But yes,
> agree, my fault. Please drop this one.
> I hope I'm not in your shit-list already.:)

No problem. :)

> BTW, you said that you will share your git tree on kernel.org, is
> there any news? I'm tracking what patches are accepted not to resend
> them again.

Yeah, I'll announce it on user-mode-linux-devel@lists.sourceforge.net.
It's done when it's done. :-P

Thanks,
//richard


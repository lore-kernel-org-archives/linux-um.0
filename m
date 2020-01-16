Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1is0rt-0007bW-Oo
 for linux-um@lists.infradead.org; Thu, 16 Jan 2020 08:51:15 +0000
Received: by mail-qk1-x743.google.com with SMTP id z14so18395743qkg.9
 for <linux-um@lists.infradead.org>; Thu, 16 Jan 2020 00:51:05 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
In-Reply-To: <20200115182816.33892-1-trishalfonso@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 16 Jan 2020 09:50:53 +0100
Message-ID: <CACT4Y+aLYjJmGHPGN=vRTv9LUxC1uxR1CkP_rrY0958cpQaqhg@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
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
To: Patricia Alfonso <trishalfonso@google.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Brendan Higgins <brendanhiggins@google.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, anton.ivanov@cambridgegreys.com

On Wed, Jan 15, 2020 at 7:28 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
>
> Make KASAN run on User Mode Linux on x86_64.
> diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> index 5aa882011e04..f783a7dd863c 100644
> --- a/arch/um/kernel/Makefile
> +++ b/arch/um/kernel/Makefile
> @@ -8,6 +8,9 @@
>  # kernel.
>  KCOV_INSTRUMENT                := n
>
> +# Do not instrument on main.o

It's always good to explain why. Otherwise it will be stuck there
forever because nobody really knows why and if they will break
something by removing it.
This comment is also somewhat confusing. We don't instrument the whole
dir, not just main.c? Should we ignore just this single file as
comment says?

> +KASAN_SANITIZE := n
> +

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


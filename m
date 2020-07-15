Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvcvp-0000GK-A7
 for linux-um@lists.infradead.org; Wed, 15 Jul 2020 08:38:25 +0000
Received: by mail-pl1-x641.google.com with SMTP id x8so2092340plm.10
 for <linux-um@lists.infradead.org>; Wed, 15 Jul 2020 01:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200704085213.444645-1-ignat@cloudflare.com>
 <20200704085213.444645-2-ignat@cloudflare.com>
In-Reply-To: <20200704085213.444645-2-ignat@cloudflare.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 15 Jul 2020 01:38:12 -0700
Message-ID: <CAFd5g45jR3tRfWhGiX931xh4=aScrfp0buHyRSWWH78NdTHSVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] um/kconfig: introduce
 CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
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
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: kernel-team@cloudflare.com, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Sat, Jul 4, 2020 at 1:52 AM Ignat Korchagin <ignat@cloudflare.com> wrote:
>
> For statically linked UML build it is important to take into account the
> standard C-library implementation. Some implementations, notably glibc have
> caveats: even when linked statically, the final program might require some
> runtime dependencies, if certain functions are used within the code.
>
> Consider the following program:
> int main(void)
> {
>         getpwent();
>         return 0;
> }
>
> Compiling this program and linking statically with glibc produces the following
> warning from the linker:
> /usr/sbin/ld: /tmp/ccuthw1o.o: in function `main':
> test.c:(.text+0x5): warning: Using 'getpwent' in statically linked
> applications requires at runtime the shared libraries from the glibc version
> used for linking
>
> We will use the flag to detect such C-library implementation build time and
> possibly disable static linking for UML to avoid producing a binary with
> unexpected behaviour and dependencies.
>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

Nice.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


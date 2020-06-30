Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqP2J-0007L7-8T
 for linux-um@lists.infradead.org; Tue, 30 Jun 2020 22:47:32 +0000
Received: by mail-pf1-x442.google.com with SMTP id q17so10064547pfu.8
 for <linux-um@lists.infradead.org>; Tue, 30 Jun 2020 15:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200624212319.403689-1-ignat@cloudflare.com>
In-Reply-To: <20200624212319.403689-1-ignat@cloudflare.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 30 Jun 2020 15:47:15 -0700
Message-ID: <CAFd5g47asdiBPdkQjTQ3-+Rwn+cE-pp1CcB41aV=bvvBZw2ePg@mail.gmail.com>
Subject: Re: [RFC PATCH] Revert "um: Make CONFIG_STATIC_LINK actually static"
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
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Wed, Jun 24, 2020 at 2:23 PM Ignat Korchagin <ignat@cloudflare.com> wrote:
>
> This reverts commit 3363179385629c1804ea846f4e72608c2201a81e.
>
> This change is too restrictive. I've been running UML statically linked kernel
>  with UML_NET_VECTOR networking in a docker "FROM: scratch" container just fine.
> As long as we don't reference network peers by hostname and use only IP
> addresses, NSS is not needed, so not used. In other words, it is possible to
> have statically linked UML and UML_NET_VECTOR (and other networking types) and
> use it, although with some restrictions, so let's not disable it.
>
> Additionally, it should be at least theoretically possible to use another libc
> (like musl, bionic etc) for static linking. I was able with some hacks to
> compile UML against musl, although the executable segfaults for now. But this
> option prevents even the research to be done.

The reason that we removed support for static linking when these
networking options are enabled is because gcc doesn't support loading
NSS when statically linked, which consequently breaks allyesconfig for
UML under gcc. That is still the case with your revert.

I fully support the goal behind what you are trying to do. However, I
do not want to see this patch accepted unless it is accompanied by an
alternative change that still allows UML to compile under
allyesconfig.

You said that in the current state, researching a solution is
possible? Can you not research a solution with your patch applied to
your own branch?

Cheers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


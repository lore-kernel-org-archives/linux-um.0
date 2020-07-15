Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvcuV-0008Ra-VV
 for linux-um@lists.infradead.org; Wed, 15 Jul 2020 08:37:05 +0000
Received: by mail-pj1-x1042.google.com with SMTP id ls15so2740768pjb.1
 for <linux-um@lists.infradead.org>; Wed, 15 Jul 2020 01:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200704085213.444645-1-ignat@cloudflare.com>
In-Reply-To: <20200704085213.444645-1-ignat@cloudflare.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 15 Jul 2020 01:36:49 -0700
Message-ID: <CAFd5g44QK2L+Zkri9=mTFoLXTqdjORn-QATPomiKXkgZfA+wqw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] um: allow static linking for non-glibc libc
 implementations
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
> This is a continuation of [1]. Since I was able to produce a working UML binary
> with UML_NET_VECTOR linked with musl with the changes included in the patches
> here. I was compiling on Arch Linux, so hopefully all the latest versions of
> the compiler, libraries and binutils.
>
> I also tested allyesconfig with both musl and glibc. The compilation succeeds
> with both, however both binaries (glibc one being dynamically linked) segfault
> on start. This is probably of some incompatible config option/module being
> included and not related to musl/glibc.
>
> [1]: https://patchwork.ozlabs.org/project/linux-um/patch/20200624212319.403689-1-ignat@cloudflare.com/
>
> Ignat Korchagin (3):
>   um/kconfig: introduce CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
>   um: some fixes to build UML with musl
>   um: allow static linking for non-glibc implementations
>
>  arch/um/Kconfig               |  2 +-
>  arch/um/drivers/Kconfig       |  3 ---
>  arch/um/drivers/daemon_user.c |  1 +
>  arch/um/drivers/pcap_user.c   | 12 ++++++------
>  arch/um/drivers/slip_user.c   |  2 +-
>  arch/um/drivers/vector_user.c |  4 +---
>  arch/um/os-Linux/util.c       |  2 +-
>  arch/x86/um/user-offsets.c    |  2 +-
>  init/Kconfig                  |  6 ++++++
>  scripts/cc-can-link.sh        |  5 +++--
>  10 files changed, 21 insertions(+), 18 deletions(-)

Sorry for taking so long to get to this. I saw this last week or
whenever and then forgot, saw the comments yesterday and remembered.

Looks pretty good overall. I will put my reviewed-by on each
individual patch. Nevertheless, I tested them all together, so being
lazy:

Tested-by: Brendan Higgins <brendanhiggins@google.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


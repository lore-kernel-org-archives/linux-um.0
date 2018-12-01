Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT6dR-0003M6-Jg
 for linux-um@lists.infradead.org; Sat, 01 Dec 2018 14:52:47 +0000
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id wB1EqImg020073
 for <linux-um@lists.infradead.org>; Sat, 1 Dec 2018 23:52:19 +0900
Received: by mail-vs1-f53.google.com with SMTP id t17so5079040vsc.8
 for <linux-um@lists.infradead.org>; Sat, 01 Dec 2018 06:52:18 -0800 (PST)
MIME-Version: 1.0
References: <1543460330-2219-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1543460330-2219-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 1 Dec 2018 23:51:42 +0900
Message-ID: <CAK7LNAQN7A=P0T7ON0LvENxs6rpUqonu9S0GcQwHP6HaPt2fQA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix UML build error with CONFIG_GCC_PLUGINS
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
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>, Kees Cook <keescook@chromium.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, X86 ML <x86@kernel.org>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Emese Revfy <re.emese@gmail.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>

On Thu, Nov 29, 2018 at 12:01 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> UML fails to build with CONFIG_GCC_PLUGINS=y.
>
> $ make -s ARCH=um mrproper
> $ make -s ARCH=um allmodconfig
> $ make ARCH=um
>   UPD     include/generated/uapi/linux/version.h
>   WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
>   WRAP    arch/x86/include/generated/uapi/asm/poll.h
>   WRAP    arch/x86/include/generated/asm/dma-contiguous.h
>   WRAP    arch/x86/include/generated/asm/early_ioremap.h
>   WRAP    arch/x86/include/generated/asm/export.h
>   WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
>   WRAP    arch/x86/include/generated/asm/mm-arch-hooks.h
>   SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
>   SYSHDR  arch/x86/include/generated/asm/unistd_32_ia32.h
>   SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
>   SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
>   SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
>   SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
>   SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
>   HOSTCC  scripts/unifdef
>   CC      arch/x86/um/user-offsets.s
> cc1: error: cannot load plugin ./scripts/gcc-plugins/cyc_complexity_plugin.so
> ./scripts/gcc-plugins/cyc_complexity_plugin.so: cannot open shared object file: No such file or directory
> cc1: error: cannot load plugin ./scripts/gcc-plugins/structleak_plugin.so
> ./scripts/gcc-plugins/structleak_plugin.so: cannot open shared object file: No such file or directory
> cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy_plugin.so
> ./scripts/gcc-plugins/latent_entropy_plugin.so: cannot open shared object file: No such file or directory
> cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so
> ./scripts/gcc-plugins/randomize_layout_plugin.so: cannot open shared object file: No such file or directory
> make[1]: *** [scripts/Makefile.build;119: arch/x86/um/user-offsets.s] Error 1
> make: *** [arch/um/Makefile;152: arch/x86/um/user-offsets.s] Error 2
>
> Change the order of the preparation stage (with cleanups) to make sure
> gcc-plugins is built before descending to arch/x86/um/.
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 6b90bd4ba40b ("GCC plugin infrastructure")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild.


>
> I will pick up this to kbuild tree to avoid conflicts.
> Ack from UML people is appreciated, though.
>
>
-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


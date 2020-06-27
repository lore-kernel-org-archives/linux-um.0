Return-Path: <green.hu@gmail.com>
MIME-Version: 1.0
References: <20200622234326.906346-1-christian.brauner@ubuntu.com> <20200622234326.906346-17-christian.brauner@ubuntu.com>
In-Reply-To: <20200622234326.906346-17-christian.brauner@ubuntu.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Sat, 27 Jun 2020 11:06:08 +0800
Message-ID: <CAEbi=3f3o5jS7zZDo50Vq857mS9n9kDsxkseGKrWshmmp3q5wA@mail.gmail.com>
Subject: Re: [PATCH 16/17] arch: remove HAVE_COPY_THREAD_TLS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Brian Cain <bcain@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Vincent Chen <deanbo422@gmail.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Guan Xuetao <gxt@pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>, Mike Rapoport <rppt@linux.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-riscv@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>, linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

Christian Brauner <christian.brauner@ubuntu.com> =E6=96=BC 2020=E5=B9=B46=
=E6=9C=8823=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=887:46=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> All architectures support copy_thread_tls() now, so remove the legacy
> copy_thread() function and the HAVE_COPY_THREAD_TLS config option. Everyo=
ne
> uses the same process creation calling convention based on
> copy_thread_tls() and struct kernel_clone_args. This will make it easier =
to
> maintain the core process creation code under kernel/, simplifies the
> callpaths and makes the identical for all architectures.
>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Brian Cain <bcain@codeaurora.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Nick Hu <nickhu@andestech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Rich Felker <dalias@libc.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: x86@kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: "Matthew Wilcox
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: linux-csky@vger.kernel.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: openrisc@lists.librecores.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-xtensa@linux-xtensa.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> [...]
> diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
> index 7b6eaca81cce..e30298e99e1b 100644
> --- a/arch/nds32/Kconfig
> +++ b/arch/nds32/Kconfig
> @@ -48,7 +48,6 @@ config NDS32
>         select HAVE_FUNCTION_GRAPH_TRACER
>         select HAVE_FTRACE_MCOUNT_RECORD
>         select HAVE_DYNAMIC_FTRACE
> -       select HAVE_COPY_THREAD_TLS
>         help
>           Andes(nds32) Linux support.

Hi Christian, Thank you.
Acked-by: Greentime Hu <green.hu@gmail.com>


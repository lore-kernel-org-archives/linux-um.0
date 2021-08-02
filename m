Return-Path: <jcmvbkbc@gmail.com>
MIME-Version: 1.0
References: <20210731052233.4703-1-masahiroy@kernel.org> <20210731052233.4703-2-masahiroy@kernel.org>
In-Reply-To: <20210731052233.4703-2-masahiroy@kernel.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 2 Aug 2021 11:03:57 -0700
Message-ID: <CAMo8BfLDjw71xiCDo8uk4pQFuOzqAoak0k3R4YJDnRsA2hoCtw@mail.gmail.com>
Subject: Re: [PATCH 2/3] trace: refactor TRACE_IRQFLAGS_SUPPORT in Kconfig
Content-Type: text/plain; charset="UTF-8"
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Linus Walleij <linus.walleij@linaro.org>, Ley Foon Tan <ley.foon.tan@intel.com>, "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, linux-mips@vger.kernel.org, "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Nick Hu <nickhu@andestech.com>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-riscv@lists.infradead.org, YiFei Zhu <yifeifz2@illinois.edu>, Greentime Hu <green.hu@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Michal Simek <monstr@monstr.eu>, Helge Deller <deller@gmx.de>, "open list:SUPERH" <linux-sh@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Guo Ren <guoren@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Richard Weinberger <richard@nod.at>, Christian Borntraeger <borntraeger@de.ibm.com>, Rich Felker <dalias@libc.org>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-s390 <linux-s390@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, linux-um@lists.infradead.org, Andrey Konovalov <andreyknvl@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Brian Cain <bcain@codeaurora.org>, linux-csky@vger.kernel.org, Stafford Horne <shorne@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, Chris Zankel <chris@zankel.net>, Vasily Gorbik <gor@linux.ibm.com>, linux-snps-arc@lists.infradead.org, Jonas Bonn <jonas@southpole.se>, "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Colin Ian King <colin.king@canonical.com>, "David S. Miller" <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Mark Rutland <mark.rutland@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org
List-ID: <linux-um.lists.infradead.org>

On Fri, Jul 30, 2021 at 10:24 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Make architectures select TRACE_IRQFLAGS_SUPPORT instead of
> having many defines.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>  arch/xtensa/Kconfig           | 4 +---

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
-- 
Thanks.
-- Max


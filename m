Return-Path: <palmer@dabbelt.com>
Date: Tue, 24 Aug 2021 20:49:37 -0700 (PDT)
Subject: Re: [PATCH 2/3] trace: refactor TRACE_IRQFLAGS_SUPPORT in Kconfig
In-Reply-To: <20210731052233.4703-2-masahiroy@kernel.org>
From: Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <mhng-fae2ea79-c261-4e5d-8eae-21e60810a957@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: rostedt@goodmis.org, mingo@redhat.com, masahiroy@kernel.org, Arnd Bergmann <arnd@arndb.de>, ardb@kernel.org, bp@alien8.de, linus.walleij@linaro.org, ley.foon.tan@intel.com, x86@kernel.org, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, anshuman.khandual@arm.com, nickhu@andestech.com, tglx@linutronix.de, rppt@kernel.org, geert@linux-m68k.org, peterz@infradead.org, catalin.marinas@arm.com, linux-riscv@lists.infradead.org, yifeifz2@illinois.edu, green.hu@gmail.com, monstr@monstr.eu, deller@gmx.de, linux-sh@vger.kernel.org, vgupta@synopsys.com, u.kleine-koenig@pengutronix.de, guoren@kernel.org, samitolvanen@google.com, richard@nod.at, borntraeger@de.ibm.com, dalias@libc.org, aou@eecs.berkeley.edu, hca@linux.ibm.com, jdike@addtoit.com, jcmvbkbc@gmail.com, linux-hexagon@vger.kernel.org, linux-xtensa@linux-xtensa.org, hpa@zytor.com, will@kernel.org, tsbogend@alpha.franken.de, stefan.kristiansson@saunalahti.fi, linux-s390@vger.kernel.org, ysato@users.sourceforge.jp, James.Bottomley@HansenPartnership.com, linux-um@lists.infradead.org, andreyknvl@gmail.com, frederic@kernel.org, npiggin@gmail.com, benh@kernel.crashing.org, bcain@codeaurora.org, linux-csky@vger.kernel.org, shorne@gmail.com, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, chris@zankel.net, gor@linux.ibm.com, linux-snps-arc@lists.infradead.org, jonas@southpole.se, linux-parisc@vger.kernel.org, keescook@chromium.org, krzysztof.kozlowski@canonical.com, colin.king@canonical.com, davem@davemloft.net, linux-kernel@vger.kernel.org, deanbo422@gmail.com, anton.ivanov@cambridgegreys.com, akpm@linux-foundation.org, mpe@ellerman.id.au, paulus@samba.org, mark.rutland@arm.com, viresh.kumar@linaro.org, linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org
List-ID: <linux-um.lists.infradead.org>

On Fri, 30 Jul 2021 22:22:32 PDT (-0700), masahiroy@kernel.org wrote:
> Make architectures select TRACE_IRQFLAGS_SUPPORT instead of
> having many defines.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/riscv/Kconfig            | 4 +---

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!


Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
MIME-Version: 1.0
References: <20190401134104.676620247@goodmis.org>
 <20190401134421.278590567@goodmis.org>
In-Reply-To: <20190401134421.278590567@goodmis.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 4 Apr 2019 11:56:23 -0700
Message-ID: <CAMo8BfK8gdgni3z3PKv1rd0KPFMXgDCpicQQ_obuoDAEz3PkZQ@mail.gmail.com>
Subject: Re: [PATCH 5/6 v3] syscalls: Remove start and number from
 syscall_get_arguments() args
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Peter Zijlstra <peterz@infradead.org>, Palmer Dabbelt <palmer@sifive.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Oleg Nesterov <oleg@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>, linux-riscv@lists.infradead.org, Ingo Molnar <mingo@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-c6x-dev@linux-c6x.org, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, Dave Martin <dave.martin@arm.com>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Roland McGrath <roland@hack.frob.com>, linux-um@lists.infradead.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Dmitry V. Levin" <ldv@altlinux.org>, linux-arm-kernel@lists.infradead.org, "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, "Eric W. Biederman" <ebiederm@xmission.com>, nios2-dev@lists.rocketboards.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Apr 1, 2019 at 6:45 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
>
> At Linux Plumbers, Andy Lutomirski approached me and pointed out that the
> function call syscall_get_arguments() implemented in x86 was horribly
> written and not optimized for the standard case of passing in 0 and 6 for
> the starting index and the number of system calls to get. When looking at
> all the users of this function, I discovered that all instances pass in only
> 0 and 6 for these arguments. Instead of having this function handle
> different cases that are never used, simply rewrite it to return the first 6
> arguments of a system call.
>
> This should help out the performance of tracing system calls by ptrace,
> ftrace and perf.

[...]

>  arch/xtensa/include/asm/syscall.h     | 16 ++----

For xtensa changes:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


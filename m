Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
MIME-Version: 1.0
References: <20190401134104.676620247@goodmis.org>
 <20190401134421.442323029@goodmis.org>
In-Reply-To: <20190401134421.442323029@goodmis.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 4 Apr 2019 11:55:29 -0700
Message-ID: <CAMo8BfLooVJgKCPQFDXUAfieH3XAF=Bhz2PmAb+3t7BhVBW5FQ@mail.gmail.com>
Subject: Re: [PATCH 6/6 v3] syscalls: Remove start and number from
 syscall_set_arguments() args
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
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> After removing the start and count arguments of syscall_get_arguments() it
> seems reasonable to remove them from syscall_set_arguments(). Note, as of
> today, there are no users of syscall_set_arguments(). But we are told that
> there will be soon. But for now, at least make it consistent with
> syscall_get_arguments().

[...]

>  arch/xtensa/include/asm/syscall.h     | 17 ++-----

For xtensa changes:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


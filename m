Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170311194702.28754-7-khuey@kylehuey.com>
References: <20170311194702.28754-1-khuey@kylehuey.com> <20170311194702.28754-7-khuey@kylehuey.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 Mar 2017 14:47:02 -0700
Message-ID: <CA+55aFxGYA_MnVnmtqfX+AW3hE-KE9Bvev65urRKCA7BgmRiOA@mail.gmail.com>
Subject: Re: [PATCH v15 6/9] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, user-mode-linux-user@lists.sourceforge.net, linux-kselftest@vger.kernel.org, KVM list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Kyle,
 your patch format is really odd.

You seem to have *eight* lines of context rather than the regular 3.
Is there any reason for that oddity?

It basically means that a one-line hunk ends up being 17 lines of
unified diff rather than 7.

Example appended,

                  Linus

On Sat, Mar 11, 2017 at 11:46 AM, Kyle Huey <me@kylehuey.com> wrote:
>
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index ad6f5eb07a95..9fc44b95f7cb 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -82,16 +82,17 @@ struct thread_info {
>  #define TIF_SIGPENDING         2       /* signal pending */
>  #define TIF_NEED_RESCHED       3       /* rescheduling necessary */
>  #define TIF_SINGLESTEP         4       /* reenable singlestep on user return*/
>  #define TIF_SYSCALL_EMU                6       /* syscall emulation active */
>  #define TIF_SYSCALL_AUDIT      7       /* syscall auditing active */
>  #define TIF_SECCOMP            8       /* secure computing */
>  #define TIF_USER_RETURN_NOTIFY 11      /* notify kernel of userspace return */
>  #define TIF_UPROBE             12      /* breakpointed or singlestepping */
> +#define TIF_NOCPUID            15      /* CPUID is not accessible in userland */
>  #define TIF_NOTSC              16      /* TSC is not accessible in userland */
>  #define TIF_IA32               17      /* IA32 compatibility process */
>  #define TIF_NOHZ               19      /* in adaptive nohz mode */
>  #define TIF_MEMDIE             20      /* is terminating due to OOM killer */
>  #define TIF_POLLING_NRFLAG     21      /* idle is polling for TIF_NEED_RESCHED */
>  #define TIF_IO_BITMAP          22      /* uses I/O bitmap */
>  #define TIF_FORCED_TF          24      /* true if TF in eflags artificially */
>  #define TIF_BLOCKSTEP          25      /* set when we want DEBUGCTLMSR_BTF */


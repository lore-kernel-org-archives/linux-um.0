Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 17 Feb 2022 09:29:14 -0800
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] um: Cleanup syscall_handler_t definition/cast, fix
 warning
Message-ID: <202202170928.F02D6F41@keescook>
References: <20220210034353.1065703-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220210034353.1065703-1-davidgow@google.com>
To: David Gow <davidgow@google.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Al Viro <viro@zeniv.linux.org.uk>, x86@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

On Thu, Feb 10, 2022 at 11:43:53AM +0800, David Gow wrote:
> The syscall_handler_t type for x86_64 was defined as 'long (*)(void)',
> but always cast to 'long (*)(long, long, long, long, long, long)' before
> use. This now triggers a warning (see below).
> 
> Define syscall_handler_t as the latter instead, and remove the cast.
> This simplifies the code, and fixes the warning.
> 
> Warning:
> In file included from ../arch/um/include/asm/processor-generic.h:13
>                  from ../arch/x86/um/asm/processor.h:41
>                  from ../include/linux/rcupdate.h:30
>                  from ../include/linux/rculist.h:11
>                  from ../include/linux/pid.h:5
>                  from ../include/linux/sched.h:14
>                  from ../include/linux/ptrace.h:6
>                  from ../arch/um/kernel/skas/syscall.c:7:
> ../arch/um/kernel/skas/syscall.c: In function ‘handle_syscall’:
> ../arch/x86/um/shared/sysdep/syscalls_64.h:18:11: warning: cast between incompatible function types from ‘long int (*)(void)’ to ‘long int (*)(long int,  long int,  long int,  long int,  long int,  long int)’ [
> -Wcast-function-type]
>    18 |         (((long (*)(long, long, long, long, long, long)) \
>       |           ^
> ../arch/x86/um/asm/ptrace.h:36:62: note: in definition of macro ‘PT_REGS_SET_SYSCALL_RETURN’
>    36 | #define PT_REGS_SET_SYSCALL_RETURN(r, res) (PT_REGS_AX(r) = (res))
>       |                                                              ^~~
> ../arch/um/kernel/skas/syscall.c:46:33: note: in expansion of macro ‘EXECUTE_SYSCALL’
>    46 |                                 EXECUTE_SYSCALL(syscall, regs));
>       |                                 ^~~~~~~~~~~~~~~
> 
> Signed-off-by: David Gow <davidgow@google.com>

Thanks for this! I was just about to go figure this out too. :)

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook


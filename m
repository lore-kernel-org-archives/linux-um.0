Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 9 Nov 2016 10:58:21 +0100
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v10 2/7] x86/arch_prctl/64: Rename do_arch_prctl to
 do_arch_prctl_64
Message-ID: <20161109095821.vomzrdjaltmnoxsy@pd.tnic>
References: <20161108183956.4521-1-khuey@kylehuey.com>
 <20161108183956.4521-3-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161108183956.4521-3-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Nov 08, 2016 at 10:39:51AM -0800, Kyle Huey wrote:
> In order to introduce new arch_prctls that are not 64 bit only, rename the
> existing 64 bit implementation to do_arch_prctl_64. Also rename the second

				    do_arch_prctl_64()

> argument to arch_prctl, which will no longer always be an address.

	      arch_prctl()

so that we know they're functions.

> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> Reviewed-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/include/asm/proto.h |  4 +++-
>  arch/x86/kernel/process_64.c | 32 +++++++++++++++++---------------
>  arch/x86/kernel/ptrace.c     |  8 ++++----
>  arch/x86/um/syscalls_64.c    |  4 ++--
>  4 files changed, 26 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
> index 9b9b30b..95c3e51 100644
> --- a/arch/x86/include/asm/proto.h
> +++ b/arch/x86/include/asm/proto.h
> @@ -25,11 +25,13 @@ void entry_SYSCALL_compat(void);
>  void entry_INT80_compat(void);
>  #endif
>  
>  void x86_configure_nx(void);
>  void x86_report_nx(void);
>  
>  extern int reboot_force;
>  
> -long do_arch_prctl(struct task_struct *task, int code, unsigned long addr);
> +#ifdef CONFIG_X86_64
> +long do_arch_prctl_64(struct task_struct *task, int code, unsigned long arg2);
> +#endif

There's already an #ifdef CONFIG_X86_64 in that file, please move this
one there too.

...

> @@ -863,17 +863,17 @@ long arch_ptrace(struct task_struct *child, long request,
>  		break;
>  #endif
>  
>  #ifdef CONFIG_X86_64
>  		/* normal 64bit interface to access TLS data.
>  		   Works just like arch_prctl, except that the arguments
>  		   are reversed. */
>  	case PTRACE_ARCH_PRCTL:
> -		ret = do_arch_prctl(child, data, addr);
> +		ret = do_arch_prctl_64(child, data, addr);
>  		break;
>  #endif
>  
>  	default:
>  		ret = ptrace_request(child, request, addr, data);
>  		break;
>  	}
>  
> diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
> index ab3f7f4..3362c4e 100644
> --- a/arch/x86/um/syscalls_64.c
> +++ b/arch/x86/um/syscalls_64.c
> @@ -68,19 +68,19 @@ long arch_prctl(struct task_struct *task, int code, unsigned long __user *addr)
												^^^^^
You missed one here.

Actually I see a couple:

$ git grep -E arch_prctl.*addr
arch/um/include/shared/os.h:306:extern int os_arch_prctl(int pid, int code, unsigned long *addr);
arch/x86/kernel/ptrace.c:871:           ret = do_arch_prctl_64(child, data, addr);
arch/x86/um/os-Linux/prctl.c:9:int os_arch_prctl(int pid, int code, unsigned long *addr)
arch/x86/um/ptrace_64.c:272:            ret = arch_prctl(child, data, (void __user *) addr);
arch/x86/um/syscalls_64.c:14:long arch_prctl(struct task_struct *task, int code, unsigned long __user *addr)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 


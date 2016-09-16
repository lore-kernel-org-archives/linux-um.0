Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 16 Sep 2016 09:50:26 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/3] syscalls,x86 Expose arch_prctl on x86-32.
In-Reply-To: <20160915233324.6060-2-khuey@kylehuey.com>
Message-ID: <alpine.DEB.2.20.1609160847420.5384@nanos>
References: <20160915233324.6060-1-khuey@kylehuey.com> <20160915233324.6060-2-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Dmitry Safonov <0x7f454c46@gmail.com>, Borislav Petkov <bp@suse.de>, linux-api@vger.kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Anna Schumaker <Anna.Schumaker@Netapp.com>, Andy Lutomirski <luto@kernel.org>, Zach Brown <zab@redhat.com>, Eric B Munson <emunson@akamai.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Peter Zijlstra <peterz@infradead.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Jiri Slaby <jslaby@suse.cz>, Andrey Ryabinin <aryabinin@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, Borislav Petkov <bp@alien8.de>, Dmitry Vyukov <dvyukov@google.com>, Jan Beulich <JBeulich@suse.com>, Mateusz Guzik <mguzik@redhat.com>, Chuck Ebbert <cebbert.lkml@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, "chengang@emindsoft.com.cn" <chengang@emindsoft.com.cn>, Jeff Moyer <jmoyer@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <jkosina@suse.cz>, Milosz Tanski <milosz@adfin.com>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, 15 Sep 2016, Kyle Huey wrote:

First of all, please add a cover letter [PATCH 0/N] to your patch series
and send it with something which provides proper mail threading. 
See: git-send-email, quilt 

> arch_prctl is currently 64-bit only. Wire it up for 32-bits, as a no-op for
> now. Rename the second arg to a more generic name.

This changelog is useless.

- it does not provide any rationale for this change, i.e. why this is
  required. Just because its 64bit only is not a reason.

- "Rename the second arg to a more generic name" does not give
  any useful information.

Misleading information is worse than no information.

Further your patch does 5 things at once. It wants to be split into parts:

1) Rename do_arch_prctl() and change the argument name,

> -long do_arch_prctl(struct task_struct *task, int code, unsigned long addr)
> +long do_arch_prctl_64(struct task_struct *task, int code, unsigned long arg2)

2) Provide do_arch_prctl_common() and hook it up to the arch_prctl syscall

> -long sys_arch_prctl(int code, unsigned long addr)
> +SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
>  {
> -	return do_arch_prctl(current, code, addr);
> +	long ret;
> +
> +	ret = do_arch_prctl_64(current, code, arg2);
> +	if (ret == -EINVAL)
> +		ret = do_arch_prctl_common(current, code, arg2);
> +
> +	return ret;
>  }

3) Implement the compat version
  
Thanks,

	tflx


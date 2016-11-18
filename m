Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 18 Nov 2016 08:30:12 +0100
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v12 4/7] x86/syscalls/32: Wire up arch_prctl on x86-32
Message-ID: <20161118073012.GB15912@gmail.com>
References: <20161117020610.5302-1-khuey@kylehuey.com>
 <20161117020610.5302-5-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161117020610.5302-5-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


* Kyle Huey <me@kylehuey.com> wrote:

> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -716,16 +716,18 @@ int __compat_save_altstack(compat_stack_t __user *, unsigned long);
>  } while (0);
>  
>  asmlinkage long compat_sys_sched_rr_get_interval(compat_pid_t pid,
>  						 struct compat_timespec __user *interval);
>  
>  asmlinkage long compat_sys_fanotify_mark(int, unsigned int, __u32, __u32,
>  					    int, const char __user *);
>  
> +asmlinkage long compat_sys_arch_prctl(int, unsigned long);

Please always use prototypes with proper argument names spelled out, i.e.:

+asmlinkage long compat_sys_arch_prctl(int option, unsigned long arg2);

Thanks,

	Ingo


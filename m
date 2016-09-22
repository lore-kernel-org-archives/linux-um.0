Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160921185824.18980-4-khuey@kylehuey.com>
References: <20160921185824.18980-1-khuey@kylehuey.com> <20160921185824.18980-4-khuey@kylehuey.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 22 Sep 2016 15:19:09 -0700
Message-ID: <CALCETrUnyjg7cKECBRYsBmJRJKnH8indgJ6kwfN6iwfgSfGNeA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] x86/arch_prctl Add a new do_arch_prctl
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, Dmitry Safonov <dsafonov@virtuozzo.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Len Brown <len.brown@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Sep 21, 2016 at 11:58 AM, Kyle Huey <me@kylehuey.com> wrote:
> Add a new do_arch_prctl to handle arch_prctls that are not specific to 64
> bits. Call it from the syscall entry point, but not any of the other
> callsites in the kernel, which all want one of the existing 64 bit only
> arch_prctls.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  arch/x86/include/asm/proto.h | 1 +
>  arch/x86/kernel/process.c    | 5 +++++
>  arch/x86/kernel/process_64.c | 8 +++++++-
>  3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
> index 95c3e51..94a57cc 100644
> --- a/arch/x86/include/asm/proto.h
> +++ b/arch/x86/include/asm/proto.h
> @@ -30,6 +30,7 @@ void x86_report_nx(void);
>
>  extern int reboot_force;
>
> +long do_arch_prctl(struct task_struct *task, int code, unsigned long arg2);
>  #ifdef CONFIG_X86_64
>  long do_arch_prctl_64(struct task_struct *task, int code, unsigned long arg2);
>  #endif
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 62c0b0e..97aa104 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -567,3 +567,8 @@ unsigned long get_wchan(struct task_struct *p)
>         } while (count++ < 16 && p->state != TASK_RUNNING);
>         return 0;
>  }
> +
> +long do_arch_prctl(struct task_struct *task, int code, unsigned long arg2)
> +{
> +       return -EINVAL;
> +}

This should be do_arch_prctl_common or similar to avoid confusion.

P.S. The subject should be "x86/arch_prctl: ...".


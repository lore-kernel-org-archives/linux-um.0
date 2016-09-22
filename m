Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160921185824.18980-7-khuey@kylehuey.com>
References: <20160921185824.18980-1-khuey@kylehuey.com> <20160921185824.18980-7-khuey@kylehuey.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 22 Sep 2016 15:22:53 -0700
Message-ID: <CALCETrW96hcsSp-YZgNqH_EzTfUyG9yStyp+0nQmpE0o3o__wA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] x86/arch_prctl Add ARCH_[GET|SET]_CPUID
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, Dmitry Safonov <dsafonov@virtuozzo.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Len Brown <len.brown@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Sep 21, 2016 at 11:58 AM, Kyle Huey <me@kylehuey.com> wrote:
> Intel supports faulting on the CPUID instruction beginning with Ivy Bridge.
> When enabled, the processor will fault on attempts to execute the CPUID
> instruction with CPL>0. Exposing this feature to userspace will allow a
> ptracer to trap and emulate the CPUID instruction.
>
> When supported, this feature is controlled by toggling bit 0 of
> MSR_MISC_FEATURES_ENABLES. It is documented in detail in Section 2.3.2 of
> http://www.intel.com/content/dam/www/public/us/en/documents/application-notes/virtualization-technology-flexmigration-application-note.pdf
>

> +       if (!test_and_set_thread_flag(TIF_NOCPUID))
> +               /*
> +                * Must flip the CPU state synchronously with
> +                * TIF_NOCPUID in the current running context.
> +                */
> +               switch_cpuid_faulting(true);

If statements with multiple indented lines should have braces in my
book.  See, for example, "goto fail".


static?

> +int set_cpuid_mode(struct task_struct *task, unsigned long val)

static?

> + * Called immediately after a successful exec.
> + */
> +void arch_post_exec(void)
> +{
> +       /* If cpuid was previously disabled for this task, re-enable it. */
> +       if (test_thread_flag(TIF_NOCPUID))
> +               enable_cpuid();
> +}

> diff --git a/fs/exec.c b/fs/exec.c
> index 6fcfb3f..0272b7e 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1287,6 +1287,7 @@ void setup_new_exec(struct linux_binprm * bprm)
>         else
>                 set_dumpable(current->mm, suid_dumpable);
>
> +       arch_post_exec();

Let's call this arch_setup_new_exec().

>         perf_event_exec();
>         __set_task_comm(current, kbasename(bprm->filename), true);
>
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 2b5b10e..22a3f61 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -130,6 +130,10 @@ static inline void check_object_size(const void *ptr, unsigned long n,
>  { }
>  #endif /* CONFIG_HARDENED_USERCOPY */
>
> +#ifndef arch_post_exec
> +static inline void arch_post_exec(void) {}
> +#endif
> +

thread_info.h is a weird place for this IMO.  Admittedly, elf.h isn't
a whole lot better.


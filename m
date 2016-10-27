Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1610271022030.4817@nanos>
References: <20161019020333.3766-1-khuey@kylehuey.com> <20161019020333.3766-7-khuey@kylehuey.com>
 <alpine.DEB.2.20.1610271022030.4817@nanos>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 27 Oct 2016 15:34:53 -0700
Message-ID: <CALCETrUXCA+-gWxvAVJf=zRPFP=_t600pdVPC44SFL5v_YxOMQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kyle Huey <me@kylehuey.com>, Robert O'Callahan <robert@ocallahan.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, Dmitry Safonov <dsafonov@virtuozzo.com>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Oct 27, 2016 at 4:15 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> This is insane. The compiler makes that a conditional jump and then in
> switch_cpuid_faulting we get another one. Further switch_cpuid_faulting()
> calls into lib/msr which is adding even more overhead.
>
> msr_set/clear_bit() are nice for random driver code, but complete overkill
> for the context switch hotpath.
>
> That's just not acceptable for switch_to(). We keep adding cruft and then
> wonder why context switches slow down despite machines getting faster.
>
> This can and needs to be done smarter. See untested patch below. The
> resulting code has a single conditional jump, which is obviously the check
> for a change between prev and next. Everything else is done with straight
> linear shift,add,and,rdmsr,wrmsr instructions.
>

...

>  #define MSR_IA32_SYSENTER_ESP          0x00000175
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -193,12 +193,17 @@ int set_tsc_mode(unsigned int val)
>         return 0;
>  }
>
> -static void switch_cpuid_faulting(bool on)
> +#define CPUID_FAULT_ON_MASK    (~0ULL)
> +#define CPUID_FAULT_OFF_MASK   (~CPUID_FAULT_ENABLE)
> +
> +static void cpuid_fault_ctrl(u64 msk)
>  {
> -       if (on)
> -               msr_set_bit(MSR_MISC_FEATURES_ENABLES, 0);
> -       else
> -               msr_clear_bit(MSR_MISC_FEATURES_ENABLES, 0);
> +       u64 msrval;
> +
> +       rdmsrl(MSR_MISC_FEATURES_ENABLES, msrval);
> +       msrval |= CPUID_FAULT_ENABLE;
> +       msrval &= msk;
> +       wrmsrl(MSR_MISC_FEATURES_ENABLES, msrval);
>  }

Let's just do this right from day one:

static void set_cpuid_faulting(bool on)
{
  u64 msrval;

  DEBUG_LOCKS_WARN_ON(!irqs_disabled());

  msrval = this_cpu_read(msr_misc_features_enables_shadow);
  msrval &= CPUID_FAULT_ENABLE;
  msrval |= (on << CPUID_FAULT_ENABLE_BIT);
  this_cpu_write(msr_misc_features_enables_shadow, msrval);
  wrmsrl(MSR_MISC_FEATURES_ENABLES, msrval);
}

RDMSR may be considerably faster than WRMSR, but that doesn't mean it's *fast*.

Obviously this needs some initialization code, but that's fine IMO.

--Andy


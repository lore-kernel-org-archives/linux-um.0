Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 9 Nov 2016 14:12:22 +0100
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v10 6/7] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
Message-ID: <20161109131221.xikkv5doow5n3cc4@pd.tnic>
References: <20161108183956.4521-1-khuey@kylehuey.com>
 <20161108183956.4521-7-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161108183956.4521-7-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Nov 08, 2016 at 10:39:55AM -0800, Kyle Huey wrote:
> Intel supports faulting on the CPUID instruction beginning with Ivy Bridge.
> When enabled, the processor will fault on attempts to execute the CPUID
> instruction with CPL>0. Exposing this feature to userspace will allow a
> ptracer to trap and emulate the CPUID instruction.
> 
> When supported, this feature is controlled by toggling bit 0 of
> MSR_MISC_FEATURES_ENABLES. It is documented in detail in Section 2.3.2 of
> http://www.intel.com/content/dam/www/public/us/en/documents/application-notes/virtualization-technology-flexmigration-application-note.pdf
> 
> Implement a new pair of arch_prctls, available on both x86-32 and x86-64.
> 
> ARCH_GET_CPUID: Returns the current CPUID faulting state, either
>   ARCH_CPUID_ENABLE or ARCH_CPUID_SIGSEGV. arg2 must be 0.
> 
> ARCH_SET_CPUID: Set the CPUID faulting state to arg2, which must be either
>   ARCH_CPUID_ENABLE or ARCH_CPUID_SIGSEGV. Returns EINVAL if arg2 is
>   another value or CPUID faulting is not supported on this system.
> 
> The state of the CPUID faulting flag is propagated across forks, but reset
> upon exec.
> 
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---

...

> diff --git a/tools/testing/selftests/x86/cpuid-fault.c b/tools/testing/selftests/x86/cpuid-fault.c
> new file mode 100644
> index 0000000..65419de
> --- /dev/null
> +++ b/tools/testing/selftests/x86/cpuid-fault.c
> @@ -0,0 +1,250 @@
> +
> +/*
> + * Tests for arch_prctl(ARCH_GET_CPUID, ...) / arch_prctl(ARCH_SET_CPUID, ...)
> + *
> + * Basic test to test behaviour of ARCH_GET_CPUID and ARCH_SET_CPUID
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <inttypes.h>
> +#include <cpuid.h>
> +#include <err.h>
> +#include <errno.h>
> +#include <sys/wait.h>
> +
> +#include <sys/prctl.h>
> +#include <linux/prctl.h>
> +
> +/*
> +#define ARCH_GET_CPUID 0x1005
> +#define ARCH_SET_CPUID 0x1006
> +#define ARCH_CPUID_ENABLE 1
> +#define ARCH_CPUID_SIGSEGV 2
> +#ifdef __x86_64__
> +#define SYS_arch_prctl 158
> +#else
> +#define SYS_arch_prctl 385
> +#endif
> +*/
> +
> +const char *cpuid_names[] = {
> +	[0] = "[not set]",
> +	[ARCH_CPUID_ENABLE] = "ARCH_CPUID_ENABLE",
> +	[ARCH_CPUID_SIGSEGV] = "ARCH_CPUID_SIGSEGV",
> +};
> +
> +int arch_prctl(int code, unsigned long arg2)
> +{
> +	return syscall(SYS_arch_prctl, code, arg2);
> +}
> +
> +int cpuid(unsigned int *eax, unsigned int *ebx, unsigned int *ecx,
> +	  unsigned int *edx)
> +{
> +	return __get_cpuid(0, eax, ebx, ecx, edx);
> +}
> +
> +int do_child_exec_test(int eax, int ebx, int ecx, int edx)
> +{
> +	int cpuid_val = 0, child = 0, status = 0;
> +
> +	printf("arch_prctl(ARCH_GET_CPUID); ");
> +
> +	cpuid_val = arch_prctl(ARCH_GET_CPUID, 0);
> +	if (cpuid_val < 0)
> +		errx(1, "ARCH_GET_CPUID fails now, but not before?");
> +
> +	printf("cpuid_val == %s\n", cpuid_names[cpuid_val]);
> +	if (cpuid_val != ARCH_CPUID_SIGSEGV)
> +		errx(1, "How did cpuid get re-enabled on fork?");
> +
> +	if ((child = fork()) == 0) {

ERROR: do not use assignment in if condition
#513: FILE: tools/testing/selftests/x86/cpuid-fault.c:64:
+       if ((child = fork()) == 0) {

There are more in that file.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 


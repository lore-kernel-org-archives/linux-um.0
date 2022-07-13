Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBWpc-001GJR-Pf
	for linux-um@lists.infradead.org; Wed, 13 Jul 2022 07:30:50 +0000
Message-ID: <0cef6aca-6e94-bc77-75a2-c017e6f87f7b@kot-begemot.co.uk>
Date: Wed, 13 Jul 2022 08:06:52 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] um: seed rng using host OS rng
Content-Language: en-US
References: <20220712232738.77737-1-Jason@zx2c4.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <20220712232738.77737-1-Jason@zx2c4.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Cc: stable@vger.kernel.org

On 13/07/2022 00:27, Jason A. Donenfeld wrote:
> UML generally does not provide access to special CPU instructions like
> RDRAND, and execution tends to be rather deterministic, with no real
> hardware interrupts, making good randomness really very hard, if not
> all together impossible. Not only is this a security eyebrow raiser, but
> it's also quite annoying when trying to do various pieces of UML-based
> automation that takes a long time to boot, if ever.
> 
> Fix this by trivially calling getrandom() in the host and using that
> seed as "bootloader randomness", which initializes the rng immediately
> at UML boot.
> 
> The old behavior can be restored the same way as on any other arch, by
> way of CONFIG_TRUST_BOOTLOADER_RANDOMNESS=n or
> random.trust_bootloader=0. So seen from that perspective, this just
> makes UML act like other archs, which is positive in its own right.
> 
> Cc: stable@vger.kernel.org
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   arch/um/include/shared/os.h | 7 +++++++
>   arch/um/kernel/um_arch.c    | 8 ++++++++
>   arch/um/os-Linux/util.c     | 6 ++++++
>   3 files changed, 21 insertions(+)
> 
> diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
> index fafde1d5416e..79644dd88d58 100644
> --- a/arch/um/include/shared/os.h
> +++ b/arch/um/include/shared/os.h
> @@ -11,6 +11,12 @@
>   #include <irq_user.h>
>   #include <longjmp.h>
>   #include <mm_id.h>
> +/* This is to get size_t */
> +#ifndef __UM_HOST__
> +#include <linux/types.h>
> +#else
> +#include <stddef.h>
> +#endif
>   
>   #define CATCH_EINTR(expr) while ((errno = 0, ((expr) < 0)) && (errno == EINTR))
>   
> @@ -243,6 +249,7 @@ extern void stack_protections(unsigned long address);
>   extern int raw(int fd);
>   extern void setup_machinename(char *machine_out);
>   extern void setup_hostinfo(char *buf, int len);
> +extern ssize_t os_getrandom(void *buf, size_t len, unsigned int flags);
>   extern void os_dump_core(void) __attribute__ ((noreturn));
>   extern void um_early_printk(const char *s, unsigned int n);
>   extern void os_fix_helper_signals(void);
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index 0760e24f2eba..74f3efd96bd4 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -16,6 +16,7 @@
>   #include <linux/sched/task.h>
>   #include <linux/kmsg_dump.h>
>   #include <linux/suspend.h>
> +#include <linux/random.h>
>   
>   #include <asm/processor.h>
>   #include <asm/cpufeature.h>
> @@ -406,6 +407,8 @@ int __init __weak read_initrd(void)
>   
>   void __init setup_arch(char **cmdline_p)
>   {
> +	u8 rng_seed[32];
> +
>   	stack_protections((unsigned long) &init_thread_info);
>   	setup_physmem(uml_physmem, uml_reserved, physmem_size, highmem);
>   	mem_total_pages(physmem_size, iomem_size, highmem);
> @@ -416,6 +419,11 @@ void __init setup_arch(char **cmdline_p)
>   	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
>   	*cmdline_p = command_line;
>   	setup_hostinfo(host_info, sizeof host_info);
> +
> +	if (os_getrandom(rng_seed, sizeof(rng_seed), 0) == sizeof(rng_seed)) {
> +		add_bootloader_randomness(rng_seed, sizeof(rng_seed));
> +		memzero_explicit(rng_seed, sizeof(rng_seed));
> +	}
>   }
>   
>   void __init check_bugs(void)
> diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
> index 41297ec404bf..fc0f2a9dee5a 100644
> --- a/arch/um/os-Linux/util.c
> +++ b/arch/um/os-Linux/util.c
> @@ -14,6 +14,7 @@
>   #include <sys/wait.h>
>   #include <sys/mman.h>
>   #include <sys/utsname.h>
> +#include <sys/random.h>
>   #include <init.h>
>   #include <os.h>
>   
> @@ -96,6 +97,11 @@ static inline void __attribute__ ((noreturn)) uml_abort(void)
>   			exit(127);
>   }
>   
> +ssize_t os_getrandom(void *buf, size_t len, unsigned int flags)
> +{
> +	return getrandom(buf, len, flags);
> +}
> +
>   /*
>    * UML helper threads must not handle SIGWINCH/INT/TERM
>    */

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


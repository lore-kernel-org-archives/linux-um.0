Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sahne@0x90.at>) id 1Xcbtc-0004Js-BO
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Oct 2014 15:14:20 +0000
Received: from zimbra.brainity.com ([188.40.76.72])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XcbtZ-0004iR-Vj for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Oct 2014 15:14:20 +0000
Date: Fri, 10 Oct 2014 17:14:11 +0200 (CEST)
From: Daniel Walter <d.walter@0x90.at>
Message-ID: <1207600533.1812.1412954051520.JavaMail.root@0x90.at>
In-Reply-To: <1412877334.13744.4.camel@localhost.localdomain>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 2/2] um: add a kmsg_dumper
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

----- Original Message -----
> From: "Thomas Meyer" <thomas@m3y3r.de>
> To: "user-mode-linux-devel" <user-mode-linux-devel@lists.sourceforge.net>
> Cc: "Richard Weinberger" <richard@nod.at>, "Daniel Walter" <d.walter@0x90.at>
> Sent: Thursday, October 9, 2014 6:55:34 PM
> Subject: [PATCH 2/2] um: add a kmsg_dumper
> 
> 
> Add a kmsg_dumper, that dumps the kmsg buffer to stderr, when no
> console is available.
> This an enables the printing of early panic() calls triggered in
> uml_postsetup().
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
>  arch/um/drivers/ubd_kern.c  |  5 +++--
>  arch/um/include/shared/os.h |  1 +
>  arch/um/kernel/Makefile     |  2 +-
>  arch/um/kernel/kmsg_dump.c  | 44
>  ++++++++++++++++++++++++++++++++++++++++++++
>  arch/um/kernel/um_arch.c    |  2 ++
>  arch/um/os-Linux/util.c     | 12 ++++++++++++
>  6 files changed, 63 insertions(+), 3 deletions(-)
>  create mode 100644 arch/um/kernel/kmsg_dump.c
> 
> diff --git a/arch/um/include/shared/os.h
> b/arch/um/include/shared/os.h
> index 08eec0b..36741f4 100644
> --- a/arch/um/include/shared/os.h
> +++ b/arch/um/include/shared/os.h
> @@ -238,6 +238,7 @@ extern void setup_hostinfo(char *buf, int len);
>  extern void os_dump_core(void) __attribute__ ((noreturn));
>  extern void um_early_printk(const char *s, unsigned int n);
>  extern void os_fix_helper_signals(void);
> +extern int os_printf_stderr(const char *fmt, ...);
>  
>  /* time.c */
>  extern void idle_sleep(unsigned long long nsecs);
> diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> index d8b78a0..572e781 100644
> --- a/arch/um/kernel/Makefile
> +++ b/arch/um/kernel/Makefile
> @@ -13,7 +13,7 @@ clean-files :=
>  obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
>  	physmem.o process.o ptrace.o reboot.o sigio.o \
>  	signal.o smp.o syscall.o sysrq.o time.o tlb.o trap.o \
> -	um_arch.o umid.o maccess.o skas/
> +	um_arch.o umid.o maccess.o kmsg_dump.o skas/
>  
>  obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
>  obj-$(CONFIG_GPROF)	+= gprof_syms.o
> diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> new file mode 100644
> index 0000000..8047ca5a3
> --- /dev/null
> +++ b/arch/um/kernel/kmsg_dump.c
> @@ -0,0 +1,44 @@
> +#include <linux/kmsg_dump.h>
> +#include <linux/console.h>
> +#include <shared/init.h>
> +#include <shared/kern.h>
> +#include <os.h>
> +
> +static struct kmsg_dumper kmsg_dumper;

can you make this const ?

> +
> +static void kmsg_dumper_stderr(struct kmsg_dumper *dumper,
> +				enum kmsg_dump_reason reason)
> +{
> +	static char line[1024];
> +
> +	size_t len = 0;
> +	int con_count = 0;
> +	struct console *con = NULL;
> +
> +	/* only dump kmsg when no console is available */
> +	if (!console_trylock()) {
> +		return;
> +	}
> +	for_each_console(con) {
> +		con_count++;
> +	}
> +	console_unlock();
> +
> +	if (con_count > 0) {
> +		return;
> +	}
> +

Would it be sufficient to check if a console exists, instead of iterating through all of
them and decide to return anyway as soon as one exists ? (I believe a check for console_drivers != NULL should be sufficient)

> +	os_printf_stderr("kmsg_dump:\n");
> +	while (kmsg_dump_get_line(dumper, true, line, sizeof(line), &len))
> {
> +		line[len] = '\0';
> +		os_printf_stderr("%s", line);
> +	}
> +}
> +
> +int __init kmsg_dumper_stderr_init(void)
> +{
> +	kmsg_dumper.dump = kmsg_dumper_stderr;
> +	return kmsg_dump_register(&kmsg_dumper);
> +}
> +
> +__uml_initcall(kmsg_dumper_stderr_init);
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index ab72560..4f6fc24 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -11,6 +11,7 @@
>  #include <linux/string.h>
>  #include <linux/utsname.h>
>  #include <linux/sched.h>
> +#include <linux/kmsg_dump.h>
>  #include <asm/pgtable.h>
>  #include <asm/processor.h>
>  #include <asm/sections.h>
> @@ -234,6 +235,7 @@ static void __init uml_postsetup(void)
>  static int panic_exit(struct notifier_block *self, unsigned long
>  unused1,
>  		      void *unused2)
>  {
> +	kmsg_dump(KMSG_DUMP_PANIC);
>  	bust_spinlocks(1);
>  	bust_spinlocks(0);
>  	uml_exitcode = 1;
> diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
> index faee55e..a4cc3a0 100644
> --- a/arch/um/os-Linux/util.c
> +++ b/arch/um/os-Linux/util.c
> @@ -152,3 +152,15 @@ void um_early_printk(const char *s, unsigned int
> n)
>  {
>  	printf("%.*s", n, s);
>  }
> +
> +int os_printf_stderr(const char *fmt, ...)
> +{
> +	va_list list;
> +	int rc;
> +
> +	va_start(list, fmt);
> +	rc = vfprintf(stderr, fmt, list);
> +	va_end(list);
> +
> +	return rc;
> +}
Is there a reason why you want the dump to be on stderr ? It seems
the rest of uml just prints to stdout ?


> --
> 1.9.3
> 
> 
> 

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


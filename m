Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2Gug-0007T2-1L
 for linux-um@lists.infradead.org; Wed, 20 Jan 2021 17:04:59 +0000
Subject: Re: [PATCH v2] init/gcov: allow CONFIG_CONSTRUCTORS on UML to fix
 module gcov
References: <e386f13f8496330cd42e93c6d48a25b9a57a6792.camel@sipsolutions.net>
 <20210120172041.c246a2cac2fb.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <ee3bc3bf-9582-d278-5b7a-d9fa27b17800@linux.ibm.com>
Date: Wed, 20 Jan 2021 18:04:25 +0100
MIME-Version: 1.0
In-Reply-To: <20210120172041.c246a2cac2fb.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Johannes Berg <johannes.berg@intel.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>

On 20.01.2021 17:20, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> On ARCH=um, loading a module doesn't result in its constructors
> getting called, which breaks module gcov since the debugfs files
> are never registered. On the other hand, in-kernel constructors
> have already been called by the dynamic linker, so we can't call
> them again.
> 
> Get out of this conundrum by allowing CONFIG_CONSTRUCTORS to be
> selected, but avoiding the in-kernel constructor calls.
> 
> Also remove the "if !UML" from GCOV selecting CONSTRUCTORS now,
> since we really do want CONSTRUCTORS, just not kernel binary
> ones.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Looks good+nicer than v1 to me!

I also tested this patch on s390 and can confirm that it doesn't break
gcov-kernel there.

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Andrew, do we need additional reviews/sign-offs? Could this go in via
your tree?

> ---
> Tested with a kernel configured with CONFIG_GCOV_KERNEL, without
> the patch nothing ever appears in /sys/kernel/debug/gcov/ (apart
> from the reset file), and with it we get the files and they work.

Just to be sure: could you confirm that this test statement for UML also
applies to v2, i.e. that it fixes the original problem you were seeing?

> 
> v2:
>  * special-case UML instead of splitting the CONSTRUCTORS config
> ---
>  init/Kconfig        | 1 -
>  init/main.c         | 8 +++++++-
>  kernel/gcov/Kconfig | 2 +-
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index b77c60f8b963..29ad68325028 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -76,7 +76,6 @@ config CC_HAS_ASM_INLINE
>  
>  config CONSTRUCTORS
>  	bool
> -	depends on !UML
>  
>  config IRQ_WORK
>  	bool
> diff --git a/init/main.c b/init/main.c
> index c68d784376ca..a626e78dbf06 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1066,7 +1066,13 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>  /* Call all constructor functions linked into the kernel. */
>  static void __init do_ctors(void)
>  {
> -#ifdef CONFIG_CONSTRUCTORS
> +/*
> + * For UML, the constructors have already been called by the
> + * normal setup code as it's just a normal ELF binary, so we
> + * cannot do it again - but we do need CONFIG_CONSTRUCTORS
> + * even on UML for modules.
> + */
> +#if defined(CONFIG_CONSTRUCTORS) && !defined(CONFIG_UML)
>  	ctor_fn_t *fn = (ctor_fn_t *) __ctors_start;
>  
>  	for (; fn < (ctor_fn_t *) __ctors_end; fn++)
> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> index 3110c77230c7..f62de2dea8a3 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -4,7 +4,7 @@ menu "GCOV-based kernel profiling"
>  config GCOV_KERNEL
>  	bool "Enable gcov-based kernel profiling"
>  	depends on DEBUG_FS
> -	select CONSTRUCTORS if !UML
> +	select CONSTRUCTORS
>  	default n
>  	help
>  	This option enables gcov-based code profiling (e.g. for code coverage
> 


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


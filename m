Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] um: Avoid longjmp/setjmp symbol clashes with libpthread.a
References: <20170523210813.22816-1-f.fainelli@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <40707918-8ba1-9651-a6e4-504ee1baa9e6@gmail.com>
Date: Tue, 23 May 2017 16:03:58 -0700
MIME-Version: 1.0
In-Reply-To: <20170523210813.22816-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 05/23/2017 02:08 PM, Florian Fainelli wrote:
> Building a statically linked UML kernel on a Centos 6.9 host resulted in
> the following linking failure (GCC 4.4, glibc-2.12):
> 
> /usr/lib/gcc/x86_64-redhat-linux/4.4.7/../../../../lib64/libpthread.a(libpthread.o):
> In function `siglongjmp':
> (.text+0x8490): multiple definition of `longjmp'
> arch/x86/um/built-in.o:/local/users/fainelli/openwrt/trunk/build_dir/target-x86_64_musl/linux-uml/linux-4.4.69/arch/x86/um/setjmp_64.S:44:
> first defined here
> /usr/lib/gcc/x86_64-redhat-linux/4.4.7/../../../../lib64/libpthread.a(libpthread.o):
> In function `sem_open':
> (.text+0x77cd): warning: the use of `mktemp' is dangerous, better use
> `mkstemp'
> collect2: ld returned 1 exit status
> make[4]: *** [vmlinux] Error 1
> 
> Adopt a solution similar to the one done for vmap where we define
> longjmp/setjmp to be kernel_longjmp/setjmp. In the process, make sure we
> do rename the functions in arch/x86/um/setjmp_*.S accordingly.
> 
> Fixes: a7df4716d195 ("um: link with -lpthread")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

> -	.globl longjmp
> -	.type longjmp, @function
> -longjmp:
> +	.globl kernel_jongjmp
> +	.type kernel_jongjmp, @function
> +kernel_jongjmp:

Dyslexia at its finest, I will submit a corrected v2, the perils of
switching between machines....

-- 
Florian


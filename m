Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <544AD829.206@gmail.com>
Date: Sat, 25 Oct 2014 06:52:25 +0800
From: Chen Gang <gang.chen.5i5j@gmail.com>
MIME-Version: 1.0
References: <542FF203.50907@gmail.com>
In-Reply-To: <542FF203.50907@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: kernel: ksyms: Export symbol syscall() for fixing
 modpost issue
To: richard@nod.at, jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hello Maintainers:

Please help check this patch, when you have time.

Thanks.

On 10/4/14 21:11, Chen Gang wrote:
> syscall() is implemented in libc.so/a (e.g. for glibc, in "syscall.o"),
> so for normal ".o" files, it is undefined, neither can be found within
> kernel wide, so will break modpost.
> 
> Since ".o" files is OK, can simply export 'syscall' symbol, let modpost
> know about that, then can fix this issue.
> 
> The related error (with allmodconfig under um):
> 
>     MODPOST 1205 modules
>   ERROR: "syscall" [fs/hostfs/hostfs.ko] undefined!
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/um/kernel/ksyms.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/um/kernel/ksyms.c b/arch/um/kernel/ksyms.c
> index 543c047..e7780f3 100644
> --- a/arch/um/kernel/ksyms.c
> +++ b/arch/um/kernel/ksyms.c
> @@ -42,3 +42,6 @@ EXPORT_SYMBOL(os_makedev);
>  EXPORT_SYMBOL(add_sigio_fd);
>  EXPORT_SYMBOL(ignore_sigio_fd);
>  EXPORT_SYMBOL(sigio_broken);
> +
> +extern long int syscall (long int __sysno, ...);
> +EXPORT_SYMBOL(syscall);
> 

-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed

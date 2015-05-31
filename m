Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Yz9E7-0000Ht-DV
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 19:48:55 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yz9E5-00029i-LE
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 19:48:55 +0000
Message-ID: <556B6599.3090801@nod.at>
Date: Sun, 31 May 2015 21:48:41 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <542FF203.50907@gmail.com>
In-Reply-To: <542FF203.50907@gmail.com>
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
Subject: Re: [uml-devel] [PATCH] um: kernel: ksyms: Export symbol syscall()
 for fixing modpost issue
To: Chen Gang <gang.chen.5i5j@gmail.com>, jdike@addtoit.com
Cc: Thomas Meyer <thomas@m3y3r.de>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Am 04.10.2014 um 15:11 schrieb Chen Gang:
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

Thanks Chen, applied to my 4.2 queue!

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


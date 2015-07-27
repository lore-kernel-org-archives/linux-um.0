Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hwhilse@gmail.com>) id 1ZJgcB-0007JZ-Mv
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Jul 2015 11:30:39 +0000
Received: from hilses.de ([213.133.103.163])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZJgcA-0005QN-Cq
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Jul 2015 11:30:39 +0000
Received: from [10.0.0.1] (helo=localhost) by hilses.de with esmtpa (Exim 4.85)
	(envelope-from <hwhilse@gmail.com>) id 1ZJgbk-0001Ov-0p
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Jul 2015 13:30:12 +0200
MIME-Version: 1.0
Date: Mon, 27 Jul 2015 13:30:11 +0200
From: Hans-Werner Hilse <hwhilse@gmail.com>
In-Reply-To: <1435571432-21125-2-git-send-email-hwhilse@gmail.com>
References: <3faa85268de72e64ff74175f2cf74021@hilses.de>
	<1435571432-21125-1-git-send-email-hwhilse@gmail.com>
	<1435571432-21125-2-git-send-email-hwhilse@gmail.com>
Message-ID: <034b3bc80c078d8a8f7b2850924c033b@hilses.de>
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
Subject: Re: [uml-devel]
 =?utf-8?q?=5BPATCH_v2=5D_um=3A_Do_not_rely_on_libc_to?=
 =?utf-8?q?_provide_modify=5Fldt=28=29?=
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

Richard, might I ping you about this one?

Reading other mails on this ML, I reckon' you're quite busy - no 
problem, it's not really critical anyway. Just want to make sure the 
updated patch got noticed.

Thanks,

-hwh

Am 2015-06-29 11:50, schrieb Hans-Werner Hilse:
> modify_ldt() was declared as an external symbol. Despite the man
> page for this syscall telling that there is no wrapper in glibc,
> since version 2.1 there actually is, so linking to the glibc
> works.
> 
> Since modify_ldt() is not a POSIX interface, other libc
> implementations do not always provide a wrapper function.
> Even glibc headers do not provide a corresponding declaration.
> 
> So go the recommended way to call this using syscall().
> 
> Signed-off-by: Hans-Werner Hilse <hwhilse@gmail.com>
> ---
>  arch/x86/um/ldt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/um/ldt.c b/arch/x86/um/ldt.c
> index 9701a4f..836a1eb 100644
> --- a/arch/x86/um/ldt.c
> +++ b/arch/x86/um/ldt.c
> @@ -12,7 +12,10 @@
>  #include <skas.h>
>  #include <sysdep/tls.h>
> 
> -extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
> +static inline int modify_ldt (int func, void *ptr, unsigned long 
> bytecount)
> +{
> +	return syscall(__NR_modify_ldt, func, ptr, bytecount);
> +}
> 
>  static long write_ldt_entry(struct mm_id *mm_idp, int func,
>  		     struct user_desc *desc, void **addr, int done)


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


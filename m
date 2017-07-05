Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1dSrwD-0005q9-AF
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Jul 2017 21:34:21 +0000
Received: from mail-oi0-f68.google.com ([209.85.218.68])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dSrwC-0007HW-8a
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Jul 2017 21:34:21 +0000
Received: by mail-oi0-f68.google.com with SMTP id d77so222789oig.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 05 Jul 2017 14:34:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1495579510.11734.2.camel@m3y3r.de>
References: <1495579510.11734.2.camel@m3y3r.de>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 5 Jul 2017 23:34:14 +0200
Message-ID: <CAFLxGvyRDv0mBNm0bXpq+UKhgtaVq6yQoN-wkw51GYSZ1NG2EQ@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um: userspace - be more verbose in ptrace
 set regs error
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Thomas,

On Wed, May 24, 2017 at 12:45 AM, Thomas Meyer <thomas@m3y3r.de> wrote:
> When ptrace fails to set GP/FP regs for the target process,
> log the error before crashing the UML kernel.
>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
>  arch/um/os-Linux/skas/process.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
> index 4530867..819d686 100644
> --- a/arch/um/os-Linux/skas/process.c
> +++ b/arch/um/os-Linux/skas/process.c
> @@ -352,11 +352,17 @@ void userspace(struct uml_pt_regs *regs)
>                  * fail.  In this case, there is nothing to do but
>                  * just kill the process.
>                  */
> -               if (ptrace(PTRACE_SETREGS, pid, 0, regs->gp))
> +               if (ptrace(PTRACE_SETREGS, pid, 0, regs->gp)) {
> +                       printk(UM_KERN_ERR "userspace - ptrace set regs "
> +                              "failed, errno = %d\n", errno);
>                         fatal_sigsegv();
> +               }
>
> -               if (put_fp_registers(pid, regs->fp))
> +               if (put_fp_registers(pid, regs->fp)) {
> +                       printk(UM_KERN_ERR "userspace - ptrace set fp regs "
> +                              "failed, errno = %d\n", errno);
>                         fatal_sigsegv();
> +               }
>
>                 /* Now we set local_using_sysemu to be used for one loop */
>                 local_using_sysemu = get_using_sysemu();
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

This patch is also malformed. :-(

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


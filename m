Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <malattia@gmail.com>) id 1QJCKe-0002hX-De
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2011 22:20:08 +0000
Received: from mail-px0-f173.google.com ([209.85.212.173])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QJCKb-0008Jj-Ve
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2011 22:20:08 +0000
Received: by pxi16 with SMTP id 16so3242601pxi.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 08 May 2011 15:20:00 -0700 (PDT)
Date: Mon, 9 May 2011 07:19:53 +0900
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20110508221952.GA26304@kamineko.org>
References: <1304891985-11569-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1304891985-11569-1-git-send-email-richard@nod.at>
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
Subject: Re: [uml-devel] [PATCH 1/4] um: fix UML_LIB_PATH
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, May 08, 2011 at 11:59:42PM +0200, Richard Weinberger wrote:
> UML_LIB_PATH is hardcoded to /usr/lib/uml/,
> on 64bit systems UML_LIB_PATH needs to be /usr/lib64/uml/.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/um/drivers/xterm.c     |    2 +-
>  arch/um/include/shared/os.h |    7 +++++++
>  arch/um/os-Linux/main.c     |    2 +-
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/xterm.c b/arch/um/drivers/xterm.c
> index da2caa5..8ac7146 100644
> --- a/arch/um/drivers/xterm.c
> +++ b/arch/um/drivers/xterm.c
> @@ -90,7 +90,7 @@ static int xterm_open(int input, int output, int primary, void *d,
>  	int pid, fd, new, err;
>  	char title[256], file[] = "/tmp/xterm-pipeXXXXXX";
>  	char *argv[] = { terminal_emulator, title_switch, title, exec_switch,
> -			 "/usr/lib/uml/port-helper", "-uml-socket",
> +			 OS_LIB_PATH "/uml/port-helper", "-uml-socket",
>  			 file, NULL };
>  
>  	if (access(argv[4], X_OK) < 0)
> diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
> index c4617ba..83c7c2e 100644
> --- a/arch/um/include/shared/os.h
> +++ b/arch/um/include/shared/os.h
> @@ -29,6 +29,12 @@
>  #define OS_ACC_R_OK    4       /* Test for read permission.  */
>  #define OS_ACC_RW_OK   (OS_ACC_W_OK | OS_ACC_R_OK) /* Test for RW permission */
>  
> +#ifdef CONFIG_64BIT
> +#define OS_LIB_PATH	"/usr/lib64/"
> +#else
> +#define OS_LIB_PATH	"/usr/lib/"
> +#endif
> +
>  /*
>   * types taken from stat_file() in hostfs_user.c
>   * (if they are wrong here, they are wrong there...).
> @@ -238,6 +244,7 @@ extern int raw(int fd);
>  extern void setup_machinename(char *machine_out);
>  extern void setup_hostinfo(char *buf, int len);
>  extern void os_dump_core(void) __attribute__ ((noreturn));
> +extern void um_early_printk(const char *s, unsigned int n);

this hunk seems unrelated to this change.

Regards,
-- 
mattia
:wq!

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


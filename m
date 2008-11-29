Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penberg@gmail.com>) id 1L6MxS-0003Hy-ME
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Nov 2008 10:21:50 +0000
Received: from wf-out-1314.google.com ([209.85.200.170])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L6MxQ-0004U1-QT for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Nov 2008 10:21:50 +0000
Received: by wf-out-1314.google.com with SMTP id 27so1818080wfd.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 29 Nov 2008 02:21:46 -0800 (PST)
Message-ID: <84144f020811290221g947f836n4fe3435676425ee@mail.gmail.com>
Date: Sat, 29 Nov 2008 12:21:46 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
In-Reply-To: <20081129100830.GA24128@balbir.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <20081129100830.GA24128@balbir.in.ibm.com>
Subject: Re: [uml-devel] [PATCH][UML] Boot broken due to buffer overrun
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
To: balbir@linux.vnet.ibm.com, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Hi Balbir,

On Sat, Nov 29, 2008 at 12:08 PM, Balbir Singh
<balbir@linux.vnet.ibm.com> wrote:
> mconsole_init() passed 256 bytes as length in os_create_unix_socket, while
> the sizeof UNIX_PATH_MAX is 108. This patch fixes that problem and avoids
> a big overrun bug reported on UML bootup.

Maybe mention that ->sun_path in struct sockaddr_un is UNIX_PATH_MAX
long which causes the problem?

> Reported-by: Vikas K Managutte <vikki.km@gmail.com>
> Reported-by: Sarvesh Kumar Lal Das <skldas@gmail.com>
> Signed-off-by: Balbir Singh <balbir@linux.vnet.ibm.com>

Reviewed-by: Pekka Enberg <penberg@cs.helsinki.fi>

> ---
>
>  arch/um/drivers/mconsole_kern.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff -puN arch/um/drivers/mconsole_kern.c~fix-uml-buggy-socket-creation arch/um/drivers/mconsole_kern.c
> --- linux-2.6.28-rc6/arch/um/drivers/mconsole_kern.c~fix-uml-buggy-socket-creation      2008-11-29 15:29:04.000000000 +0530
> +++ linux-2.6.28-rc6-balbir/arch/um/drivers/mconsole_kern.c     2008-11-29 15:32:23.000000000 +0530
> @@ -16,6 +16,8 @@
>  #include <linux/slab.h>
>  #include <linux/syscalls.h>
>  #include <linux/utsname.h>
> +#include <linux/socket.h>
> +#include <linux/un.h>
>  #include <linux/workqueue.h>
>  #include <linux/mutex.h>
>  #include <asm/uaccess.h>
> @@ -785,7 +787,7 @@ static int __init mconsole_init(void)
>        /* long to avoid size mismatch warnings from gcc */
>        long sock;
>        int err;
> -       char file[256];
> +       char file[UNIX_PATH_MAX];
>
>        if (umid_file_name("mconsole", file, sizeof(file)))
>                return -1;
> _
>
> --
>        Balbir
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

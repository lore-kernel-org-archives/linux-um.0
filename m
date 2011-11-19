Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@sigma-star.at>) id 1RRuba-0002z1-6h
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Nov 2011 23:45:54 +0000
Received: from hq.miles-group.at ([95.130.255.141] helo=mail.sigma-star.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RRubY-0006c5-IQ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Nov 2011 23:45:54 +0000
Message-ID: <4EC83B50.8090906@sigma-star.at>
Date: Sun, 20 Nov 2011 00:27:12 +0100
From: Richard Weinberger <richard@sigma-star.at>
MIME-Version: 1.0
References: <4EC838CB.6080009@gmail.com>
In-Reply-To: <4EC838CB.6080009@gmail.com>
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
Subject: Re: [uml-devel] VDE backend does not handle EINTR properly
To: Frank Laub <frank.laub@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Am 20.11.2011 00:16, schrieb Frank Laub:
> When running the VDE backend with 2 uml instances and running iperf 
> between them, the vde_send() function often returns EINTR. I noticed 
> that this is accounted for in net_user.c via the use of the 
> CATCH_EINTR() macro. Thus the following patch uses the same approach for 
> calls into VDE. It could be argued that the VDE library itself should 
> handle EINTR, but this patch will work with older (or current) versions 
> of VDE. This patch was created against 3.0.3.

Please add a Signed-off-by tag,
so that I can give you the credit. :-)
See: http://linux.yyz.us/patch-format.html

> --- a/arch/um/drivers/vde_user.c
> +++ b/arch/um/drivers/vde_user.c
> @@ -11,6 +11,7 @@
>   #include "um_malloc.h"
>   #include "user.h"
>   #include "vde.h"
> +#include "os.h"
> 
>   static int vde_user_init(void *data, void *dev)
>   {
> @@ -103,7 +104,7 @@ int vde_user_read(void *conn, void *buf,
>       if (vconn == NULL)
>           return 0;
> 
> -    rv = vde_recv(vconn, buf, len, 0);
> +    CATCH_EINTR(rv = vde_recv(vconn, buf, len, 0));
>       if (rv < 0) {
>           if (errno == EAGAIN)
>               return 0;
> @@ -118,10 +119,19 @@ int vde_user_read(void *conn, void *buf,
>   int vde_user_write(void *conn, void *buf, int len)
>   {
>       VDECONN *vconn = conn;
> +    int rv;
> 
>       if (vconn == NULL)
>           return 0;
> 
> -    return vde_send(vconn, buf, len, 0);

Is the additional if-branch really needed?

> +    CATCH_EINTR(rv = vde_send(vconn, buf, len, 0));
> +    if (rv < 0) {
> +        if (errno == EAGAIN)
> +            return 0;
> +        return -errno;
> +    }
> +    else if (rv == 0)
> +        return -ENOTCONN;
> +    return rv;
>   }
> 

Thanks,
//richard

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


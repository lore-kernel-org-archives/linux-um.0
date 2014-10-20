Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sahne@0x90.at>) id 1Xg9GW-0008VA-J6
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 09:28:36 +0000
Received: from zimbra.brainity.com ([188.40.76.72])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xg9GU-0000kI-LQ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 09:28:36 +0000
Date: Mon, 20 Oct 2014 11:28:27 +0200 (CEST)
From: Daniel Walter <sahne@0x90.at>
Message-ID: <639004468.1164.1413797307669.JavaMail.root@0x90.at>
In-Reply-To: <1413731653.2991.24.camel@localhost.localdomain>
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
Subject: Re: [uml-devel] [PATCH v3 3/3] um: enable trace irqflags support
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

----- Original Message -----
> From: "Thomas Meyer" <thomas@m3y3r.de>
> To: "user-mode-linux-devel" <user-mode-linux-devel@lists.sourceforge.net>
> Sent: Sunday, October 19, 2014 4:14:13 PM
> Subject: [uml-devel] [PATCH v3 3/3] um: enable trace irqflags support
> 
> Add TRACE_IRQFLAGS_SUPPORT to UML.
> This enables LOCKDEP_SUPPORT and TRACING_SUPPORT.


FYI: I'm currently working on porting ftrace() support to
uml. It will take another week or two since I don't have enough
time to debug, and it isn't stable yet (read as is panic()ing randomly)


> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
> diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
> index 87bc868..6a33c3a 100644
> --- a/arch/um/Kconfig.common
> +++ b/arch/um/Kconfig.common
> @@ -28,10 +28,9 @@ config PCI
>  config PCMCIA
>  	bool
>  
> -# Yet to do!
>  config TRACE_IRQFLAGS_SUPPORT
>  	bool
> -	default n
> +	default y
>  
>  config LOCKDEP_SUPPORT
>  	bool
> diff --git a/arch/um/include/asm/irqflags.h
> b/arch/um/include/asm/irqflags.h
> index c780d8a..c5b636e 100644
> --- a/arch/um/include/asm/irqflags.h
> +++ b/arch/um/include/asm/irqflags.h
> @@ -34,9 +34,9 @@ static inline unsigned long
> arch_local_irq_save(void)
>  	return flags;
>  }
>  
> -static inline bool arch_irqs_disabled(void)
> +static inline int arch_irqs_disabled_flags(unsigned long flags)
>  {
> -	return arch_local_save_flags() == 0;
> +	return flags == 0;
>  }
>  
>  #endif

I'm not sure if this is correct. I'd rather would have another function
implemented instead of removing the check for disabled irqs.


cheers,

daniel

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


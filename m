Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1VaSqU-0002dM-3U
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Oct 2013 16:05:42 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VaSqS-00019R-FS
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Oct 2013 16:05:42 +0000
Message-ID: <526D39AF.4010508@nod.at>
Date: Sun, 27 Oct 2013 17:05:03 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1382857570-3412-1-git-send-email-michael.opdenacker@free-electrons.com>
In-Reply-To: <1382857570-3412-1-git-send-email-michael.opdenacker@free-electrons.com>
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
Subject: Re: [uml-devel] [PATCH] um: remove used STDIO_CONSOLE Kconfig param
To: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Cc: jdike@addtoit.com, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Am 27.10.2013 08:06, schrieb Michael Opdenacker:
> This removes the STDIO_CONSOLE Kconfig parameter which
> is defined but no longer used anywhere in the makefiles and source code.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>

Looks good.
Queued for 3.13.

Thanks,
//richard

> ---
>  arch/um/Kconfig.char | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/um/Kconfig.char b/arch/um/Kconfig.char
> index b9d7c42..f10738d 100644
> --- a/arch/um/Kconfig.char
> +++ b/arch/um/Kconfig.char
> @@ -6,10 +6,6 @@ config STDERR_CONSOLE
>  	help
>  	  console driver which dumps all printk messages to stderr.
>  
> -config STDIO_CONSOLE
> -	bool
> -	default y
> -
>  config SSL
>  	bool "Virtual serial line"
>  	help
> 


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


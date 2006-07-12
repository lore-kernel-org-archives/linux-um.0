Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0jsU-0004g0-Mr for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 11:56:06 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1G0jsS-0000k2-Qf
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 11:56:06 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 12 Jul 2006 20:56:00 +0200
References: <200607121640.k6CGe6nP021236@ccure.user-mode-linux.org>
In-Reply-To: <200607121640.k6CGe6nP021236@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607122056.01202.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 4/5] UML - Reenable SysRq support
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Wednesday 12 July 2006 18:40, Jeff Dike wrote:
> Sysrq works fine on UML.
>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
>
> Index: linux-2.6.17/lib/Kconfig.debug
> ===================================================================
> --- linux-2.6.17.orig/lib/Kconfig.debug	2006-07-12 11:26:41.000000000 -0400
> +++ linux-2.6.17/lib/Kconfig.debug	2006-07-12 11:33:02.000000000 -0400
> @@ -18,7 +18,6 @@ config ENABLE_MUST_CHECK
>
>  config MAGIC_SYSRQ
>  	bool "Magic SysRq key"
> -	depends on !UML
>  	help
>  	  If you say Y here, you will have some control over the system even
>  	  if the system crashes for example during kernel debugging (e.g., you
Please reject this patch, the setting for UML is just elsewhere, in 
arch/um/Kconfig (and depends on MCONSOLE).

If kbuild doesn't handle well having an option declared twice now (it isn't 
very happy but it worked when I added the above dependency) we can rename the 
one in arch/um/Kconfig to MAGIC_SYSRQ_UML and make the one above like this 
(untested):

config MAGIC_SYSRQ
	bool
	prompt "Magic SysRq key" if !UML
	depends on MAGIC_SYSRQ_UML || !UML
	default y if UML

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

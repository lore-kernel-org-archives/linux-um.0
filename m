Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EuHxq-000784-B3 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jan 2006 15:22:42 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1EuHxp-0003AN-1u
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jan 2006 15:22:42 -0800
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20060104152433.7304ec75.akpm@osdl.org>
In-Reply-To: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [PATCH 4/9] UML - Better diagnostics for broken
	configs
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 4 Jan 2006 15:24:33 -0800
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike <jdike@addtoit.com> wrote:
>
> Produce a compile-time error if both MODE_SKAS and MODE_TT are disabled.
> 
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> 
> Index: linux-2.6.15/arch/um/include/choose-mode.h
> ===================================================================
> --- linux-2.6.15.orig/arch/um/include/choose-mode.h	2005-08-28 19:41:01.000000000 -0400
> +++ linux-2.6.15/arch/um/include/choose-mode.h	2005-11-17 10:43:47.000000000 -0500
> @@ -23,6 +23,9 @@ static inline void *__choose_mode(void *
>  
>  #elif defined(UML_CONFIG_MODE_TT)
>  #define CHOOSE_MODE(tt, skas) (tt)
> +
> +#else
> +#error CONFIG_MODE_SKAS and CONFIG_MODE_TT are both disabled
>  #endif
>  
>  #define CHOOSE_MODE_PROC(tt, skas, args...) \

Is there no sane way to prevent this situation within Kconfig?


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0wS1-0004Qr-6B for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jul 2006 01:21:37 -0700
Received: from web25222.mail.ukl.yahoo.com ([217.146.176.208])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1G0wRz-00044Q-Ar
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jul 2006 01:21:37 -0700
Message-ID: <20060713082129.95046.qmail@web25222.mail.ukl.yahoo.com>
Date: Thu, 13 Jul 2006 10:21:29 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
In-Reply-To: <44B5659E.5070000@zytor.com>
MIME-Version: 1.0
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

"H. Peter Anvin" <hpa@zytor.com> ha scritto: 

> Why not:
> 
> config MAGIC_SYSRQ
> 	bool
> 	prompt "Magic SysRq key"
> 	depends on !UML || MCONSOLE
> 	default y if UML
> 
> 	-hpa

Because it has always been elsewhere in Kconfig (near MCONSOLE) for a
meaningful reason (it is used through mconsole) and nobody has
decided to move it.

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

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0lxl-0008B5-MQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 14:10:35 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G0lxi-0007bb-Ks
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 14:09:41 -0700
Date: Wed, 12 Jul 2006 17:09:43 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060712210943.GA23195@ccure.user-mode-linux.org>
References: <200607121640.k6CGe6nP021236@ccure.user-mode-linux.org>
	<200607122056.01202.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200607122056.01202.blaisorblade@yahoo.it>
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Jul 12, 2006 at 08:56:00PM +0200, Blaisorblade wrote:
> Please reject this patch, the setting for UML is just elsewhere, in 
> arch/um/Kconfig (and depends on MCONSOLE).

Whoops, right.

I swear I did a search on SYSRQ in menuconfig and the only thing that came
up was the lib/Kconfig.debug one.

I just checked, and it finds the arch/um one...

				Jeff


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

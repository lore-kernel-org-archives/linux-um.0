Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FygoR-0003sn-1k for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 20:15:27 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FygoP-0004bm-IE
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 20:15:26 -0700
Date: Thu, 6 Jul 2006 23:15:21 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060707031521.GA10357@ccure.user-mode-linux.org>
References: <006401c69c19$eb9edbd0$d4190a0a@centecnetworks.com>
	<20060630134509.GA3510@ccure.user-mode-linux.org>
	<007401c69ca6$a6e00040$d4190a0a@centecnetworks.com>
	<20060707004552.GC8756@ccure.user-mode-linux.org>
	<1152238941.13247.67.camel@athena.fprintf.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1152238941.13247.67.camel@athena.fprintf.net>
Subject: Re: [uml-devel] [uml-user] UML 2.6.17 problems (section mismatch,
	get_skas_faultinfo : failed to wait for SIGUSR1/SIGTRAP)
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
To: Daniel Gryniewicz <dang@gentoo.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Jul 06, 2006 at 10:22:21PM -0400, Daniel Gryniewicz wrote:
> Isn't this what CONFIG_FORCE_INLINING is supposed to do?  Granted, it
> appears to only work for gcc4, but...

It's supposed to force inlining for performance, not for correctness.

If a config setting is needed for correctness, it shouldn't be a config
setting.

				Jeff

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

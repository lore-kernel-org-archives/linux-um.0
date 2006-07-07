Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FywSu-0004EX-07 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2006 12:58:16 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FywSr-0005fD-Ek
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2006 12:58:16 -0700
Date: Fri, 7 Jul 2006 15:58:21 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060707195821.GA5988@ccure.user-mode-linux.org>
References: <20060707165851.GA5391@ccure.user-mode-linux.org>
	<7B4268E5ACB878429B58D4BE5B780E83010B6B49@NWS-EXCH2.nws.oregonstate.edu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7B4268E5ACB878429B58D4BE5B780E83010B6B49@NWS-EXCH2.nws.oregonstate.edu>
Subject: Re: [uml-devel] [PATCH 19/19] UML - Make mconsole
	versionrequestshappen in a process
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
To: "Brock, Anthony - NET" <Anthony.Brock@oregonstate.edu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, Jul 07, 2006 at 10:07:25AM -0700, Brock, Anthony - NET wrote:
> What is the recommended means for verifying that a UML process is
> running?

Depends on what level of "running" you want to check for.  Ping will
tell you if the kernel can respond to interrupts.  mconsole version
(now) will tell you whether it can schedule processes.  mconsole sysrq
is another way to check that it is alive enough to respond to
interrupts.

				Jeff

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

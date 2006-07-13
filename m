Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G16Gj-0001cG-Nh for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jul 2006 11:50:37 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1G16Gh-0007EW-V6
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jul 2006 11:50:37 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 13 Jul 2006 20:50:29 +0200
References: <023b01c6a67a$c94b6420$d4190a0a@centecnetworks.com>
	<20060713184556.GB5413@ccure.user-mode-linux.org>
In-Reply-To: <20060713184556.GB5413@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607132050.30062.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SIGTRAP and gdb multithreading program under UML
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
Cc: Jeff Dike <jdike@addtoit.com>, Miao Qingjun <qmiao@centecnetworks.com>, user-mode-linux-user@lists.sourceforge.net

On Thursday 13 July 2006 20:45, Jeff Dike wrote:
> On Thu, Jul 13, 2006 at 08:49:31PM +0800, Miao Qingjun wrote:
> > Under UML bash, I gdb a multithreading program, and set a breakpoint on
> > thread entry function, But when run it, gdb is not stop at the
> > breakpoint,
> > instead, program exit because:
> >
> > Program terminated with signal SIGTRAP, Trace/breakpoint trap.
>
> What version of UML?  Sounds like a bug in UML interrupt handling.
>
> Can you send me a copy of the binary you're debugging?
SIGTRAP must be sent for the breakpoint - I think the problem is that either 
GDB misinterprets it or it is not sent the correct way.

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

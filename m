Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 13 Jul 2006 14:45:56 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060713184556.GB5413@ccure.user-mode-linux.org>
References: <023b01c6a67a$c94b6420$d4190a0a@centecnetworks.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <023b01c6a67a$c94b6420$d4190a0a@centecnetworks.com>
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
To: Miao Qingjun <qmiao@centecnetworks.com>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jul 13, 2006 at 08:49:31PM +0800, Miao Qingjun wrote:
> Under UML bash, I gdb a multithreading program, and set a breakpoint on thread entry function,
> But when run it, gdb is not stop at the breakpoint, 
> instead, program exit because:
> 
> Program terminated with signal SIGTRAP, Trace/breakpoint trap.

What version of UML?  Sounds like a bug in UML interrupt handling.

Can you send me a copy of the binary you're debugging?

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

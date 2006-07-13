Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 13 Jul 2006 15:16:42 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060713191642.GA6048@ccure.user-mode-linux.org>
References: <023b01c6a67a$c94b6420$d4190a0a@centecnetworks.com>
	<20060713184556.GB5413@ccure.user-mode-linux.org>
	<200607132050.30062.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200607132050.30062.blaisorblade@yahoo.it>
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Miao Qingjun <qmiao@centecnetworks.com>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jul 13, 2006 at 08:50:29PM +0200, Blaisorblade wrote:
> SIGTRAP must be sent for the breakpoint - I think the problem is that either 
> GDB misinterprets it or it is not sent the correct way.

I'm thinking the latter...

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

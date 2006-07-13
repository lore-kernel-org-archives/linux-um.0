Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 13 Jul 2006 15:37:12 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060713193712.GE5413@ccure.user-mode-linux.org>
References: <019a01c6a54f$405ffdf0$d4190a0a@centecnetworks.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <019a01c6a54f$405ffdf0$d4190a0a@centecnetworks.com>
Subject: Re: [uml-devel] [uml-user] uml and gdb debugging questions
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

On Wed, Jul 12, 2006 at 09:05:22AM +0800, Miao Qingjun wrote:
> I start "gdb uml", "b sys_init_module", then "run",
> but gdb is not break at sys_init_module() when I insmod LKM?
> Why? How can I do it?

Some versions of gdb don't work well on UML.  One thing that often
works is to attach to UML when it's booted, just before doing whatever
you want to debug.

				Jeff

> When I type control-c in gdb, the virtual console xterm is also
> closed,

How are you running UML?  You normally can't ^C to get back to gdb
because the UML console has put the terminal in raw mode, so it can
see ^C, ^Z, etc and pass them along to the UML foreground process.

What I normally do is kill -INT <pid>, where pid is the lowest UML
pid.

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

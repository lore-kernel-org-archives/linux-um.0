Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G1SjR-0002Lc-54 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jul 2006 11:49:45 -0700
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1G1SjQ-0002xC-JF
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jul 2006 11:49:45 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Fri, 14 Jul 2006 20:48:56 +0200
References: <019a01c6a54f$405ffdf0$d4190a0a@centecnetworks.com>
	<20060713193712.GE5413@ccure.user-mode-linux.org>
In-Reply-To: <20060713193712.GE5413@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607142048.57255.blaisorblade@yahoo.it>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Miao Qingjun <qmiao@centecnetworks.com>, user-mode-linux-user@lists.sourceforge.net

On Thursday 13 July 2006 21:37, Jeff Dike wrote:
> On Wed, Jul 12, 2006 at 09:05:22AM +0800, Miao Qingjun wrote:
> > I start "gdb uml", "b sys_init_module", then "run",
> > but gdb is not break at sys_init_module() when I insmod LKM?
> > Why? How can I do it?
>
> Some versions of gdb don't work well on UML.  One thing that often
> works is to attach to UML when it's booted, just before doing whatever
> you want to debug.
>
> 				Jeff
>
> > When I type control-c in gdb, the virtual console xterm is also
> > closed,
>
> How are you running UML?  You normally can't ^C to get back to gdb
> because the UML console has put the terminal in raw mode, so it can
> see ^C, ^Z, etc and pass them along to the UML foreground process.
>
> What I normally do is kill -INT <pid>, where pid is the lowest UML
> pid.
I forgot one note - I either attach gdb to UML after boot or boot it with con0 
redirected away from fd:0,fd:1.
And I often find that setting a breakpoint after UML has fully booted works 
better than setting it before boot. A lot better.

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

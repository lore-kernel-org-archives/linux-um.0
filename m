Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0jwH-0004yM-Ov for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 12:00:01 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1G0jwD-000096-W7
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 12:00:01 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 12 Jul 2006 20:59:55 +0200
References: <019a01c6a54f$405ffdf0$d4190a0a@centecnetworks.com>
In-Reply-To: <019a01c6a54f$405ffdf0$d4190a0a@centecnetworks.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607122059.55708.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] uml and gdb debugging questions
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
Cc: Miao Qingjun <qmiao@centecnetworks.com>, user-mode-linux-user@lists.sourceforge.net

On Wednesday 12 July 2006 03:05, Miao Qingjun wrote:
> Hi,
>
> I have several problems about uml-2.6.17 and gdb debugging.
>
> I start "gdb uml", "b sys_init_module", then "run",
> but gdb is not break at sys_init_module() when I insmod LKM?
> Why? How can I do it?
Sometimes breakpoints don't work in GDB :-(. An hack was posted: it was based 
on recompiling after adding code calling pause() if a variable was set and 
setting the variable only from the debugger; however some special care was 
needed to avoid gcc recognizing nobody set the variable and optimizing the 
check out.
> When I type control-c in gdb, the virtual console xterm is also closed,
This doesn't happen here for what I remember, I used both Ctrl-C and kill -INT 
<main pid> to get back the control in the console.
> I just want to enter gdb command line to single step kernel code, how can I
> do it?

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

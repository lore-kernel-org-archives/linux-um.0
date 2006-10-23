Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gc6kM-0002av-03 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Oct 2006 13:50:10 -0700
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gc6kJ-00007T-J3
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Oct 2006 13:50:10 -0700
Received: from mail.jjkola.tk (88.192.55.138) by
	pne-smtpout4-sn2.hy.skanova.net (7.2.075)
	id 44A2EAB8004EAFFD for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Oct 2006 22:49:58 +0200
Received: from jyrki.jjkola.tk ([192.168.1.3])
	by mail.jjkola.tk with esmtp (Exim 4.60)
	(envelope-from <jyrki@jjkola.tk>) id 1Gc6mI-0006oB-6H
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Oct 2006 23:52:10 +0300
Message-ID: <453D2AD5.2040907@jjkola.tk>
Date: Mon, 23 Oct 2006 23:49:25 +0300
From: Jyrki Jaakkola <jyrki@jjkola.tk>
MIME-Version: 1.0
References: <v0r6x41bnb.fsf@marajade.sandelman.ca>	<200610210238.16557.blaisorblade@yahoo.it>	<17462.1161394764@sandelman.ottawa.on.ca>	<200610210454.23887.blaisorblade@yahoo.it>
	<v0mz7m3gwq.fsf@marajade.sandelman.ca>
In-Reply-To: <v0mz7m3gwq.fsf@marajade.sandelman.ca>
Subject: Re: [uml-devel] Xen 3.0.2 and UML guest
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

Hello!

Michael Richardson wrote:
>     Blaisorblade> A strace -t (or whichever option shows the timings)
>     Blaisorblade> would help finding _where_
>     Blaisorblade> is the big pause...
> 
>     >> I think you mean -T?
> 
>     Blaisorblade> Actually -t prints timestamps, which can be more useful to look at "when are 
>     Blaisorblade> we?".
> 
>   okay, I can do -T if you want.
>   http://www.sandelman.ca/tmp/east.trace.gz

from strace command line help:
-t -- absolute timestamp
-T -- print time spent in each syscall

so if you use -T it will only tell how long did it spend in a system 
call and not what was the current time of execution (when calling a 
system call).

Regards,

Jyrki Jaakkola

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fc7DP-0001ZJ-TG for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 May 2006 13:47:55 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fc7DQ-0000XB-1N for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 May 2006 13:47:56 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Fc7DM-0000WI-8q
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 May 2006 13:47:56 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Problem on generation a locales on uml image
References: <20060505124937.GA4327@SteX> <20060505141208.GA4940@SteX>
	<20060505145248.GE23227@inferi.kami.home>
In-Reply-To: <20060505145248.GE23227@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605052247.29478.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 5 May 2006 22:47:28 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Mattia Dongili <malattia@linux.it>, Stefano Melchior <stefano.melchior@openlabs.it>

On Friday 05 May 2006 16:52, Mattia Dongili wrote:
> On Fri, May 05, 2006 at 04:12:08PM +0200, Stefano Melchior wrote:
> > On Fri, May 05, 2006 at 02:49:37PM +0200, Stefano Melchior wrote:

> [...]

> AFAIU, it's an harmless warning telling that UML didn't receive the
> timer interrupt for too long.

Yes, more exactly it happens when the kernel didn't schedule a certain task 
(watchdog/$CPUID) for execution for 10 seconds.

The current impression is that it happens on high load, for instance on high 
disk load IIRC. It's harmless as long as UML keeps running.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

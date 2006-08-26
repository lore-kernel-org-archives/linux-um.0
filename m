Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GGxsk-0005MN-LV for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Aug 2006 06:07:26 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GGxsh-0002yj-Ug
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Aug 2006 06:07:26 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 26 Aug 2006 15:07:08 +0200
References: <200608171256.57196.peter@fusselt.net>
	<517e86fb0608201103r7f07f57cxc433d1d15d49824b@mail.gmail.com>
	<200608261435.17970.peter@fusselt.net>
In-Reply-To: <200608261435.17970.peter@fusselt.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608261507.09004.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Strange behaviour in eth assignments
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
Cc: Peter Hovorka <peter@fusselt.net>

On Saturday 26 August 2006 14:35, Peter Hovorka wrote:
> Hi there,
>
> my sincere apologies to all of you for bothering about the Ubuntu eth
> problem.

Thanks for your apologies but thanks anyway for your competent cooperation.

> After talking to the ubuntu team we found out that the ubuntu 
> installer makes some entries in /etc/iftab to help udev whilst booting
> the system. There were the two entries from the host system with eth0
> and eth1 - entries deleted the whole system runs well.

I'm starting to get sick of udev - on Ubuntu currently I'm unable to compile a 
vanilla kernel that works (I must still do more complete tests but I'm 
already beyond the "I've misconfigured something" moment).
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

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GEoRn-0004po-0Y for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Aug 2006 07:38:43 -0700
Received: from 213-203-244-217.kunde.vdserver.de
	([213.203.244.217] helo=alpha.korypet.com ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GEoRk-0000ul-E6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Aug 2006 07:38:42 -0700
Received: from p5080d7a3.dip.t-dialin.net ([80.128.215.163]
	helo=bravo.korypet.de)
	by alpha.korypet.com with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50) id 1GEoRf-0001qG-6j
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Aug 2006 14:38:35 +0000
From: Peter Hovorka <peter@fusselt.net>
Date: Sun, 20 Aug 2006 16:38:32 +0200
References: <200608171256.57196.peter@fusselt.net>
	<200608191838.51481.peter@fusselt.net>
	<200608201224.51029.blaisorblade@yahoo.it>
In-Reply-To: <200608201224.51029.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608201638.33115.peter@fusselt.net>
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

Hi,

> > Yes, Sir.
>
> I didn't want to be rude, sorry.

Oh no - I guess I should have attached some kind of smiley there, I 
didn't think of you as rude. It's quite contrary: I'm very glad that 
you do all this work! So don't mind!

> I was just surprised, and one of my thoughts was "it is barfing on
> 112 because maybe the code is stupid and expects 1 digit". So I asked
> just to make sure.

And that was totally right, be assured of that.

> About Ubuntu, make sure ifrename is not installed and
> /etc/network/if-* and /etc/rc2.d do not mention ifrename, and that
> ifrename is not installed. I can only think that some hotplug script
> is receiving an event through sysfs / hotplug / some such hell and is
> renaming the interface.

Thanks for your thoughts - I'll try to gather information about that in 
the ubuntu forum/s and/or their list/s about that. If I get a solution 
from somewhere, I'll post it to the uml user's list.

Once again many thanks,

Peter

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

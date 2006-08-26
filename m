Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GGxNn-0002NT-Fg for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Aug 2006 05:35:27 -0700
Received: from 213-203-244-217.kunde.vdserver.de
	([213.203.244.217] helo=alpha.korypet.com ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GGxNm-0002dW-2e
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Aug 2006 05:35:27 -0700
Received: from p5080e6da.dip.t-dialin.net ([80.128.230.218]
	helo=bravo.korypet.de)
	by alpha.korypet.com with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50) id 1GGxNf-0003Bj-HP
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Aug 2006 12:35:19 +0000
From: Peter Hovorka <peter@fusselt.net>
Date: Sat, 26 Aug 2006 14:35:17 +0200
References: <200608171256.57196.peter@fusselt.net>
	<200608201638.33115.peter@fusselt.net>
	<517e86fb0608201103r7f07f57cxc433d1d15d49824b@mail.gmail.com>
In-Reply-To: <517e86fb0608201103r7f07f57cxc433d1d15d49824b@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608261435.17970.peter@fusselt.net>
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

Hi there,

my sincere apologies to all of you for bothering about the Ubuntu eth 
problem. After talking to the ubuntu team we found out that the ubuntu 
installer makes some entries in /etc/iftab to help udev whilst booting 
the system. There were the two entries from the host system with eth0 
and eth1 - entries deleted the whole system runs well.
 
Kind regards,
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

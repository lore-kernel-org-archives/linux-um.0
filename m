Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GDfZE-0001JL-73 for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Aug 2006 03:57:40 -0700
Received: from 213-203-244-217.kunde.vdserver.de
	([213.203.244.217] helo=alpha.korypet.com ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GDfZC-0007XW-QH
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Aug 2006 03:57:40 -0700
Received: from p5080fa71.dip.t-dialin.net ([80.128.250.113]
	helo=bravo.korypet.de)
	by alpha.korypet.com with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50) id 1GDfZ2-0008ET-TZ
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Aug 2006 10:57:29 +0000
From: Peter Hovorka <peter@fusselt.net>
Date: Thu, 17 Aug 2006 12:56:57 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608171256.57196.peter@fusselt.net>
Subject: [uml-devel] Strange behaviour in eth assignments
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
To: User-mode-linux-devel@lists.sourceforge.net

Hi,

Jeff told me to drop a note here about the following occurence:

Having compiled a 2.6.16.27 guest kernel with a bb1 patchset, I was 
unable to bring up an eth0 via tun/tap. The kernel runs well, but a 
command line of

./um2.6.16.27-bb1 ubd0=root_fs ubd1=swap_fs eth0=tuntap,tap112 mem=100M

starts the instance well, but a command inside the instance of 'ifconfig 
-a' results in an 'eth2' device being ready to be brought up. I haven't 
found a way to bring up an 'eth0' or an 'eth1' device inside the 
instance.

Has anyone had this kind of problem before? I've got no clue about its 
cause, this is what I found out until now:

- The problem seems to be independent from the Host Kernel. Using the 
above Guest Kernel, the system will always prepare eth2.

- The problem seems to be independent from most of the other options in 
the Kernel config as there are statically linked, network options etc.

- The problem is not (!) present with older Kernels. I did run some 
tests with other Kernels, the following ones failed to bring up eth0:

2.6.16.27 with bb1
2.6.16.9 with bs2

The following versions were ok in bringing up eth0 as usual:

2.6.14.3 with bs3
2.6.13.4 with bs5

- I haven't tried non-SKAS3 usage yet

As Jeff told me yesterday that there was possibly no change in that 
region of the UML code, I suspect that any kind of change in the recent 
Kernel sources has caused this artefact to show, sadly I haven't got 
the faintest idea of Kernel development myself, so I'm writing this to 
the devel list.

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

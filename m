Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BoY9x-0004Nq-RF for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Jul 2004 18:50:41 -0700
Received: from b.mail.peak.org ([69.59.192.42])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BoY9x-00053O-HY
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Jul 2004 18:50:41 -0700
Received: from a.shell.peak.org ([69.59.192.81])
	by b.mail.peak.org (8.12.10/8.12.8) with ESMTP id i6P1oYTD029154
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 24 Jul 2004 18:50:34 -0700 (PDT)
Received: (from fixin@localhost)
	by a.shell.peak.org (8.12.10/8.12.10/Submit) id i6P1oXdC008030
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Jul 2004 18:50:33 -0700
From: Eric House <fixin@peak.org>
Message-ID: <20040725015031.GN783@peak.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Some firewalls require disabling ECN in the UML kernel
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
Date: Sat, 24 Jul 2004 18:50:32 -0700
To: user-mode-linux-devel@lists.sourceforge.net

This mail details the solution to a problem I had with UML networking.
My UML instance was able to ping any host on the LAN or internet, but
could only make TCP connections within the LAN.  On looking closer I
found that the initial packets were making it from the host to the
router and then to my cable modem but not reaching the internet
server.  I was unable to determine whether the cable modem was
dropping them (or why), or whether they were making it further.

Eventually I looked closely at the packets leaving the router, both
for (successful) telnet connections from non-UML hosts and for the
(doomed) attempt from the UML instance.  The only difference,
according to tcpdump running on the router, was that the
non-UML-sourced packets had only the S flag set while the UML-sourced
packets had three set: SWE.

The first hit when googling for "tcpdump SWE" is 

http://lists.debian.org/debian-user/2001/06/msg01577.html

a page that explains that some commercial firewalls block packets for
which TCP ECN is enabled.  And sure enough, the kernel that's part of
Debian's UML package has it enabled.  Once I turned it off using the
following command all was well.  I'm currently running apt-get to
bring the rootfs up to date.

sysctl -w net.ipv4.tcp_ecn=0

Of course I still don't know where the packets were getting blocked,
but my ActionTek DSL modem is the most likely suspect.

UML rocks!  Thanks!

--Eric House
-- 
******************************************************************************
* From the desktop of: Eric House, fixin@peak.org                            *
*    Crosswords 4.0.6 for PocketPC is out!: <http://xwords.sourceforge.net>  *
******************************************************************************


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

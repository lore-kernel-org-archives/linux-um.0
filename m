Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIrEj-0004QW-Hv for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Oct 2004 09:16:53 -0700
Received: from smtp.wp.pl ([212.77.101.160])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CIrEh-0003Rq-DX
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Oct 2004 09:16:53 -0700
Received: from lodz106.vline.pl (HELO [172.16.13.24]) (sikkh@[212.191.130.106])
	(envelope-sender <sikkh@wp.pl>) by smtp.wp.pl (WP-SMTPD) with SMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	16 Oct 2004 18:16:36 +0200
From: Piotr Neuman <sikkh@wp.pl>
MIME-Version: 1.0
Content-Type: Multipart/Mixed; boundary="Boundary-00=_tDcYBDqyiHi1FPc";
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410161816.36586.sikkh@wp.pl>
Subject: [uml-devel] Humfs tdb metadata backend
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
Date: Sat, 16 Oct 2004 18:16:36 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi

I synchronized tdb metadata backend with 2.6.8-um1 + updated externfs (from 
patches page). It generally works, just need to clean up warnings and 
stuff ;-).

To test it first apply externfs patch onto 2.6.8-um1 (I don't even mention 
other fixes to get 2.6.8-um1 to build):

http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.8.1-1um/patches/externfs

Then download and apply:

http://kem.p.lodz.pl/~peter/uml/2.6.8-um1-meta_tdb.patch.bz2
http://kem.p.lodz.pl/~peter/uml/2.6.8-um1-humfs_config.patch.bz2

Reconfigure kernel, enable HUMFS_TDB ("tdb HUMFS metadata storage") and 
rebuild...

Mkfs.humfs from hostfs_utils supports tdb, so use that for initializing humfs 
mount dir:

http://kem.p.lodz.pl/~peter/uml/hostfs_utils-16.10.2004.tgz

Alternatively humfs will initialize mount point itself if only valid 
superblock file is found in mount directory at mount time (expect this 
feature to go away soon, becose of mkfs.humfs).

To mount humfs:

mount none <mount point in UML system> -t humfs -o <humfs directory on host 
filesystem>

Please test and report bugs or feature requests...

Regards

Piotr Neuman

ps. thanks to Jeff Dike and Blaisorblade for making 2.6 UML kernels finally 
work well ;-)


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
--Boundary-00=_tDcYBDqyiHi1FPc

-


--Boundary-00=_tDcYBDqyiHi1FPc--

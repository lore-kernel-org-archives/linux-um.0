Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BmGQp-0001sF-ST for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 11:30:39 -0700
Received: from smtp.wp.pl ([212.77.101.160])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BmGQp-0007Xw-De
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 11:30:39 -0700
Received: from lodz106.vline.pl (HELO 172.16.13.24) (sikkh@[212.191.130.106])
	(envelope-sender <sikkh@wp.pl>) by smtp.wp.pl (WP-SMTPD) with SMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	18 Jul 2004 20:30:30 +0200
From: Piotr Neuman <sikkh@wp.pl>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YHs+AobBT52L8E8"
Message-Id: <200407182030.48890.sikkh@wp.pl>
Subject: [uml-devel] Humfs metadata api tdb backend for 2.4.26-um2
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
Date: Sun, 18 Jul 2004 20:30:48 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_YHs+AobBT52L8E8
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry for copying almost "as is" my previous tdb backend announcement, but I 
don't really have much more to say ;-).

I've been working on metadata backend that would use tdb (meta_tdb). It's
advantages over meta_fs include:

- proper handling of "metadata" named files and dirs (Jeff Dike fixed it but 
it's still not "clean" imo, but that's the handicap of trying to implement as 
metadata files),
- compactness (no directory/files structure overhead and storing data in
binary),

Performace is yet to be tested extensively and compared to meta_fs.

There are also additions to humfs features:

- humfs stores file/dir access modes now (fixes some chmod problems, Jeff Dike 
made it part of -um2 so it's by default in UML now),
- humfs automatically initializes mount dir if only valid "superblock" file
 is present in it (humfsify for tdb is not yet ready ;),
- humfs now supports unmountig (neceseary fo meta_tdb).

Example "superblock" is attached. To try meta_fs backend with it just change
"tdb" to "shadow_fs". To mount humfs:

mount none <uml mount dir> -t humfs -o <host dir>

The patch is against UML release ver. 2.4.26-2. This release is much better 
than 2.4.26-1 when it comes to stability.

The patch is available here:

http://kem.p.lodz.pl/~peter/humfs-2.4.26-2-meta_tdb-1.patch.bz2

Humfs seems usable now (both meta_fs and meta_tdb can be used as root 
filesystem and boot), but as I tested it there are still issues, so it 
shouldn't be used in production systems. I will try to work them out 
(especially as Jeff is away for OLS, having fun I presume ;-).

Good luck and have fun testing...

--Boundary-00=_YHs+AobBT52L8E8
Content-Type: text/plain;
  charset="us-ascii";
  name="superblock"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="superblock"

version 1
used 394962944
total 734003200
metadata tdb

--Boundary-00=_YHs+AobBT52L8E8--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

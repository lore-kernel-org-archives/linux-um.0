Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CicwP-0005nO-7E for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Dec 2004 10:16:29 -0800
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CicwK-0006SL-6d
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Dec 2004 10:16:29 -0800
Received: from sandelman.ottawa.on.ca (wlan232.sandelman.ca [205.150.200.232])
	by pike.sandelman.ca (Postfix) with ESMTP id ADAF860104
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 26 Dec 2004 13:16:13 -0500 (EST)
Received: from marajade.sandelman.ottawa.on.ca (marajade [127.0.0.1])
	by sandelman.ottawa.on.ca (Postfix) with ESMTP id 4ED2DBCEE
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 26 Dec 2004 13:16:13 -0500 (EST)
From: "Michael Richardson" <mcr@sandelman.ottawa.on.ca>
Message-ID: <27776.1104084973@marajade.sandelman.ottawa.on.ca>
Subject: [uml-devel] synchronous hostfs
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
Date: Sun, 26 Dec 2004 13:16:13 -0500
To: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----


I'm running 2.4.26-um3.
I happen to be running hostfs with NFS underneath. 
I get core dumps from my application, and I want to gdb them outside
of the UML. I had to switch from core dump to NFS (which seems to fail
now) to putting them in /tmp (which is ramdisk), and then move them to
/var/tmp, which is hostfs. 

Still, I now have to use unique file names, or things get confused
between host and guest.

I also like to do:
  "make DESTDIR=/uml/root/file install"

from outside. This now only has effect if I umount/mount the file
system. (I know have a /usr/local mount just for this, even though
/usr/local is inside of /)
It used to be that this was a problem only if the program was running.

Is there some way to defeat the caching that is occuring?
or even to just flush it? (other than umount)

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQc7/64qHRg3pndX9AQHUpQP9Fo08vmYRdHJ8emMvUsS5a05oAxNfpt5q
qELzCip/zknhJWKojR7JkbpzQdW0jtTbSBnq+B3HaUeFBCwoA8wGOCNd1h8BGkIX
lolSgHJOOco6V01f/yct1rhoPv7NxUavsMCyoTVMC1QsFrHuN++69vMqeZcJjQ2K
6bS8IkpswgA=
=KJhJ
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBey4-000262-Nw for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 12:13:40 -0700
Received: from smtp.wp.pl ([212.77.101.160])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BBey0-0001FD-9C
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 12:13:36 -0700
Received: from host-116-242.rev.vline.pl (HELO [172.16.13.24])
	(sikkh@[217.76.116.242]) (envelope-sender <sikkh@wp.pl>)
	by smtp.wp.pl (wp-smtpd) with RC4-MD5 encrypted SMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	8 Apr 2004 21:13:24 +0200
From: Piotr Neuman <sikkh@wp.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404082114.49123.sikkh@wp.pl>
Subject: [uml-devel] Example databases to keep humfs metadata
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
Date: Thu, 8 Apr 2004 21:14:49 +0200
To: user-mode-linux-devel@lists.sourceforge.net

gdbm: http://www.gnu.org/software/gdbm/gdbm.html

Simple file database, using hashing. Should be relatively easy to include with 
UML sources. It's pretty standard in all Linux distributions.

qdbm: http://qdbm.sourceforge.net/

More up to date than gdbm. Also has B+tree algorithms, so it may be more 
apriopriate for filesystem data. Disadvantage is it's larger size but I 
believe it could be trimmed down for UML.

API similiarity between gdbm and qbdm should allow for easy transition if 
needed.

Berkeley DB: http://www.sleepycat.com/

Very powerfull (logging for example) but it's features are rather overkill. 
Advantage is that it's available on all major distributions (UML could link 
to it dynamically).

Those are just a few possibilities, I'm sure there are other options (like 
open source SQL databases ;).


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

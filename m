Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AjN0T-0008Vg-1g for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jan 2004 10:23:13 -0800
Received: from cyrus.vandervecken.com ([64.124.43.248])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AjN0S-0002pi-QU for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jan 2004 10:23:12 -0800
Received: from geoff by cyrus.vandervecken.com with local (Exim 3.35 #1
	(Debian)) id 1AjN0Q-0000ix-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 Jan 2004 10:23:10 -0800
From: Geoff Thorpe <geoff@geoffthorpe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401211323.13372.geoff@geoffthorpe.net>
Subject: [uml-devel] status of valgrind/uml interaction?
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
Date: Wed, 21 Jan 2004 13:23:13 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Hi all,

I've been scanning over the list archives for the last few times valgrind 
was discussed. It appeared from that surfing that some fixes need to be 
applied to valgrind (or have they been committed?) for this to gel, and 
that perhaps various false-positives turn up due to valgrind's ignorance 
of kmalloc/[etc].

Has anything changed on this front, and does anyone have a link to these 
valgrind patches/fixes that they could send me? We are already using UML 
for emulation and testing of kernel modules for external hardware (which 
in turn is also emulated on the same host), so the possibility of using 
valgrind to sanitise behaviour in the modules is very interesting. If 
this is already summarised somewhere a link would be very much 
appreciated.

TIA for any tips.

Cheers,
Geoff

-- 
Geoff Thorpe
geoff@geoffthorpe.net
http://www.geoffthorpe.net/



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

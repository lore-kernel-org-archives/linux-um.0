Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cf5bZ-0002x4-DO for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Dec 2004 16:04:21 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cf5bY-0003dc-Rs for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Dec 2004 16:04:21 -0800
Received: from hawk (mothership.theshore.net [69.137.84.52])
	by www.theshore.net (8.12.9/8.9.1) with SMTP id iBH04JMC019285
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 16 Dec 2004 19:04:19 -0500
Message-ID: <000601c4e3cc$119a1280$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] unable to unmount tmpfs problem lives on
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
Date: Thu, 16 Dec 2004 18:05:04 -0600
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

I'm still seeing the "unable to unmount tmpfs" problem like we had before the
fix-kill patch.  All my UMLs have the fix-kill fixes, and yet under some
circumstances (yet unknown), the host kernel refuses to unmount the tmpfs mount that
a UML had used for its VM file.

It's happening under a number of kernels:

2.6.9
2.6.9-ck3
2.6.10-rc2-bk7

lsof shows nothing, but umount still complains that the mountpoint is in-use.

-Chris



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

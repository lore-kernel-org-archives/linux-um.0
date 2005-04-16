Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMkDg-0004Vf-AE for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Apr 2005 03:08:08 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DMkDc-00026J-66 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Apr 2005 03:08:08 -0700
Message-ID: <007a01c5426c$ee241350$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] CowLoop
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
Date: Sat, 16 Apr 2005 12:13:26 +0200
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

Hi !
I think this is interesting for UserModeLinux:

http://www.atconsultancy.nl/cowloop

CowLoop is a kernel level driver and gives CopyOnWrite devices.

There was some discussion a long time ago, about the annoyance not being able to mount a UML-Cowfile outside UML because of missing
kernel support.

Sure - you will not be able to mount a UML Cowfile with cowloop (should be incompatible format), but I think you will be able to use
a cowloop with uml.

This project doesn`t seem very popular - so maybe announcing it here should give it some attention.

regards
roland



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DD9h7-00050U-I3 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 15:18:53 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DD9h4-0003vP-Hu
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 15:18:53 -0800
Received: from knoppix (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j2L0WUQK029014
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 20 Mar 2005 19:32:39 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200503201417.59739.rob@landley.net>
Subject: [uml-devel] Hostfs permission checks are all wonky.
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
Date: Sun, 20 Mar 2005 14:17:59 -0500
To: user-mode-linux-devel@lists.sourceforge.net

If I open a device like /dev/loop0 or /dev/console from a hostfs mount, I'll 
get the UML device, not the host device, right?

So why are the permissions checks on hostfs devices done relative to the 
_host_ user?  If /dev/console doesn't belong to the current user, the system 
can't even open the initial console, despite the fact the output does NOT go 
to TTY1 if I'm running it an xterm.

Similarly, if /dev/loop0 is chmod 600 and I run UML as a normal user and try 
to do a mount -o loop, it says it can't find a loop device.  Yet if I run UML 
as root, it doesn't allocate one of the parent's loop devices, UML does it 
internally...

I'm told there's a major rewrite of hostfs underway.  Is it worth me trying to 
patch the existing hostfs code, or should I go try to track down the new 
stuff and try it out?

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

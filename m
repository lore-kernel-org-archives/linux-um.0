Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAN1y-0007LA-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 22:20:06 -0700
Received: from fed1mtao05.cox.net ([68.6.19.126])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AAN17-00005D-SR
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 16 Oct 2003 22:19:13 -0700
Received: from easyco.com ([68.109.90.156]) by fed1mtao05.cox.net
          (InterMail vM.5.01.06.05 201-253-122-130-105-20030824) with ESMTP
          id <20031017051634.DZMV10143.fed1mtao05.cox.net@easyco.com>
          for <user-mode-linux-devel@lists.sourceforge.net>;
          Fri, 17 Oct 2003 01:16:34 -0400
Message-ID: <3F8F7C06.7080306@easyco.com>
From: Doug Dumitru <doug@easyco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Hardening hostfs
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 16 Oct 2003 22:20:06 -0700
To: user-mode-linux-devel@lists.sourceforge.net

I have been trying to build a reasonably bullet-proof UML kernel that 
prevents users from doing hostfs mounts.

I have observed some behaviours which are non ideal.

1.  If hostfs is compiled in as a module, then the hostfs=... 
command-line arguments are not used.  Thus, trying to restrict access 
with this does not appear to be effective.

2.  If hostfs is not compiled in at all, you can still load a hostfs 
module assuming that you can build one off-line.  This would allow a 
compromise of an underlying system by a "moderate" hacker with root 
access to the virtual.

The best that I have come up with is:

o Run UML in a chroot jail.
o Compile UML with hostfs included and not as a module
o Supply a command line ... hostfs=/doesnotexist,append when booting

I don't think that this is perfect as you could still load a LKM and 
probably get to the underlying filesystem.  At least it is chroot'd at 
this point.

I have been trying to work out a way to further harden this, but there 
seem to be a number of stumbling blocks.

A lot of device open/close on the fly, so chrooting all of UML might be 
hard.  The best that I can think of is to build a chroot jail with only 
those devices.

You still have to deal with /proc/mm for SKAS mode (at least until the 
next SKAS interface shift).

-- 

--------------------------------------------------------------------
Doug Dumitru     800-470-2756     (610-237-2000)
EasyCo LLC       doug@easyco.com  http://easyco.com
--------------------------------------------------------------------
D3, U2, jBase Virtual Servers.    Off-site backup over the internet.
Develop/test/deploy from $20/mo.  Fast, secure, cheaper than tape.
http://mirroredservers.com        http://mirroredbackup.com



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AANsc-0002i5-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 23:14:30 -0700
Received: from rimuhosting.com ([207.44.185.16])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1AANsR-0005Wx-GV
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 16 Oct 2003 23:14:19 -0700
Message-ID: <03db01c39475$cfc00be0$0600a8c0@objexcel>
From: "Peter" <peter@rimuhosting.com>
References: <3F8F7C06.7080306@easyco.com>
Subject: Re: [uml-devel] Hardening hostfs
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Fri, 17 Oct 2003 19:09:48 +1300
Content-Transfer-Encoding: 8bit
To: Doug Dumitru <doug@easyco.com>, user-mode-linux-devel@lists.sourceforge.net

> I don't think that this is perfect as you could still load a LKM and 
> probably get to the underlying filesystem.  At least it is chroot'd at 
> this point.
> 

You can disable module support in the UML kernel.

- Peter


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

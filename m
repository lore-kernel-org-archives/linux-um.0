Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqCnD-0001b4-Ty for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jul 2004 08:26:03 -0700
Received: from out-mta2.plasa.com ([202.134.0.79])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BqCnD-0006aG-2Q for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jul 2004 08:26:03 -0700
From: Mulyadi Santosa <a_mulyadi@telkom.net>
Reply-To: a_mulyadi@telkom.net
Subject: Re: [uml-devel] help needed for running uml on a sarge
References: <1359.157.182.42.226.1090946399.squirrel@www.csee.wvu.edu>
	<200407272357.02784.a_mulyadi@telkom.net>
	<50485.151.205.59.135.1091030391.squirrel@www.csee.wvu.edu>
In-Reply-To: <50485.151.205.59.135.1091030391.squirrel@www.csee.wvu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407292017.42409.a_mulyadi@telkom.net>
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
Date: Thu, 29 Jul 2004 20:17:42 +0700
To: atanugul@csee.wvu.edu
Cc: user-mode-linux-devel@lists.sourceforge.net

Hello :-)

your first ext2 image seems to have errors. Not sure why ...but you can force 
to do efsck

about your 2nd ext2 image...looks like it's fine.....the only problem , the 
image boots into runlevel 5 (X Window mode). Maybe you can do loopback 
mounting and manually edit the file /etc/inittab inside the image to boot 
into runlevel 2 or 3

Otherwise, you can try UMLBuilder to build your own disk image

regards

Mulyadi



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BX205-000876-FY for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Jun 2004 11:04:05 -0700
Received: from mta9.adelphia.net ([68.168.78.199])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BX204-0003K1-TC for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Jun 2004 11:04:04 -0700
Received: from mizar.alcor.net ([69.167.148.207]) by mta9.adelphia.net
	(InterMail vM.5.01.06.08 201-253-122-130-108-20031117) with ESMTP
	id <20040606180355.WTLR26615.mta9.adelphia.net@mizar.alcor.net>
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 6 Jun 2004 14:03:55 -0400
Received: from mdz by mizar.alcor.net with local (Exim 4.34)
	id 1BX1zu-0005oA-A7 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Jun 2004 11:03:54 -0700
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] [PATCH] More hostfs breakage
Message-ID: <20040606180354.GC19402@alcor.net>
References: <20040605010103.GA32113@alcor.net>
	<Pine.LNX.4.44.0406061726470.28866-100000@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0406061726470.28866-100000@filer.marasystems.com>
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
Date: Sun, 6 Jun 2004 11:03:54 -0700
To: user-mode-linux-devel@lists.sourceforge.net

On Sun, Jun 06, 2004 at 05:31:12PM +0200, Henrik Nordstrom wrote:

> Hmm.. I thought I had the "always one read-write" issue addressed in my 
> patch to only open read-write if the UML application asks for it.. need to 
> investigate.
> 
>   88e48f4e9b8d763f2d13d7a7974a3663  12-hostfs.patch
>   50e3b372d77793ed2a8422f75364422f  13-hostfs_access.patch
> 
> Note that there has been 2 revisions of the 12-hostfs.patch. The first 
> version did not use correct mode when opening files..

88e48f4e9b8d763f2d13d7a7974a3663  mara-12-hostfs.diff
50e3b372d77793ed2a8422f75364422f  mara-13-hostfs_access.diff

-- 
 - mdz


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

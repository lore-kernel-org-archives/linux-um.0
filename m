Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BWzcH-0000zH-8o for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Jun 2004 08:31:21 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BWzcG-00012d-K7 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Jun 2004 08:31:20 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] [PATCH] More hostfs breakage
In-Reply-To: <20040605010103.GA32113@alcor.net>
Message-ID: <Pine.LNX.4.44.0406061726470.28866-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sun, 6 Jun 2004 17:31:12 +0200 (CEST)
To: Matt Zimmerman <mdz@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hmm.. I thought I had the "always one read-write" issue addressed in my 
patch to only open read-write if the UML application asks for it.. need to 
investigate.

  88e48f4e9b8d763f2d13d7a7974a3663  12-hostfs.patch
  50e3b372d77793ed2a8422f75364422f  13-hostfs_access.patch

Note that there has been 2 revisions of the 12-hostfs.patch. The first 
version did not use correct mode when opening files..

Regards
Henrik

On Fri, 4 Jun 2004, Matt Zimmerman wrote:

> Even after applying Henrik's patches, hostfs was still not working for me.
> I tracked the problem down to this; I'm not exactly sure why it works this
> way (why does it always try to open the file read/write first?), but this
> got it working again for me so far.
> 
> If this is really the right way to go about this, then it needs to check for
> other things as well (EROFS?), but it doesn't seem right...
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

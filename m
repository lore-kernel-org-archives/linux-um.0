Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BlYJ1-0007Lc-Uz for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jul 2004 12:23:39 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BlYIx-0005jv-G0
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jul 2004 12:23:35 -0700
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.12.5/8.12.5) with ESMTP id
	i6GKJKqa003236 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 16 Jul 2004 16:19:21 -0400
Message-Id: <200407162019.i6GKJKqa003236@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] uml-patch-2.4.26-2
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
Date: Fri, 16 Jul 2004 16:19:19 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This long-awaited patch contains a lot of humfs/hostfs work, plus a bunch of
bug fixes which hopefully return UML to the stability of 2.4.24.  More 
specifically:

Fixed some humfs bugs and bumped the version number.  Modes are now
included in the metadata and directories with subdirectories named
'metadata' now have someplace to put their own metadata.

Fixed hostfs to work with the restructured externfs.  It is now also
safe against running out of file descriptors.  The one problem I see now
is a 'inodes in use' message when unmounting a hostfs filesystem.

linux is now the default build target, so that 'make ARCH=um' now does
what you'd expect.

Fixed some bugs in the malloc and free wrappers.

The port chan now sets SO_REUSEEADDR so ports can be immediately reused.

Directory opens and pipe creations are now handled in filehandle.c to
protect them against failing because with -EMFILE.

The tt mode switch pipe is now filehandles to protect process
creations from failing with -EMFILE.

Backed out a bug fix which broke modules.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

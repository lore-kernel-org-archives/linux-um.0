Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DOD4u-0002B5-JK for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Apr 2005 04:09:08 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DOD4t-00072U-2t
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Apr 2005 04:09:08 -0700
Received: from knoppix (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j3KCPP24018119
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 20 Apr 2005 08:25:26 -0400
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200504200606.06828.rob@landley.net>
Subject: [uml-devel] The source to that firmware-uml thing is now up...
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
Date: Wed, 20 Apr 2005 06:06:06 -0400
To: user-mode-linux-devel@lists.sourceforge.net

http://www.landley.net/code/firmware/notes.html

It's a ~80 meg tarball (half of which is the gcc, binutils, and linux-2.6.11 
source tarballs) on a friend's machine, so don't hit the poor server too 
hard.  I intend to move it to a faster connection after I get back from 
Penguicon...

Yeah, I know the versions of most things are out of date, but the build worked 
when I ran it, and as a proof of concept it shows you what I did.

By the way, I've toyed with the idea of running this sucker in an otherwise 
empty chroot environment (/proc/self/fd is likely to exist and have fairly 
uninteresting contents.  As a chroot environment, it just has symlinks that 
point to nothing), but to chroot the UML kernel process from inside the 
initramfs, I need to come up with a new syscall.  Can't do it before running 
the UML kernel because A) it needs to make its memory file, 2) it needs to 
access /proc/self/exe, III) it needs to loopback mount its executable file to 
pull the trick I just did.

Does a new "chroot UML" syscall sound like a worthwhile idea?

Rob


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bg6du-0002RS-Nu for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 11:50:42 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bg6du-0003QF-29 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 11:50:42 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407012050.14867.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Fixing the 2.4 bugs - patches against 2.4.24-1um
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
Date: Thu, 1 Jul 2004 20:50:14 +0200
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

I've started working also on UML/2.4.

Today I've split the changes between 2.4.24-1um and 2.4.24-2um into several 
patches; the HUMFS ones are carefully split out, but I've separated even the 
others. Now I need testers. Lots of people cannot use UML patches later than 
2.4.24-1um, since they contain a lot of Hostfs bugs and some stability 
issues. Now, if you use just some patches, you'll avoid the bugs in the 
other.

You should apply surely the first 3 patches, IMHO; the other ones should not 
hurt; inside txt/ there is a description of them.

mini-changes.patch
  Various little changes which don't hurt.

use_setjmp_wrapper.patch
  Adds setjmp_wrapper and use it, to fix klogd bug.

use-gettimeofday.patch
  Replace rdtsc with gettimeofday.

remapper-fix.patch
  Fixes probably to the ubd-mmap code

SIG-fileHandle-changes.patch
  Cope with signals from various places.

exec-shield.patch
  Patch for exec-shield users (IMHO unsafe)

expand-os-for-HUMFS.patch
  Expands os_ layer, seems to be for HUMFS only.

HUMFS.patch
  Adds HUMFS support, but create problems for Hostfs


The actual patches can be found inside the patches/ subdir in the tarball, and 
the "series" file contains the order.
THEY ARE AGAINST 2.4.24-1uml. If you want to apply it onto 2.4.26, don't 
forget to include the following patch (just for 2.4.26): 
http://vs165141.v.sectoor.de/uml-2.4.26-cmpxchg.patch

But you should move the content of 2.4.24-2-inc-split/ folder into the root of 
the linux tree (i.e. under Uml-linux) and then run "pushpatch 30" after 
installing patch-scripts.

Here there is the tarball:
http://www.user-mode-linux.org/~blaisorblade/patches/2.4.24-2-inc-split.tar.bz2

Here you can download patch-scripts; to install them you must just expand the 
tarball into /usr/local/bin (or any folder you like; remember to update the 
path if needed).

http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.18/

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpLA8-00035b-8U for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 22:42:24 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CpLA6-0002JC-9R
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 22:42:23 -0800
Received: from knoppix (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.12.11/8.12.11) with ESMTP id j0E7oiXa021301
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 14 Jan 2005 02:50:45 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200501140040.56592.rob@landley.net>
Subject: [uml-devel] UML build process uses perl?  (With sed alternative.)
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
Date: Fri, 14 Jan 2005 00:40:56 -0500
To: user-mode-linux-devel@lists.sourceforge.net

I thought maybe the problem I'm having is due to running UML with a uclibc 
root on a glibc host system, so I tried to build UML in my chroot 
environment.

It died when it tried to use perl to build.

My uclibc environment hasn't got perl.  The normal linux kernel build doesn't 
use perl.  Neither do busybox, lilo, uClibc, zlib, dropbear, autoconf, 
automake, bin86, binutils, bison, cdrtools, e2fsprogs, flex, gcc, libtool, 
m4, make, nasm, the squashfs or zisofs tools, udev, or any of the other 
packages I build under the thing.

As far as I can tell, the following sed invocation will give more or less what 
the perl does, without a dependency on perl.  (Busybox has sed.)  It may need 
a bit of adapting to make the makefile happy (and adding config.tmp to make 
clean), but the concept seems to work...

sed -e 's/^.*$/"&\\n"/' /linux-2.6.9/.config > config.tmp
sed -e '/CONFIG/{' -e 's/"CONFIG"\;/""/' -e 'r config.tmp' -e 'a ""\;' \
	-e '}' config.c.in

Rob


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

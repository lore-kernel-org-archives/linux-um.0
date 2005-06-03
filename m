Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DeFlT-0003Ah-10	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Jun 2005 10:15:23 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DeFlQ-0004s8-Pu
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Jun 2005 10:15:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.scgiservices.com (Postfix) with ESMTP id E56252A08B
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri,  3 Jun 2005 10:15:17 -0700 (PDT)
Received: from mail.scgiservices.com ([127.0.0.1])
 by localhost (mail [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04110-01 for <user-mode-linux-devel@lists.sourceforge.net>;
 Fri,  3 Jun 2005 10:15:12 -0700 (PDT)
Received: from SCG2 (c-67-160-154-69.hsd1.or.comcast.net [67.160.154.69])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id EB6592A086
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri,  3 Jun 2005 10:15:11 -0700 (PDT)
From: "Anthony Brock" <Anthony.Brock@oregonstate.edu>
Message-ID: <OJEEKGNKKDLJIEPBEJMIMEKPCAAA.Anthony.Brock@oregonstate.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Problems applying patches to 2.6.12-rc5-mm2
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
Date: Fri, 3 Jun 2005 10:15:08 -0700
To: user-mode-linux-devel@lists.sourceforge.net

In the event that something "wierd" happened to my guest binary, I've decide
to try recompiling again. However, I'm now seeing new (and old) compilation
errors with Jeff's tree. The steps were:


# tar -jxvf linux-2.6.12-rc5.tar.bz2
# cd linux-2.6.12-rc5/
# bzip2 -dc ../2.6.12-rc5-mm2.bz2 |patch -p1
# tar -xvf ../2.6.12-rc5-mm2-20050602-patches.tar
# quilt push -a
# cp -a ../.config .
# make oldconfig ARCH=um
# make ARCH=um && make modules ARCH=um

<*** OUTPUT SNIPPED ***>

  CC      arch/um/sys-i386/sigcontext.o
  AS      arch/um/sys-i386/stub.o
  CC      arch/um/sys-i386/stub_segv.o
fixdep: arch/um/sys-i386/.stub_segv.o.d: No such file or directory
make[1]: *** [arch/um/sys-i386/stub_segv.o] Error 2
make: *** [arch/um/sys-i386] Error 2
#


So, this problem is back. I then removed the 'av-skas0' patch with:


# cat patches/av-skas0|patch -p1 -R
patching file arch/um/Makefile
Hunk #1 succeeded at 64 (offset 1 line).
patching file arch/um/sys-i386/Makefile
patching file arch/um/sys-x86_64/Makefile
Hunk #1 succeeded at 32 (offset 2 lines).
#


Once more, I tried the compile:


# make ARCH=um && make modules ARCH=um

<*** OUTPUT SNIPPED ***>

  CC      kernel/futex.o
  CC      kernel/uid16.o
  CC      kernel/module.o
kernel/module.c: In function `module_add_modinfo_attrs':
kernel/module.c:1078: error: `modinfo_attrs' undeclared (first use in this
function)
kernel/module.c:1078: error: (Each undeclared identifier is reported only
once
kernel/module.c:1078: error: for each function it appears in.)
kernel/module.c: In function `module_remove_modinfo_attrs':
kernel/module.c:1091: error: `modinfo_attrs' undeclared (first use in this
function)
kernel/module.c: In function `setup_modinfo':
kernel/module.c:1387: error: `modinfo_attrs' undeclared (first use in this
function)
make[1]: *** [kernel/module.o] Error 1
make: *** [kernel] Error 2
#


Idea? - Tony



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

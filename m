Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <glud-user-mode-linux-devel@m.gmane.org>)
	id 1SM3GY-0007ex-LL for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Apr 2012 20:20:14 +0000
Received: from plane.gmane.org ([80.91.229.3])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SM3GX-0007i7-87
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Apr 2012 20:20:14 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glud-user-mode-linux-devel@m.gmane.org>)
	id 1SM3GP-000628-CK for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Apr 2012 22:20:05 +0200
Received: from ip-62-143-196-122.unitymediagroup.de ([62.143.196.122])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 22 Apr 2012 22:20:05 +0200
Received: from osi2897 by ip-62-143-196-122.unitymediagroup.de with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 22 Apr 2012 22:20:05 +0200
From: Osi2897 <osi2897@i2pmail.org>
Date: Sun, 22 Apr 2012 20:19:56 +0000 (UTC)
Message-ID: <loom.20120422T221621-489@post.gmane.org>
References: <loom.20120421T191253-852@post.gmane.org>
	<CAFLxGvybL7jTMsxD3f7p25Z-8aL9cOtJr-wi1aoO82Ykm98Ong@mail.gmail.com>
Mime-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel]
	=?utf-8?q?3=2E3=2E2=3A_conflicting_types_for_sys=5Fni?=
	=?utf-8?q?=5Fsyscall?=
To: user-mode-linux-devel@lists.sourceforge.net

richard -rw- weinberger <richard.weinberger <at> gmail.com> writes:

> Can you try building the kernel again after a "make mrproper ARCH=um"?

Just tried it... "make ARCH=um" stops with same error message (Archlinux on
PentiumIII, gcc is 4.7.0 20120414 (prerelease)).


------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


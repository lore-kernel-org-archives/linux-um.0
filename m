Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7o3-0007IW-Ri
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 18:59:07 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7o2-0003dD-P0
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 18:59:07 +0000
Date: Thu, 18 Aug 2011 19:58:59 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7nv-0007OP-3E@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 00/91] pending uml patches
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


My apologies for mailbomb from hell.  *All* this stuff is available in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/um-header.git/ #master,
but since uml folks had been stuck with mail and patch for a long time...

Anyway, most of the stuff in this pile is merging, cleaning and mutilating
subarchitecture-related code in arch/um.  By the end of it we have x86
bits largely merged between 32bit and 64bit variants and taken to arch/x86/um;
headers seriously cleaned up and mostly free of x86-isms now (not completely -
we still have page size dependencies in there).

Beginning of the series are pure build and driver fixes; those should go to
Linus before 3.1-final, IMO.

As far as I know, there's no regressions introduced by that pile; testing
and comments would be, of course, welcome.


------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


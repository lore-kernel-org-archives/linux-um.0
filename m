Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6GLc-0003SW-Dx for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 15:27:56 -0700
Received: from fmr10.intel.com ([192.55.52.30] helo=fmsfmr003.fm.intel.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C6GLb-0004qi-3N for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 15:27:56 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [uml-devel] [PATCH] nptl/sys_clone fix for i386/ppc
Message-ID: <A06801158AE07847B27A52C1A074BC1D04C913FF@fmsmsx404.amr.corp.intel.com>
From: "Wichmann, Mats D" <mats.d.wichmann@intel.com>
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
Date: Sat, 11 Sep 2004 15:27:46 -0700
Content-Transfer-Encoding: 8bit
To: David Jeffery <djeffery@britsys.net>, ralston@stral.net
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

 
>It depends on what part of pthreads the programs use.  My patch only 
>fixes basic thread creation.  If you run the pthread test suite from 
>LSB, you'll find there is alot still broken.  

I'm glad folks are finding some use for the tests.
Just to give credit where due, this is VSTH-Lite,
the "free" version of the official posix threads
test suite which we (LSB) just repackage. Current
generic nptl+tls-enabled-glibc do quite well
on this set of tests (like, one failure, which
is likely a testsuite problem).

-- mats


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

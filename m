Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xC9n-0003ou-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 14:05:43 -0700
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xC9m-0001L6-QF
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 10 Sep 2003 14:05:42 -0700
Received: from mercury.dur.ac.uk (mercury.dur.ac.uk [129.234.4.40])
	by hermes.dur.ac.uk (8.11.7/8.11.7) with ESMTP id h8AKukL10248
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 21:56:46 +0100 (BST)
Received: from altair.dur.ac.uk (altair.dur.ac.uk [129.234.4.14])
	by mercury.dur.ac.uk (8.12.9+Sun/8.11.7) with ESMTP id h8AKuhw3016454
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 21:56:43 +0100 (BST)
Received: from localhost (dit0may@localhost)
	by altair.dur.ac.uk (8.11.7+Sun/8.11.1) with ESMTP id h8AKuhx10433
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 21:56:43 +0100 (BST)
From: M A Young <m.a.young@durham.ac.uk>
Message-ID: <Pine.GSO.4.53.0309102139120.9641@altair.dur.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] uml segfaults on redhat beta "severn"
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 10 Sep 2003 21:56:43 +0100 (BST)
To: User-mode-linux-devel@lists.sourceforge.net

If you try to run a uml kernel under a 2.4 kernel from the redhat beta
"severn" in tt mode, you get an almost immediate crash, under
before_mem_tt, in the final remap_data call. The problem is that it seem
in these kernels, maybe as a result of the new "exec-shield" feature, that
the code and data segments are no longer adjacent, which means that from
__bss_start to sbrk(0) is around 26Mb rather than under 1Mb, including
bits it presumably has no right to copy, hence the segfault.
This will presumably also apply to Red Hat's next release, assuming they
keep the same features.

	Michael Young


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

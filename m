Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bi8Nk-0002NG-FF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 02:06:24 -0700
Received: from mout2.freenet.de ([194.97.50.155])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1Bi8Nj-0000jX-WE
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 02:06:24 -0700
Received: from [194.97.50.138] (helo=mx0.freenet.de)
	by mout2.freenet.de with asmtp (Exim 4.390) id 1Bi8Nd-00029a-Ob
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 11:06:17 +0200
Received: from g5e7f.g.pppool.de ([80.185.94.127] helo=bakunin.copyleft.de)
	by mx0.freenet.de with esmtp (Exim 4.390 #1) id 1Bi8Nd-0006fK-Ea
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 11:06:17 +0200
From: Michael Koehne <kraehe@copyleft.de>
Message-ID: <20040707090621.GA6094@bakunin.copyleft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Unable to handle kernel paging request ...
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
Date: Wed, 7 Jul 2004 11:06:21 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Moin Guru's,

  i have 2.6.x host crashes, and I dont know, if they are related to
  UML. I have a perfectly running 2.4.22 SKAS system on a dual PPro,
  and a laptop who requires a 2.6.x kernel because of hardware. This
  laptop is prepared to run UML's - but it seldom does.

  But the laptop crashes about once or twice a week. This sometimes
  happens on operations like `find . -print | while read x; do diff
  ../foo/$x $x; done` or rsync over large directory trees. And sometimes
  on idle state - e.g. tonight at crontime with a 'postmaster' crash.
  I've talked to people on IRC, and they dont encounter those kind of
  ext3 crashes on 2.6 kernels. I dont had a camera for a screenshot,
  but dump was in ext3 area.

  So it might be something with SKAS host patch - even if the system
  also crashes, if no UML is running.

     33240033 Feb  3 06:41 linux-2.6.1.tar.bz2
   +    15570 Feb  4 02:36 host-2.6.1-skas3.patch
  or 34896138 May 25 20:45 linux-2.6.6.tar.bz2
   +    16182 May 25 20:35 host-skas3-2.6.6-v1.patch

Bye Michael
-- 
  mailto:kraehe@copyleft.de             UNA:+.? 'CED+2+:::Linux:2.4.22'UNZ+1'
  http://www.xml-edifact.org/           CETERUM CENSEO WINDOWS ESSE DELENDAM


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

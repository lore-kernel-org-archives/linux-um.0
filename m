Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BORD9-0007wp-OS for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 May 2004 18:10:03 -0700
Received: from [12.177.129.25] (helo=uml.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BORD9-0000mv-Au
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 May 2004 18:10:03 -0700
Received: from uml.user-mode-linux.org (uml.user-mode-linux.org [127.0.0.1])
	by uml.user-mode-linux.org (8.12.5/8.12.5) with ESMTP id i4BLWOI0022471
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 11 May 2004 17:32:59 -0400
Received: from uml.user-mode-linux.org (jdike@localhost)
	by uml.user-mode-linux.org (8.12.5/8.12.5/Submit) with ESMTP id
	i4BLWO4x022463 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 11 May 2004 17:32:24 -0400
Message-Id: <200405112132.i4BLWO4x022463@uml.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] uml-patch-2.4.25-1
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
Date: Tue, 11 May 2004 17:32:23 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This path updates UML to 2.4.25.  It also fixes a couple of bugs, one which was
introduced in the last patch, and one which I claimed was fixed, but wasn't
really.

The last patch introduced a bug which would cause the helper code to hang.
This is now fixed.

The AIO code now compiles on 2.4.  I remembered to check that this time.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

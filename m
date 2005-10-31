Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EWe25-0001DC-AR for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Oct 2005 10:05:21 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EWe20-0000v2-Hb
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Oct 2005 10:05:21 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20051031185758.GA7116@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Another stub bug
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
Date: Mon, 31 Oct 2005 13:57:58 -0500
To: blaisorblade@yahoo.it
Cc: user-mode-linux-devel@lists.sourceforge.net, gogi@gogi.tv

I just saw another case where the stubs are being badly assembled.  This cases
involves the address of from being referred relative to ebp.  After the 
call to syscall6, ebp is trash because, even though we carefully push and
pop it, we pop it from a brand new page.

This interaction between mmap and syscall6 suggests that this is the
wrong interface.  It looks more like we should have stub_remap_stack
instead of stub_syscall6, and similar things for the others.  Even so,
it's not clear to me how to deal with this.  We are out of registers,
so we could possibly store ebp in esp, restore it after the mmap, and
set esp to a fixed value.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ecr3W-0002Gt-4l for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 13:12:30 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ecr3V-0002XG-JC
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 13:12:30 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20051117220436.GA10871@ccure.user-mode-linux.org>
References: <200511172110.jAHLASIB010204@ccure.user-mode-linux.org>
	<Pine.LNX.4.61.0511171528570.10664@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511171528570.10664@chaos.analogic.com>
Subject: [uml-devel] Re: [PATCH 3/4] UML - Properly invoke x86_64 system calls
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
Date: Thu, 17 Nov 2005 17:04:36 -0500
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: akpm@osdl.org, Linux kernel <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

Dear Wrongbot,
	Thank you for your concern.

On Thu, Nov 17, 2005 at 03:37:14PM -0500, linux-os (Dick Johnson) wrote:
> In 64-bit world, the same is supposed to apply as well.
> If RCX is now precious, it's a GCC bug that should be fixed.
> 
> Yes?

No.

Here's a technical tidbit for you to digest, mangle, and later regurgitate
in yor usual pseudo-authoritative manner:

	The x86_64 syscall instruction is defined to contain the process 
	return address on return to userspace.  Hence, it (like RAX) is
	destroyed by the syscall instruction.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

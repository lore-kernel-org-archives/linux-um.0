Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcnrX-0001xh-Pv for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 09:47:55 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EcnrW-0006N1-Ik
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 09:47:56 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
Message-ID: <20051117184038.GB7062@ccure.user-mode-linux.org>
References: <200511161100.31053.rob@landley.net>
	<20051116221948.GA10366@ccure.user-mode-linux.org>
	<200511161811.38823.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511161811.38823.rob@landley.net>
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
Date: Thu, 17 Nov 2005 13:40:38 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Nov 16, 2005 at 06:11:38PM -0600, Rob Landley wrote:
> include/asm/processor.h:19: error: field `tls' has incomplete type

This is strange.  It's complaining about not having a struct user_desc, which
is defined in asm-i386/ldt.h, which is included from asm-um/ldt-i386.h through
the asm/arch symlink.

Your asm/arch link points to asm-i386, doesn't it?

> error: syntax error before "uml_ldt_t"

uml_ldt_t is clearly typedefed in asm/ldt-i386.h, which is symlinked from
ldt.h, which is included into mme-skas.h.

Your recipe says you did a completely clean build, but the symptoms look
to me like you have leftovers from a non-UML or non-UML/i386 build.

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

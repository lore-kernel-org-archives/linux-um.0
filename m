Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbnhF-0003Mb-Bz for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 15:25:09 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EbnhD-0004Cp-Tl
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 15:25:09 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [PATCH] Ok, I build x86-64 -skas0,
	and it still segfaults.
References: <200511121936.41697.rob@landley.net>
	<200511131732.11279.rob@landley.net>
	<20051114215517.GA9579@ccure.user-mode-linux.org>
In-Reply-To: <20051114215517.GA9579@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511141724.55055.rob@landley.net>
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
Date: Mon, 14 Nov 2005 17:24:54 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

On Monday 14 November 2005 15:55, Jeff Dike wrote:
> On Sun, Nov 13, 2005 at 05:32:10PM -0600, Rob Landley wrote:
> > moan moan

And proud of it!

> Can you try the x86-64-clobbers-rcx patch below?

Sure.  (Rummages...)

> If you don't have it already, apply the fix-x86-stubs patch first.

It said it was reversed, so I'm going to assume for the moment that 2.6.15-rc1 
already has it, try the second...

patching file arch/um/sys-i386/stub_segv.c
Hunk #2 FAILED at 19.
1 out of 2 hunks FAILED -- saving rejects to file 
arch/um/sys-i386/stub_segv.c.rej

Ok, fix that up by hand...  And the build breaks in stub_segv.c.

What version are these patches against?  Let's try a straight 2.6.14...

fix-x86-stubs applied cleanly.
x86-64-clobbers-rcx...  Still fails hunk #2.

Back off to a clean 2.6.14 again and try clobbers-rcx first...

Still fails hunk #2.

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

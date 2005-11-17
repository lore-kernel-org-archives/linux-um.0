Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ecm9e-0005ky-Q6 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 07:58:30 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ecm9c-0002hy-En
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 07:58:31 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
References: <200511161100.31053.rob@landley.net>
	<200511170716.46519.rob@landley.net>
	<20051117163723.GA5878@ccure.user-mode-linux.org>
In-Reply-To: <20051117163723.GA5878@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511170958.17364.rob@landley.net>
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
Date: Thu, 17 Nov 2005 09:58:17 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thursday 17 November 2005 10:37, Jeff Dike wrote:
> On Thu, Nov 17, 2005 at 07:16:46AM -0600, Rob Landley wrote:
> > is what I had to apply to 2.6.15-rc1 to get that to work).  I think that
> > included tls, but since the target system doesn't use it I don't know.
>
> OK, well your recipe results in this
>
> $ grep MODE obj1/.config
> # CONFIG_MODE_TT is not set
> # CONFIG_MODE_SKAS is not set
>
> which is not a healthy config.  It fails to build here, but the errors are
> different.

That means you didn't get the uml-miniconf I attached to my message copied 
into allno.config in the source directory.  (Did I typo my script?)

2.6.15-rc1 developed a new feature that lets you take a config snippet setting 
just the features you want and generate a working .config from that.  I wrote 
some bad documentation for it earlier this morning:

http://seclists.org/lists/linux-kernel/2005/Nov/5804.html

> This case does need better error checking though.
>
> Can you check a config that actually has a chance of running?

I'm fairly certain I did.  That's why my errors are different. :)

>     Jeff

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

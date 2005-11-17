Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcjdN-00072Z-5p for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 05:17:01 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EcjdL-0000eO-D2
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 05:17:01 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
References: <200511161100.31053.rob@landley.net>
	<200511161811.38823.rob@landley.net>
	<20051117052622.GA12221@ccure.user-mode-linux.org>
In-Reply-To: <20051117052622.GA12221@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511170716.46519.rob@landley.net>
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
Date: Thu, 17 Nov 2005 07:16:46 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Wednesday 16 November 2005 23:26, Jeff Dike wrote:
> On Wed, Nov 16, 2005 at 06:11:38PM -0600, Rob Landley wrote:
> > Sure:
> >
> > make: *** [arch/um/kernel-offsets.s] Error 1
>
> Sorry, I forgot this was x86_64.  Try the patches up to tt-options - the
> tls stuff doesn't build on x86_64 yet.
>
>     Jeff

No, now I'm trying to build it on x86.  I got x86-64 to work (the rollup patch 
is what I had to apply to 2.6.15-rc1 to get that to work).  I think that 
included tls, but since the target system doesn't use it I don't know.

Unfortunately, 2.6.15-rc1 with your current patch tarball applied isn't 
building on my ubuntu "horny hedgehog" x86 laptop.  Hence the dumps...

I'm trying to get one codebase that builds on both...

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

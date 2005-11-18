Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdFCu-0006BT-4h for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Nov 2005 14:59:48 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EdFCs-0004Vc-Vi
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Nov 2005 14:59:48 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: merge status
Message-ID: <20051118235231.GB12049@ccure.user-mode-linux.org>
References: <20051109133558.513facef.akpm@osdl.org>
	<200511160736.44659.rob@landley.net>
	<200511180808.57481.blaisorblade@yahoo.it>
	<200511180117.03742.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511180117.03742.rob@landley.net>
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
Date: Fri, 18 Nov 2005 18:52:31 -0500
To: Rob Landley <rob@landley.net>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Fri, Nov 18, 2005 at 01:17:03AM -0600, Rob Landley wrote:
> > Definitely Jeff's tree is a first filter for his work, but I've not seen it
> > working a lot as a collector, especially for little fixes - but there it
> > makes sense.

I'd like it to be a collector of patches.  I just don't see a lot of them
(IIRC, the ones I do see are already on their way to akpm/linus, so it
makes not too much sense to exercise them in my tree).  Witness the OS
patches, the s390 stuff, and the NPTL patches (which I went and found
myself, which turned out to be a really good move).

> > I tend to send directly to Andrew and he forwards them to Linus (in many
> > cases so fast that I wonder if they appear in one -mm release), but I
> > currently do not have a public tree.

And you're welcome to send directly to Andrew, but feel free to send
them to me beforehand.


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

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRGCm-0003Qi-2r	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 14:05:52 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DRGCk-0007Rl-Gi	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 14:05:52 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050428202647.GA25451@ccure.user-mode-linux.org>
References: <1114570958.5983.50.camel@mythical>
	<20050427234515.GY13052@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427234515.GY13052@parcelfarce.linux.theplanet.co.uk>
Subject: [uml-devel] Re: [UML] Compile error when building with seperate
	source and object directories
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
Date: Thu, 28 Apr 2005 16:26:47 -0400
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, sam@ravnborg.org, Ryan Anderson <ryan@michonline.com>

> That's because that stuff is not merged yet.  Speaking of which, where does
> the current UML tree live and who should that series be Cc'ed to?

My patchset lives at http://user-mode-linux.sf.net/patches.html, and things
like this should be CC-ed to me.

> I've got a decent split-up and IMO that should be mergable.  Patches are
> on ftp.linux.org.uk/pub/people/viro/UM*; summary in the end of mail.
> That's a sanitized and split version of old UML-kbuild patch.

Thanks, merged into my tree.  It'll be visible at the above URL next time
I push the site out, and I'll merge this and a bunch of other stuff to
Linus and Andrew shortly.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

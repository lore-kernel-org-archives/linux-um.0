Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ea2ti-0001Ut-FC for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Nov 2005 19:14:46 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ea2th-0000PH-0s
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Nov 2005 19:14:46 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Making UML Single Threader
Message-ID: <20051110040708.GC15002@ccure.user-mode-linux.org>
References: <200511061723.32848.rob@landley.net>
	<200511080109.06999.rob@landley.net>
	<4A8812BF-70D2-451C-9E9F-4502ED468120@stanford.edu>
	<200511081835.47575.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511081835.47575.rob@landley.net>
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
Date: Wed, 9 Nov 2005 23:07:08 -0500
To: Rob Landley <rob@landley.net>
Cc: Can Sar <csar@stanford.edu>, user-mode-linux-devel@lists.sourceforge.net

On Tue, Nov 08, 2005 at 06:35:47PM -0600, Rob Landley wrote:
> Jeff was going to split out the scheduler and filesystem into shared libraries 
> or some such.  He mentions it in his intermittent diary, among other places.  
This has nothing to do with that.

One of my other future projects is embedding UML into other things, as in
a library, to give those other processes access to functionality like 
clustering.  In this case, you may not want UML booting to userspace - you
just want the kernel initialized enough that you can call into it.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DvdIa-0000BR-Jk	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2005 08:49:24 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1DvdIX-0005Lm-La
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2005 08:49:24 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1DvdIW-0005w9-BE	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2005 08:49:20 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Best way to debug?
Message-ID: <20050721153803.GA2894@ccure.user-mode-linux.org>
References: <21786771.1121957989655.JavaMail.oracle@web265.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21786771.1121957989655.JavaMail.oracle@web265.oracle.com>
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
Date: Thu, 21 Jul 2005 11:38:03 -0400
To: allan.graves@oracle.com
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Jul 21, 2005 at 02:59:49PM +0000, allan.graves@oracle.com wrote:
> This is a question to you kernel developers...  when using UML,
> what's teh best way to debug a kernel panic?  Get UML to generate a
> core?  Setup netdump or some such?  How do you guys usually do it? 

Run it under gdb, and either debug from the stack trace after the fact
or step it through the bug beforehand.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

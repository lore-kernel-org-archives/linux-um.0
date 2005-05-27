Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbTnH-0007rG-Un	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:37:47 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DbTnF-0000i3-8k	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:37:46 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH 3/7] UML - Turn off kmalloc always on a fatal
	signal
Message-ID: <20050527011648.GA16539@ccure.user-mode-linux.org>
References: <200505262230.j4QMUQ5m014682@ccure.user-mode-linux.org>
	<Pine.LNX.4.58.0505261812230.1625@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505261812230.1625@gradall.private.brainfood.com>
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
Date: Thu, 26 May 2005 21:16:48 -0400
To: Adam Heath <doogie@debian.org>
Cc: akpm@osdl.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, May 26, 2005 at 06:13:02PM -0500, Adam Heath wrote:
> This and some of the other patches are changing the formatting.  The new line
> above is using spaces instead of a tab.

On purpose - I'm making UML more CodingStyle conformant, and doing it as I'm
modifying stuff anyway.  The alternative is a set of whitespace patches, 
which will gratuitously make a barrier across which patches need to be
hand-merged.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

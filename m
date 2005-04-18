Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DNXvS-0003WW-00 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Apr 2005 08:12:38 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DNXvQ-0000ZE-B4 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Apr 2005 08:12:37 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] MacOS X port?
Message-ID: <20050418140559.GA4219@ccure.user-mode-linux.org>
References: <20050418113114.GA7159@muffin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050418113114.GA7159@muffin>
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
Date: Mon, 18 Apr 2005 10:05:59 -0400
To: "Wesley W. Terpstra" <wesley@terpstra.ca>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Apr 18, 2005 at 01:31:14PM +0200, Wesley W. Terpstra wrote:
> Hi, I know that user-mode-linux has been ported to linux/ppc already.
> What I was wondering is if there was work underway to port it to MacOS X?
> That is to say, running a linux kernel from the BSD-ish MacOS X userland.
> 
> This would be really cool; it would mean MacOS X users could run linux
> applications 'natively' under UML with X forwarding to MacOS X's X server. 
> I couldn't imagine a more ideal configuration. :-)
> 
> How hard would such an undertaking be?

That's an OS port, which is very different from an arch port.  There is work
underway (see the os abstraction patches at 
http://user-mode-linux.sf.net/patches.html) to make UML OS-portable.

arch/um/include/os.h will show you what you currently have to implement for
a new OS.  This is subject to change since we have only moved the existing
OS-specific stuff and not tried to rationalize it yet.

				Jeff


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DeG9K-0004Ud-Fa	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Jun 2005 10:40:02 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DeG9I-00085u-3B	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Jun 2005 10:40:02 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
Message-ID: <20050603164910.GA20908@ccure.user-mode-linux.org>
References: <1115573839.10373.42.camel@cobra>
	<20050508183533.GA27251@ccure.user-mode-linux.org>
	<1115590823.10373.68.camel@cobra> <1115600253.10373.74.camel@cobra>
	<1117307236.10041.4.camel@localhost> <1117691482.10122.107.camel@localhost>
	<20050602210649.GA24306@ccure.user-mode-linux.org>
	<1117766016.10122.202.camel@localhost>
	<20050603023809.GA28818@ccure.user-mode-linux.org>
	<1117826890.10090.48.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117826890.10090.48.camel@localhost>
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
Date: Fri, 3 Jun 2005 12:49:10 -0400
To: antoine <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jun 03, 2005 at 08:28:10PM +0100, antoine wrote:
> I think there is still a memory leak lurking, OOM seems to kick in (see
> bottom of this email)

Yeah, it's a page leak, I think from page tables, which I haven't tracked
down yet.

> Very minor thing: I noticed that the TT threads generally do not show
> which process they are running inside the UML (as it used to), any way
> to restore this?

Those aren't tt threads, they are skas0 threads, and we could probably restore 
the command names, but I haven't bothered doing so.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

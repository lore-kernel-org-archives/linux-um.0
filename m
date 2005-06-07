Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfSQy-0000Ro-9U	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 17:59:12 -0700
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252] ident=93)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DfSQw-00069Q-K4
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 17:59:12 -0700
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [uml-devel] [PATCH 3/5] UML - Clean up tt mode remapping of UML
	binary
Message-ID: <20050607005958.GK29811@parcelfarce.linux.theplanet.co.uk>
References: <200506062008.j56K89YA008957@ccure.user-mode-linux.org>
	<200506070105.20422.blaisorblade@yahoo.it>
	<20050606235321.GJ29811@parcelfarce.linux.theplanet.co.uk>
	<200506070256.43104.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506070256.43104.blaisorblade@yahoo.it>
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
Date: Tue, 7 Jun 2005 01:59:58 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 02:56:36AM +0200, Blaisorblade wrote:
> > Per-subarch - perhaps not.  Per-glibc-type - definitely needed.
> No, because the setup for NPTL glibc works also on non-NPTL one. Actually, to 
> be exact, I've tested it *only* on normal glibc. I'm still waiting to get 
> some testing in NPTL environments, but I expect it to work.

Now, that is interesting.  Which script are you using for i386 and which
libc version does it work with?

> P.S: is it only me or you've sent about 20 copies of your last message?

Headers?


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

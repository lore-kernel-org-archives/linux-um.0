Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXBvL-0003M3-J7 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Nov 2004 21:12:07 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CXBvK-0000Jo-Em for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Nov 2004 21:12:07 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 1/1] uml: fix some ptrace functions
	returns values
References: <20041124000715.E3A2FAB24@zion.localdomain>
	<41A3F6F6.1040903@osdl.org>
In-Reply-To: <41A3F6F6.1040903@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411250514.46355.blaisorblade_spam@yahoo.it>
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
Date: Thu, 25 Nov 2004 05:14:46 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm@osdl.org, linux-kernel@vger.kernel.org, jdike@addtoit.com

On Wednesday 24 November 2004 03:50, Randy.Dunlap wrote:
> blaisorblade_spam@yahoo.it wrote:
> > From: Jeff Dike <jdike@addtoit.com>
> >
> > This patch adds ptrace_setfpregs and makes these functions return -errno
> > on failure.

> Looks OK except that someone's SPACEBAR is broken (missing)
> and there are (unneeded/unwanted) parens on the returns.
Yes, that is Jeff Dike's keyboard - it's cursing all over arch/um with that 
style.

I'm going to resend it more conforming to the kernel style.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUnAQ-0001oz-PR	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2005 07:54:02 -0700
Received: from colin.muc.de
	([193.149.48.1] helo=mail.muc.de ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DUnAP-0005Hy-4z
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2005 07:54:02 -0700
From: Andi Kleen <ak@muc.de>
Message-ID: <20050508145356.GB21873@muc.de>
References: <20050507182728.GA29592@in.ibm.com>
	<1115524211.17482.23.camel@localhost.localdomain>
	<1115547230.5998.10.camel@laptopd505.fenrus.org> <m1oeblvo3x.fsf@muc.de>
	<1115559855.5998.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115559855.5998.26.camel@laptopd505.fenrus.org>
Subject: [uml-devel] Re: [RFC] (How to) Let idle CPUs sleep
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
Date: Sun, 8 May 2005 16:53:56 +0200
To: Arjan van de Ven <arjan@infradead.org>
Cc: vatsa@in.ibm.com, schwidefsky@de.ibm.com, jdike@addtoit.com, Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>, rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, May 08, 2005 at 03:44:14PM +0200, Arjan van de Ven wrote:
> 
> > But it has to be *really* lightweight because these transistion can
> > happen a lot (consider a CPU that very often goes to sleep for a short time)
> 
> lightweight is good of course. But even if it's medium weight.. it just
> means you need to be REALLY idle (eg for longer time) for it to trigger.
> I guess we need some sort of per arch "idleness threshhold" for this.

The question is how useful it is for the hypervisor to even know that.
Why can't it just detect long idle periods by itself if it really wants?

-Andi


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

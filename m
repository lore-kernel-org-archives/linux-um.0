Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfQBX-0006ix-P3	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 15:35:07 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1DfQBV-0000S9-9J
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 15:35:07 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20050606153555.3eb4cb2f.akpm@osdl.org>
In-Reply-To: <20050606153118.1f7a413f.akpm@osdl.org>
References: <200506062008.j56K8BKG008967@ccure.user-mode-linux.org>
	<20050606153118.1f7a413f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [PATCH 5/5] UML - clean up error path
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
Date: Mon, 6 Jun 2005 15:35:55 -0700
To: jdike@addtoit.com, torvalds@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Andrew Morton <akpm@osdl.org> wrote:
>
> Jeff Dike <jdike@addtoit.com> wrote:
> >
> > This cleans an error path which used to leak file descriptors by returning
> > without trying to tidy up.
> 
> The code in 2.6.12-rc6 is quite different from whatever you've patched here.

Ah.  Please ignore.  The patches arrived out-of-order, with a huge time gap.


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

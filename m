Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVHwC-0004ln-FG	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 16:45:24 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1DVHwB-0001Ns-Sv
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 16:45:24 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20050509164546.0d6d136b.akpm@osdl.org>
In-Reply-To: <200505100110.16920.blaisorblade@yahoo.it>
References: <200505100110.16920.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [patch 0/6] latest bugfixes for 2.6.12
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
Date: Mon, 9 May 2005 16:45:46 -0700
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, bstroesser@fujitsu-siemens.com

Blaisorblade <blaisorblade@yahoo.it> wrote:
>
> Here are some more fixes intended for 2.6.12 (and well tested). Can you merge 
> them soon, Andrew? Thanks.

Sure.

> The first is a particularly bad one since it shows up when you *start* 
> compiling UML (due to a quilt patch -> normal patch conversion problem, a 
> file wasn't actually deleted, but it was when applied through quilt). Was 
> this too quick a merge, maybe? What's your "merging policy" (if any) for 
> patches?

Jeff sent in fixes which were dependent on other things I had, we're maybe
several weeks away from 2.6.12, so I figured there was plenty of time to
get things fixed up - best to get it all flushed out and fix any fallout
rather than hang around, given that UML seems to be still changing in
fairly significant ways.



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

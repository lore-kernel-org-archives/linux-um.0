Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSkgS-0006AV-6z	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 May 2005 16:50:40 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1DSkgQ-0007eL-Lp
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 May 2005 16:50:40 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20050502165103.6d76f394.akpm@osdl.org>
In-Reply-To: <20050501184515.F1AA48D835@zion>
References: <20050501184515.F1AA48D835@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [patch 1/1] Uml: kludgy compilation fixes for x86-64
	subarch modules support [for -mm]
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
Date: Mon, 2 May 2005 16:51:03 -0700
To: blaisorblade@yahoo.it
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, ak@suse.de

blaisorblade@yahoo.it wrote:
>
> These are some trivial fixes for the x86-64 subarch module support. The only
> potential problem is that I have to modify arch/x86_64/kernel/module.c, to
> avoid copying the whole of it.
> 
> I can't use it verbatim because it depends on a special vmalloc-like area for
> modules, which for now (maybe that's to fix, I guess not) UML/x86-64 has not.
> I went the easy way and reused the i386 vmalloc()-based allocator.

Why is this "for -mm" and not for -linus?


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSdxt-00085K-Ao	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 May 2005 09:40:13 -0700
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1DSdxr-0000D9-PO
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 May 2005 09:40:13 -0700
From: Andi Kleen <ak@suse.de>
Message-ID: <20050502164001.GF7342@wotan.suse.de>
References: <20050501184515.F1AA48D835@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050501184515.F1AA48D835@zion>
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
Date: Mon, 2 May 2005 18:40:01 +0200
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, ak@suse.de

On Sun, May 01, 2005 at 08:45:15PM +0200, blaisorblade@yahoo.it wrote:
> 
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> Cc: Andi Kleen <ak@suse.de>
> 
> These are some trivial fixes for the x86-64 subarch module support. The only
> potential problem is that I have to modify arch/x86_64/kernel/module.c, to
> avoid copying the whole of it.
> 
> I can't use it verbatim because it depends on a special vmalloc-like area for
> modules, which for now (maybe that's to fix, I guess not) UML/x86-64 has not.
> I went the easy way and reused the i386 vmalloc()-based allocator.

Patch is ok for me. Another way would have been to use __attribute__((weak)),
but I guess the ifdef is ok too.

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

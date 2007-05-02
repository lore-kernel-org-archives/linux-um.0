Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjBIZ-0002yW-Vl for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 May 2007 02:39:00 -0700
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HjBIX-00079K-M3
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 May 2007 02:38:59 -0700
From: Andi Kleen <ak@novell.com>
Date: Wed, 2 May 2007 11:37:48 +0200
References: <20070501182157.GA8348@c2.user-mode-linux.org>
In-Reply-To: <20070501182157.GA8348@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200705021137.48675.ak@novell.com>
Subject: Re: [uml-devel] [PATCH 2/6] Create asm-i386/cmpxchg.h
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tuesday 01 May 2007 20:21:57 Jeff Dike wrote:
> Rearrange the i386 cmpxchg code to allow atomic.h to get it without
> needing to include system.h.  This kills warnings in the UML build
> from atomic.h about implicit declarations of cmpxchg symbols.  The
> i386 build presumably isn't seeing this because a separate inclusion
> of system.h is covering it over.
> 
> The cmpxchg stuff is moved to asm-i386/cmpxchg.h, with an include left
> in system.h for the benefit of generic code which expects cmpxchg
> there.
> 
> Meanwhile, atomic.h includes cmpxchg.h.

Doesn't apply against the latest ff tree. Can you please regenerate,
not losing whatever change caused it to reject?

-Andi

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

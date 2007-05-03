Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hjir8-0002bz-AD for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 May 2007 14:28:54 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hjir6-0005YF-QB
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 May 2007 14:28:54 -0700
Date: Thu, 3 May 2007 17:23:19 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070503212319.GA9082@c2.user-mode-linux.org>
References: <20070501182157.GA8348@c2.user-mode-linux.org>
	<200705021137.48675.ak@novell.com>
	<20070502153847.GC6752@c2.user-mode-linux.org>
	<20070502175522.a430f216.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070502175522.a430f216.dada1@cosmosbay.com>
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
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: akpm@osdl.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@novell.com>

On Wed, May 02, 2007 at 05:55:22PM +0200, Eric Dumazet wrote:
> My guess is ff means firstfloor :) 
> 
> https://www.x86-64.org/pipermail/discuss/2006-January/007467.html

Thanks!  That makes much more sense than my funky German keyboard theory...

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjIRo-0002aM-1q for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 May 2007 10:17:00 -0700
Received: from pfx2.jmh.fr ([194.153.89.55])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HjIRh-00022z-2Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 May 2007 10:16:54 -0700
Date: Wed, 2 May 2007 17:55:22 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
Message-Id: <20070502175522.a430f216.dada1@cosmosbay.com>
In-Reply-To: <20070502153847.GC6752@c2.user-mode-linux.org>
References: <20070501182157.GA8348@c2.user-mode-linux.org>
	<200705021137.48675.ak@novell.com>
	<20070502153847.GC6752@c2.user-mode-linux.org>
Mime-Version: 1.0
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
Cc: akpm@osdl.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@novell.com>

On Wed, 2 May 2007 11:38:47 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> On Wed, May 02, 2007 at 11:37:48AM +0200, Andi Kleen wrote:
> > Doesn't apply against the latest ff tree. Can you please regenerate,
> > not losing whatever change caused it to reject?
> 
> What's the ff tree?  Is 'f' next to 'm' on your keyboard?
> 
>

My guess is ff means firstfloor :) 

https://www.x86-64.org/pipermail/discuss/2006-January/007467.html


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hjc95-0003f1-9G for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 May 2007 07:18:59 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hjc92-0002gq-7p
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 May 2007 07:18:57 -0700
Date: Thu, 3 May 2007 10:14:05 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070503141405.GA5522@c2.user-mode-linux.org>
References: <20070501193646.GA9482@c2.user-mode-linux.org>
	<20070502230919.cb6864df.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070502230919.cb6864df.akpm@linux-foundation.org>
Subject: Re: [uml-devel] [PATCH] UML - forgot asm-um/cmpxchg.h
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, May 02, 2007 at 11:09:19PM -0700, Andrew Morton wrote:
> OK, I clumped all three patches into one as I think that's required for
> git-bisect friendliness.

OK - I separated the i386 and x86_64 bits to make it easy to drop the
x86_64 part.

Plus, I think it doesn't make any difference - the headers behave the
same as seen from the outside, except that UML needs the uml-cmpxchg
patch in order to build.  So, putting that first, then the other two
separately results in a patchset that builds at all stages, I believe.

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

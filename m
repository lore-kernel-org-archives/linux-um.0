Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HlzwX-0000Sp-Fo for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 May 2007 21:07:54 -0700
Received: from smtp1.linux-foundation.org ([65.172.181.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HlzwW-0001lL-3i
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 May 2007 21:07:53 -0700
Date: Wed, 9 May 2007 21:07:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20070509210738.a06b005a.akpm@linux-foundation.org>
In-Reply-To: <20070509202722.GA22464@c2.user-mode-linux.org>
References: <20070509202722.GA22464@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 5/6] UML - Monitor stack usage
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, 9 May 2007 16:27:22 -0400 Jeff Dike <jdike@addtoit.com> wrote:

> In preparation for reducing stack size, add a machanism to see how
> much of a kernel stack is used.  This fills a new stack with 0x6b on
> allocation and sees where the lowest non-0x6b byte is on process
> exit.  It keeps track of the lowest value and logs values as they get
> lower.

but, but.  We already have CONFIG_DEBUG_STACK_USAGE?

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

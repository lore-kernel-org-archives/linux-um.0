Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HyDYu-0005rX-ME for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jun 2007 14:06:00 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HyDYs-0001tC-Sm
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jun 2007 14:06:00 -0700
Date: Tue, 12 Jun 2007 14:05:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20070612140544.40123d0c.akpm@linux-foundation.org>
In-Reply-To: <20070612164806.GA7517@c2.user-mode-linux.org>
References: <20070612164806.GA7517@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/2] UML - Remove PAGE_SIZE from libc code
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
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

On Tue, 12 Jun 2007 12:48:06 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> Distros seem to be removing PAGE_SIZE from asm/page.h

They do?  That seems like a strange thing to do.  I wonder why, and I
wonder why such a change isn't needed in the mainline tree.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

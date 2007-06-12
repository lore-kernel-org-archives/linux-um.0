Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HyDqd-0007ya-ME for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jun 2007 14:24:20 -0700
Received: from mx1.redhat.com ([66.187.233.31])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HyDqc-00018R-AG
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jun 2007 14:24:19 -0700
Date: Tue, 12 Jun 2007 17:24:03 -0400
From: Dave Jones <davej@redhat.com>
Message-ID: <20070612212403.GD15041@redhat.com>
References: <20070612164806.GA7517@c2.user-mode-linux.org>
	<20070612140544.40123d0c.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070612140544.40123d0c.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Jun 12, 2007 at 02:05:44PM -0700, Andrew Morton wrote:
 > On Tue, 12 Jun 2007 12:48:06 -0400
 > Jeff Dike <jdike@addtoit.com> wrote:
 > 
 > > Distros seem to be removing PAGE_SIZE from asm/page.h
 > 
 > They do?  That seems like a strange thing to do.  I wonder why, and I
 > wonder why such a change isn't needed in the mainline tree.

From userland includes, yes.  User apps should be using getpagesize()

	Dave

-- 
http://www.codemonkey.org.uk

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

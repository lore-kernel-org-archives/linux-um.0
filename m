Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IL47q-0001Zz-Sv for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2007 14:40:31 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IL47k-0001AE-94
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2007 14:40:28 -0700
Date: Tue, 14 Aug 2007 17:40:16 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070814214016.GA17320@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 0/14] UML - Get rid of tt mode
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This set of patches is 2.6.24 material.

It throws out tt mode, which has been non-functional for a while.

This is done in phases, interspersed with code cleanups on the
affected files.

The removal is done as follows:
	remove all code, config options, and files which depend on
CONFIG_MODE_TT
	get rid of the CHOOSE_MODE macro, which decided whether to
call tt-mode or skas-mode code, and replace invocations with their
skas portions
	replace all now-trivial procedures with their skas equivalents

There are now a bunch of now-redundant pieces of data structures,
including mode-specific pieces of the thread structure, pt_regs, and
mm_context.  These are all replaced with their skas-specific contents.

As part of the ongoing style compliance project, I made a style pass
over all files that were changed.  There are three such patches, one
for each phase, covering the files affected by that phase but no later
ones.

I noticed that we weren't freeing the LDT state associated with a
process when it exited, so that's fixed in one of the later patches.

The last patch is a tidying patch which I've had for a while, but
which caused inexplicable crashes under tt mode.  Since that is no
longer a problem, this can now go in.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

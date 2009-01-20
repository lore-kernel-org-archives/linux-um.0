Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jdike@addtoit.com>) id 1LP8ie-0002KC-HA
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2009 05:00:08 +0000
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LP8ib-0001iP-Vp
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2009 05:00:08 +0000
Date: Mon, 19 Jan 2009 23:59:59 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20090120045959.GA18187@c2.user-mode-linux.org>
References: <49754AB5.3000701@hathawaymix.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49754AB5.3000701@hathawaymix.org>
Subject: Re: [uml-devel] [Patch] UML: spurious interrupt freezes guest
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Shane Hathaway <shane@hathawaymix.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Jan 19, 2009 at 08:53:25PM -0700, Shane Hathaway wrote:
> A new instance of user mode linux that I created over the past couple of
> days worked pretty well except that it had a habit of freezing after a
> few minutes.  Every time it froze, the last message on the console was
> either:
> 
> spurious interrupt in ubd_handler, err = 4

What version and what's the workload?

     	     	 	Jeff

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

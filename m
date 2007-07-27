Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IESnO-00060m-2V for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Jul 2007 09:36:06 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IESnL-0004Hx-1T
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Jul 2007 09:36:06 -0700
Date: Fri, 27 Jul 2007 12:35:41 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070727163541.GA6930@c2.user-mode-linux.org>
References: <200707270945.LAA17372@ifs.emn.fr>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200707270945.LAA17372@ifs.emn.fr>
Subject: Re: [uml-devel] [PATCH 18/68] 0 -> NULL, for arch/um
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
To: Yoann Padioleau <padator@wanadoo.fr>
Cc: akpm@linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, Jul 27, 2007 at 11:45:56AM +0200, Yoann Padioleau wrote:
> When comparing a pointer, it's clearer to compare it to NULL than to 0.

ACK

>  sys-i386/fault.c   |    2 +-
>  sys-x86_64/fault.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Except you should probably diff from the top of the kernel tree.

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

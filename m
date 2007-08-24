Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IOMwT-00056h-PE for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Aug 2007 17:22:25 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IOMwS-0005cd-7s
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Aug 2007 17:22:25 -0700
Date: Thu, 23 Aug 2007 20:22:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070824002217.GA11648@c2.user-mode-linux.org>
References: <1554af80879a7ef2f78a4d654f23c248203500d9.1187912217.git.jesper.juhl@gmail.com>
	<9c32c87607b7e38a8bdfd5a9e536d42f259c7f64.1187912217.git.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9c32c87607b7e38a8bdfd5a9e536d42f259c7f64.1187912217.git.jesper.juhl@gmail.com>
Subject: Re: [uml-devel] [PATCH 03/30] um: Don't unnecessarily cast
	allocation return value in ubd_kern.c
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
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Fri, Aug 24, 2007 at 01:43:49AM +0200, Jesper Juhl wrote:
> vmalloc() returns a void pointer, so casting to (void *) is pretty pointless.

Righto, I'll take care of this.

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

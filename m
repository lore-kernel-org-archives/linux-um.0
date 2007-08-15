Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILJkm-0001LN-Us for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Aug 2007 07:21:45 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ILJkl-0007TF-Fr
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Aug 2007 07:21:44 -0700
Date: Wed, 15 Aug 2007 10:21:25 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070815142125.GA5376@c2.user-mode-linux.org>
References: <20070814212533.GT18945@stusta.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070814212533.GT18945@stusta.de>
Subject: Re: [uml-devel] [2.6 patch] UML: "extern inline" -> "static inline"
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
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, Aug 14, 2007 at 11:25:33PM +0200, Adrian Bunk wrote:
> "extern inline" will have different semantics with gcc 4.3.

Thanks, I'll send this in.

BTW, I killed off CONFIG_MODE_TT yesterday.

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

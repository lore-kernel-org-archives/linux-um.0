Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IlS9E-0000LI-CB for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Oct 2007 09:35:01 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IlS9B-0004TO-R6
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Oct 2007 09:35:00 -0700
Date: Fri, 26 Oct 2007 12:34:47 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071026163447.GD7770@c2.user-mode-linux.org>
References: <ea9232d10710251210n31cdd93w79f175af403cd6ad@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ea9232d10710251210n31cdd93w79f175af403cd6ad@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] uml: removing xmm detection
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
To: Magotari <magotari@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Oct 25, 2007 at 09:10:25PM +0200, Magotari wrote:
> This patch removes some code which ran at every boot, but does not
> seem to do anything anymore. Please test. It works for me but mistakes
> can happen.
> 
> Karol Swietlicki
> 
> Signed-off-by: Karol Swietlicki <magotari@gmail.com>

Thanks, this is in my tree.

			Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

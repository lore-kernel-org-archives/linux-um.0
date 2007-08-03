Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IH10U-0002Wo-Qe for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Aug 2007 10:32:11 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IH10U-0004wg-CK
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Aug 2007 10:32:10 -0700
Date: Fri, 3 Aug 2007 13:31:54 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070803173154.GB8286@c2.user-mode-linux.org>
References: <20061212233533.GB28443@stusta.de>
	<20061213041837.GA8825@ccure.user-mode-linux.org>
	<20070728154705.GB30976@stusta.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070728154705.GB30976@stusta.de>
Subject: Re: [uml-devel] RFC: UML: remove MODE_TT?
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
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, Jul 28, 2007 at 05:47:05PM +0200, Adrian Bunk wrote:
> MODE_TT is still marked as broken and still not compiling...
> 
> Will anyone fix it or can it finally be removed?

I guess it should finally be removed...

I have a patch which does that - I'll see how easily it moves to the
bottom of my patchset.

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

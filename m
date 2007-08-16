Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILgef-0005g5-BW for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 07:48:57 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ILged-0008Qj-Sz
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 07:48:57 -0700
Date: Thu, 16 Aug 2007 10:48:41 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070816144841.GC6670@c2.user-mode-linux.org>
References: <20070813124247.GA7414@she-seel.salle-s.org>
	<20070815171247.GA7948@c2.user-mode-linux.org>
	<20070815213825.GA26490@clipper.ens.fr>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070815213825.GA26490@clipper.ens.fr>
Subject: Re: [uml-devel] [PATCH] UML: BLKGETSIZE takes a long, not an int
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
To: Nicolas George <nicolas.george@normalesup.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Aug 15, 2007 at 11:38:25PM +0200, Nicolas George wrote:
> Here is the hopefully correct patch, against current git.

Thanks, I'll forward it upstream.

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

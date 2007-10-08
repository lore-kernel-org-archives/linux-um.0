Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IeuqV-0004Ri-AM for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Oct 2007 08:48:39 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IeuqS-0003CU-Ki
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Oct 2007 08:48:38 -0700
Date: Mon, 8 Oct 2007 11:47:53 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071008154753.GA6495@c2.user-mode-linux.org>
References: <20071001212306.GA10113@c2.user-mode-linux.org>
	<Pine.LNX.4.64.0710020841411.28398@anakin>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710020841411.28398@anakin>
Subject: Re: [uml-devel] [PATCH 1/3] UML - Fix stub address calculations
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Magotari@gail.com

On Tue, Oct 02, 2007 at 08:43:00AM +0200, Geert Uytterhoeven wrote:
> Hmm, perhaps you can use _AC() (from <linux/const.h>) to defined the original
> constants instead, so you don't need the #ifdefs?

Ah, neat.  Those are exactly what I need.

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

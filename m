Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IYnRN-0002Mq-2b for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Sep 2007 11:41:25 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IYnRK-0004si-NB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Sep 2007 11:41:25 -0700
Date: Fri, 21 Sep 2007 14:41:16 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070921184116.GA7969@c2.user-mode-linux.org>
References: <46E016D8.4000803@theshore.net>
	<20070910161400.GF14112@c2.user-mode-linux.org>
	<46E5CE03.6000009@theshore.net>
	<200709111601.03376.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200709111601.03376.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] init_new_context_skas - new_mm failed, errno = -24
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, "Christopher S. Aker" <caker@theshore.net>

On Tue, Sep 11, 2007 at 04:00:58PM +0200, Blaisorblade wrote:
> So I'm 99% sure that you have indeed too many open files. 

And this could happen if you have a ton of processes inside the UML,
each with its own /proc/mm descriptor.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

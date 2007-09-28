Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ib4Y7-00055s-6O for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Sep 2007 18:21:47 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ib4Y6-0007mT-Ml
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Sep 2007 18:21:47 -0700
Date: Thu, 27 Sep 2007 21:21:32 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070928012132.GA10302@c2.user-mode-linux.org>
References: <20070927170126.GA6542@c2.user-mode-linux.org>
	<20070927165340.fd5dc2d0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070927165340.fd5dc2d0.akpm@linux-foundation.org>
Subject: Re: [uml-devel] [PATCH] UML - Correctly handle skb allocation failures
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Sep 27, 2007 at 04:53:40PM -0700, Andrew Morton wrote:
> Still wanna know why it is safe for uml_net_rx to be playing with
> drop_skb when update_drop_skb() could be concurrently reallocating
> and freeing it.

Ah, yes, I missed that point in the horror of my botch last night.

I'll add irqsave/irqrestore to the locking - keep this patch, and I'll
send in a fix.

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

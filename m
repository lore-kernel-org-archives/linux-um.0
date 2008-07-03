Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KEPIs-0007IU-QF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jul 2008 06:56:55 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KEPIp-00044t-QK
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jul 2008 06:56:53 -0700
Date: Thu, 3 Jul 2008 09:56:39 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080703135639.GA8262@c2.user-mode-linux.org>
References: <5df78e1d0807030053x8a9bfabo582ea78e74b2c65b@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5df78e1d0807030053x8a9bfabo582ea78e74b2c65b@mail.gmail.com>
Subject: [SPAM] Re: [uml-devel] 2.6.25 uml kernel crashes when it calls down()
	on	a semaphore with zero counter
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
To: Jiaying Zhang <jiayingz@google.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Jul 03, 2008 at 12:53:46AM -0700, Jiaying Zhang wrote:
> I found since 2.6.25 kernels, uml crashes when it calls down() on a
> semaphore with
> zero counter.

What's the stack trace?

Can you bisect it?

		Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

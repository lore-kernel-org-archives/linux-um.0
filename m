Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JRre6-0004xM-5E for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Feb 2008 08:18:10 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JRre2-0002La-KL
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Feb 2008 08:18:10 -0800
Date: Wed, 20 Feb 2008 11:18:00 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080220161800.GA8828@c2.user-mode-linux.org>
References: <287505.46914.qm@web32213.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <287505.46914.qm@web32213.mail.mud.yahoo.com>
Subject: Re: [uml-devel] sleep() calls blocks forever after settimeofday()
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
To: Stephen Su <ssu_7@yahoo.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Feb 19, 2008 at 08:10:13PM -0800, Stephen Su wrote:
> I am still on Linux kernel 2.6.17.4, I ran into sleep() calls blocks
> forever after change date of time. Please help! 

You mean like this?

	[root@uml-test ~]# date -s tomorrow
	Thu Feb 21 11:16:40 EST 2008
	[root@uml-test ~]# time sleep 1

	real    0m1.020s
	user    0m0.000s
	sys     0m0.000s

Works here, so maybe you could use a more modern UML.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

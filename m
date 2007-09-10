Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IUn9R-0000Bu-Ca for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 10:34:27 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IUn9L-0006K1-UF
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 10:34:18 -0700
Date: Mon, 10 Sep 2007 11:59:43 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070910155943.GA14112@c2.user-mode-linux.org>
References: <20070904214521.GB5417@c2.user-mode-linux.org>
	<296838.33596.qm@web52009.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <296838.33596.qm@web52009.mail.re2.yahoo.com>
Subject: Re: [uml-devel] [uml-user] Hanging using 'iptables -L' in UML vm
	booted with con0=pts
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
To: Richard Andrews <bbmaj7@yahoo.com.au>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Sep 05, 2007 at 09:00:51AM +1000, Richard Andrews wrote:
> There is an outstanding kernel + mod_utils bug I am tracking via RedHat that
> exhibits similar behaviour - lockup with 100% CPU in modprobe.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=212922

This one seems not to have anything to do with UML, while the bug that
we're talking about here seems to, as modprobe sometimes works and
sometimes doesn't.

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

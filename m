Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HUrDt-00079C-VR for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Mar 2007 14:22:58 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HUrDs-0003Sk-GA
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Mar 2007 14:22:57 -0700
Date: Fri, 23 Mar 2007 17:20:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070323212027.GA10317@c2.user-mode-linux.org>
References: <20070323193730.GA9519@c2.user-mode-linux.org>
	<7B4268E5ACB878429B58D4BE5B780E83012A6D1D@NWS-EXCH2.nws.oregonstate.edu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7B4268E5ACB878429B58D4BE5B780E83012A6D1D@NWS-EXCH2.nws.oregonstate.edu>
Subject: Re: [uml-devel] [PATCH] UML - host VDSO fix
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "Brock, Anthony - NET" <Anthony.Brock@oregonstate.edu>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Mar 23, 2007 at 02:05:42PM -0700, Brock, Anthony - NET wrote:
> Is this going into stable or devel? If stable, what version? Also, do
> you know what version of the host kernels introduced this behavior?

It's in mainline (2.6.21-rc4 now).  The mail that you're replying to
hopefully will get the fix into 2.6.20.4.

> Sorry for all the questions, but I believe this is the bug I've been
> waiting on for a while (affecting host kernels greater than 2.6.17, or
> something of that nature). Thanks!

I believe so too, but more confirmation is always welcome.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

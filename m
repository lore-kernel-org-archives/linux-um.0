Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXU4s-0006QW-Rw for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 20:16:33 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HXU4r-0003bO-Cn
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 20:16:30 -0700
Date: Fri, 30 Mar 2007 23:12:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070331031252.GA11746@c2.user-mode-linux.org>
References: <20070331012027.24884.85252.stgit@americanbeauty.home.lan>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070331012027.24884.85252.stgit@americanbeauty.home.lan>
Subject: Re: [uml-devel] [PATCH] [PATCH] uml: fix static linking for real
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
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, Mar 31, 2007 at 03:20:27AM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> There was a typo in commit 7632fc8f809a97f9d82ce125e8e3e579390ce2e5, preventing
> it from working - 32bit binaries crashed hopelessly before the below fix and
> work perfectly now.
> Merge for 2.6.21, please.

ACK.

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

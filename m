Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOMPR-0004nn-AN for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 15:16:01 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HOMPP-0003KJ-J5
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 15:16:01 -0800
Date: Mon, 5 Mar 2007 18:07:11 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070305230711.GA9525@ccure.user-mode-linux.org>
References: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
	<20070305204902.9072.1224.stgit@americanbeauty.home.lan>
	<20070305220334.GB7702@ccure.user-mode-linux.org>
	<200703052359.13612.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200703052359.13612.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 04/11] uml - hostfs: avoid possible escapes
	from hostfs=.
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 05, 2007 at 11:59:13PM +0100, Blaisorblade wrote:
> I gave a look, and it's nice. Except that maybe "escapes_jail" would be a 
> clearer name (there's confusion about the subject of "escaping").

Feel free to change the name.

> Also, what about concurrent UML threads caring about current directory? I
> know that without SMP/preemption we can't have this problem, but
> when I see this I count a future bug unless this is checked (I think I
> reason mathematically about correctness, even if not formally).

Good point, yes this does need fixing for SMP.

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

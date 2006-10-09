Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GX73p-0003ll-Iv for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 19:09:37 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GX73m-0000G8-VW
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 19:09:37 -0700
Date: Mon, 9 Oct 2006 14:11:01 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061009181101.GD4931@ccure.user-mode-linux.org>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
Subject: Re: [uml-devel] [PATCH 00/14] UML: simple changes for 2.6.19
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
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Oct 05, 2006 at 11:32:12PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> This is the first set of patches for UML for 2.6.19 I send - I have various
> other patches to merge but I'm sending them in separate batches to avoid
> flooding.

ACK to all of these, except for the first one (moving the inclusion of
the arch Makefile), which seems wrong to me.

				Jeff

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GU2zT-0008Fp-Sm for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 08:12:28 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GU2zS-0007H0-A6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 08:12:27 -0700
Date: Sun, 1 Oct 2006 11:11:11 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061001151111.GA3552@ccure.user-mode-linux.org>
References: <200609251834.k8PIYWLu005031@ccure.user-mode-linux.org>
	<200610011649.08382.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200610011649.08382.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 3/8] UML - Fix missing x86_64 register
	definitions
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
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, Oct 01, 2006 at 04:49:07PM +0200, Blaisorblade wrote:
> The patch is ok for me, but frankly, this hunk could be further cleaned up - 
> there is an awful hardcoded duplication of code which could be removed (the 
> definition could be split away from <sysdep/ptrace.h> if inclusion order hell
> starts).

Yeah, these headers needs some serious cleanup.

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

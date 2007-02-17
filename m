Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HIDiZ-0000t9-7N for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 16:46:27 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HIDiV-0006s7-O8
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 16:46:23 -0800
Date: Fri, 16 Feb 2007 19:38:41 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070217003841.GA9910@ccure.user-mode-linux.org>
References: <11715068631914-git-send-email-blaisorblade@yahoo.it>
	<200702152005.56594.blaisorblade@yahoo.it>
	<20070216190204.GB7481@ccure.user-mode-linux.org>
	<200702170104.36122.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200702170104.36122.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] x86_64: fix 2.6.18 regression -
	PTRACE_OLDSETOPTIONS should be accepted
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

On Sat, Feb 17, 2007 at 01:04:35AM +0100, Blaisorblade wrote:
> Which kernel? I've not yet tested 2.6.20. I'll try debugging this 
> subsequently.

2.6.20-rc6-mm3 on 2.6.20 + patches works for me.

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

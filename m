Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHk8w-0002vo-C0 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 09:11:38 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HHk8r-0007j5-Rz
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 09:11:38 -0800
Date: Thu, 15 Feb 2007 12:01:54 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070215170154.GA5641@ccure.user-mode-linux.org>
References: <11715068631914-git-send-email-blaisorblade@yahoo.it>
	<20070215025423.GA9300@ccure.user-mode-linux.org>
	<200702150443.42287.blaisorblade@yahoo.it>
	<20070214215123.57ef2d4a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070214215123.57ef2d4a.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org

On Wed, Feb 14, 2007 at 09:51:23PM -0800, Andrew Morton wrote:
> Whatever happens, please ensure that the final fix makes it into -stable
> as well.  Jeff's version of this patch wasn't cc'ed to stable@kernel.org.

Paolo's patch was sent to -stable.  His should be used everywhere, and mine
should be dropped.

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

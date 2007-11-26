Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iwi35-0002OM-LD for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 09:47:11 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Iwi33-00028g-6U
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 09:47:11 -0800
Date: Mon, 26 Nov 2007 12:47:02 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071126174702.GA10143@c2.user-mode-linux.org>
References: <E1Is5FL-00078H-00@dorka.pomaz.szeredi.hu>
	<20071114011002.GA11477@c2.user-mode-linux.org>
	<E1IsFbA-0007y2-00@dorka.pomaz.szeredi.hu>
	<20071114142247.GA5848@c2.user-mode-linux.org>
	<E1IsK83-0008CJ-00@dorka.pomaz.szeredi.hu>
	<20071114173639.GA7899@c2.user-mode-linux.org>
	<E1IsPo5-0008RU-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1IsPo5-0008RU-00@dorka.pomaz.szeredi.hu>
Subject: Re: [uml-devel] uml doesn't work on 2.6.24-rc2
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Nov 14, 2007 at 10:29:57PM +0100, Miklos Szeredi wrote:
> nanosleep({0, 0}, {0, 0})               = 0
> gettimeofday({1195075504, 182333}, NULL) = 0
> setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}}, {it_interval={0, 0}, it_value={0, 0}}) = 0
> nanosleep({0, 0}, {0, 0})               = 0

Can you see if this still happens with rc3-mm1?

I can't reproduce it any more, which gets in the way of debugging it.

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

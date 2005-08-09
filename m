Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2ZZf-0000Ds-Gh	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Aug 2005 12:15:43 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1E2ZZd-0002pX-7n
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Aug 2005 12:15:43 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1E2Uf4-0005sF-H4	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Aug 2005 07:01:01 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] 'soft lockup' issue on shutdown
Message-ID: <20050809134702.GA4254@ccure.user-mode-linux.org>
References: <CBELIFGMBIEPIEOFCJFAGEIPCAAA.brocka@sterlingcgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBELIFGMBIEPIEOFCJFAGEIPCAAA.brocka@sterlingcgi.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 9 Aug 2005 09:47:02 -0400
To: Anthony Brock <brocka@sterlingcgi.com>
Cc: UML Developer's List <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Aug 07, 2005 at 03:57:48PM -0700, Anthony Brock wrote:
> I've been encountering a "freeze" on shutdown with guest kernel
> 2.6.12-rc5-mm1. Today, I was busy with other things so I left it frozen for
> a while. When I returned, I saw the following:
> 
> Turning off swap
> BUG: soft lockup detected on CPU#0!

How reproducable is this?  I was seeing sleeps sleeping forever, often
on shutdown, but in a different place than this.

				Jeff


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

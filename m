Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHkE4-0003gJ-Bp for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 09:16:58 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HHkE1-0003XJ-K1
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 09:16:56 -0800
Date: Thu, 15 Feb 2007 12:09:16 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070215170916.GC5641@ccure.user-mode-linux.org>
References: <20070215160001.GA6774@avocado.homenet>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070215160001.GA6774@avocado.homenet>
Subject: Re: [uml-devel] [UML] fix crash in block layer
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
To: Jason Lunz <lunz@falooley.org>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Jens Axboe <jens.axboe@oracle.com>

On Thu, Feb 15, 2007 at 11:00:01AM -0500, Jason Lunz wrote:
> Permit lvm to create logical volumes without crashing UML.

Thanks, this is in my tree.

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

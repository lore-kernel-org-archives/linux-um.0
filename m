Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GohxD-0004UQ-9R for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Nov 2006 06:59:31 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gohx9-0008U0-HI
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Nov 2006 06:59:31 -0800
Date: Mon, 27 Nov 2006 09:55:00 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061127145500.GA4876@ccure.user-mode-linux.org>
References: <456A58ED.9000106@centecnetworks.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <456A58ED.9000106@centecnetworks.com>
Subject: Re: [uml-devel] UML crash by SIG_BUS
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
To: Miao Qingjun <qmiao@centecnetworks.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Nov 27, 2006 at 11:18:05AM +0800, Miao Qingjun wrote:
> my uml is often crashed by SIG_BUS.
> 
> Can anybody help me resolve this problem?
> 
> The host is 2.6.12fc3-skas3-v9-pre7.
> And here is a list of error messages:
> 
> Kernel panic - not syncing: Kernel mode signal 7

Increase the size of your /tmp (or /dev/shm - whichever it is using for its
physical memory) so that it's larger than the UML physical memory.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

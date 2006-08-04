Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G90SF-0006WA-1f for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Aug 2006 07:15:11 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G90SA-0002iF-IO
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Aug 2006 07:15:07 -0700
Date: Fri, 4 Aug 2006 10:14:47 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060804141447.GA3837@ccure.user-mode-linux.org>
References: <200607070033.k670XhQR008707@ccure.user-mode-linux.org>
	<517e86fb0608040600n52f36b8ci60f4e219f8cd4b5a@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <517e86fb0608040600n52f36b8ci60f4e219f8cd4b5a@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH 10/19] UML - Remove spinlock wrapper functions
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
To: alessandro salvatori <sandr8@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, Aug 04, 2006 at 01:00:43PM +0000, alessandro salvatori wrote:
>   the new lock irq_lock is still static, but we now have preprocessor
> macros to be included from a header file instead of non-static functions in
> the same module as the static irq_lock.

I don't understand.  The changes in this patch are -
	remove two functions and their declarations
	replace calls to those functions with spin_lock_irq_save and
spin_unlock_irqsave
	move the spinlock declaration above the spin_(un)lock_irq_save
calls

Which of these are you talking about?

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

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GTojk-0002Jw-HL for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Sep 2006 16:59:16 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GToji-000567-VZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Sep 2006 16:59:16 -0700
Date: Sat, 30 Sep 2006 19:57:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060930235752.GA16968@ccure.user-mode-linux.org>
References: <451E9BAB.5030009@linuxbox.cz>
	<20060930214902.GA16457@ccure.user-mode-linux.org>
	<451EEB99.6030406@linuxbox.cz>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <451EEB99.6030406@linuxbox.cz>
Subject: Re: [uml-devel] SKAS mode not working, x86_64 SMP host, x86_64 guest, 
	problems with noprocmm
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
To: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Oct 01, 2006 at 01:11:37AM +0300, Nikola Ciprich wrote:
> You have an idea where 
> could be problem with shutting down? (this Virtual timer expired cycling?)

Oops, missed that in your previous message.

Where in the shutdown process is this?  There have been some previous
reports of hangs during swapoff which I have been unable to reproduce.
I spent part of a day last week pushing UMLs deeply into swap and
shutting them down, always successfully.

The SIGVTALRM is normal - that's just the timer.  That strace you sent
looks like the idle loop, so as far as the kernel is concerned,
everything is fine.

> and regarding /proc/mm, shouldn't this mm64 file be used? or what's it 
> used for?

/proc/mm64?  What would it do that /proc/mm doesn't?

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

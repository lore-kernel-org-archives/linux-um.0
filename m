Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsfU6-0000UH-Vf
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 01:56:14 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsfQh-0007AY-A7
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 01:52:43 -0800
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20040216095335.GA27377@elte.hu>
References: <200402151911.11890.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402151911.11890.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: Diagnosed and repeatable kernel mode panic in schedule() for 2.6!
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 16 Feb 2004 10:53:35 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>


* BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:

> While searching the archives, I noticed that this command:
> 
> while /bin/true ; do /bin/true ; done

> Kernel panic: Kernel mode fault at addr 0x1f, ip 0x400d1397
> Kernel panic: kernel BUG at kernel/exit.c:793!

can you reproduce this crash even if you boot up UML via init=/bin/bash?

	Ingo


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HcQ3v-0007if-3L for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Apr 2007 10:59:55 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HcQ3t-00085D-M1
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Apr 2007 10:59:55 -0700
Date: Fri, 13 Apr 2007 13:59:01 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070413175901.GB10624@c2.user-mode-linux.org>
References: <3aab51dc0704122214g6be916fdm148a7ff52d4e369c@mail.gmail.com>
	<20070413135447.GA4975@c2.user-mode-linux.org>
	<3aab51dc0704130931q782ce158r134c6b73d4945625@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3aab51dc0704130931q782ce158r134c6b73d4945625@mail.gmail.com>
Subject: Re: [uml-devel] Strange segmentation fault
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
To: Haifeng He <hehaifeng@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Apr 13, 2007 at 09:31:16AM -0700, Haifeng He wrote:
> Yes. So that is the problem. Is there any other place which may cause
> similar problems?

If you're going to be sprinking code randomly around UML, you need to
be cognizant of what stack the surrounding code runs on.

You hit code which is setting up a new process, and is running on a
non-kernel stack in the context of the new process.

init_thread_cb runs on the initial UML process stack.

The stubs run on a stack in the upper two pages of the process address
space.

These bits of code can't run kernel code, since they aren't on a
kernel stack, and current() et al won't be valid.

Pretty much everything else is on a kernel stack, and what you're
doing should be fine.

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

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BprDi-0002Gk-KK for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jul 2004 09:23:58 -0700
Message-Id: <200407281722.i6SHM6eh002963@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: Bug#260111: user-mode-linux: upgrade hangs at
	"NET4: Linux TCP/IP 1.0 for NET4.0 " 
In-Reply-To: Your message of "Wed, 28 Jul 2004 03:15:02 EDT."
	<200407280315.08207.alydar@users.sourceforge.net> 
References: <200407280315.08207.alydar@users.sourceforge.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 28 Jul 2004 13:22:06 -0400
To: Allen Chan <alydar@users.sourceforge.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, 260111@bugs.debian.org

alydar@users.sourceforge.net said:
> #2  0xa014f091 in cpu_idle () at process_kern.c:212 
> #3  0xa000f635 in rest_init () at init/main.c:364
> #4  0xa00025e6 in start_kernel () at init/main.c:458

This is the problem stack.  One of the init functions is tripping over a
semaphore, and no one has been able to tell me which init function it is
or which semaphore.  Although the down isn't showing in this stack, which is
a bit confusing.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

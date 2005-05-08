Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUio1-00069N-VW	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2005 03:14:37 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DUio0-00064k-GE
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2005 03:14:37 -0700
From: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1115524211.17482.23.camel@localhost.localdomain>
References: <20050507182728.GA29592@in.ibm.com>
	 <1115524211.17482.23.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1115547230.5998.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [RFC] (How to) Let idle CPUs sleep
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
Date: Sun, 08 May 2005 12:13:50 +0200
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: vatsa@in.ibm.com, schwidefsky@de.ibm.com, jdike@addtoit.com, Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>, rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, 2005-05-08 at 13:50 +1000, Rusty Russell wrote:
> My preference would be the second: fix the scheduler so it doesn't rely
> on regular polling.  However, as long as the UP case runs with no timer
> interrupts when idle, many people will be happy (eg. most embedded).

alternatively; if a CPU is idle a long time we could do a software level
hotunplug on it (after setting it to the lowest possible frequency and
power state), and have some sort of thing that keeps track of "spare but
unplugged" cpus that can plug cpus back in on demand.

That also be nice for all the virtual environments where this could
interact with the hypervisor etc





-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

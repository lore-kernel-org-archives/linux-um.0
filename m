Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0il0-0000Fi-JB for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Feb 2005 08:07:30 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D0ikz-0006Vo-1Z for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Feb 2005 08:07:30 -0800
Message-ID: <4210CCB9.1050700@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <42021E35.8050601@fujitsu-siemens.com>
	<4202C18F.5010605@yahoo.com.au>
	<42036C2C.5040503@fujitsu-siemens.com>
	<4203F40C.8040707@yahoo.com.au>
	<20050204143917.1f9507cb.akpm@osdl.org>
	<4204020F.2000501@yahoo.com.au> <42044D17.5040703@yahoo.com.au>
	<42058E52.8030306@yahoo.com.au> <20050206071935.GA19991@elte.hu>
	<4205C8EF.2000604@yahoo.com.au>
In-Reply-To: <4205C8EF.2000604@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [PATCH] fix wait_task_inactive race (was Re: Race
	condition in ptrace)
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
Date: Mon, 14 Feb 2005 17:07:21 +0100
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>, roland@redhat.com, jdike@addtoit.com, blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Your one liner would fix the problem too, of course. The important
> thing at this stage is that it gets fixed for 2.6.11.

Sorry, have been off the net last week.

Thank you for the patches. Have tested Ingo's one liner.
It works fine for me, as expected.

Bodo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

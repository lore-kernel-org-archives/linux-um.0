Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cxh90-0006xV-HC for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Feb 2005 23:47:46 -0800
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Cxh90-0004EQ-5U for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Feb 2005 23:47:46 -0800
Message-ID: <4205CB9E.4000402@yahoo.com.au>
From: Nick Piggin <nickpiggin@yahoo.com.au>
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
Date: Sun, 06 Feb 2005 18:47:42 +1100
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, bstroesser@fujitsu-siemens.com, roland@redhat.com, jdike@addtoit.com, blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Ingo Molnar wrote:
> 
>> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>
>>
>>> When a task is put to sleep, it is dequeued from the runqueue
>>> while it is still running. The problem is that the runqueue
>>> lock can be dropped and retaken in schedule() before the task
>>> actually schedules off, and wait_task_inactive did not account
>>> for this.
>>
>>
>>
>> ugh. This has been the Nth time we got bitten by the fundamental
>> unrobustness of non-atomic scheduling on some architectures ...
>> (And i'll say the N+1th time that this is not good.)
>>
> 
> This is actually due to wake_sleeping_dependent and
> dependent_sleeper dropping the runqueue lock.
> 

Hmph, *and* unlocked context switch architectures as you say.
In fact, I'm surprised those haven't been bitten by this problem
earlier.

So that makes us each half right! :)




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

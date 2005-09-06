Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ECg1a-0002vv-6R	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Sep 2005 09:10:18 -0700
Received: from rgminet01.oracle.com ([148.87.122.30])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1ECg1Y-0005qp-PT
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Sep 2005 09:10:18 -0700
Message-ID: <431DBF5E.7010707@oracle.com>
From: Allan Graves <allan.graves@oracle.com>
MIME-Version: 1.0
References: <431637F9.6030101@oracle.com>
	<20050902165935.GA6651@ccure.user-mode-linux.org>
	<200509041351.32837.blaisorblade@yahoo.it>
In-Reply-To: <200509041351.32837.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] sched and stack patch changelogs.
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
Date: Tue, 06 Sep 2005 12:10:06 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

BB: Sorry I hadn't included a changelog, Jeff and I had talked about this a lot, I forgot that other people would be reading them. :)  

Author: Allan Graves<allan.graves@gmail.com>
	Scheduler Cleanup Patch:
	This patch moves code that is in both switch_to_tt and switch_to_skas to the top level _switch_to function, keeping us from duplicating code.  It is required for the stack trace patch to work properly.

	Stack Trace Patch:
	This patch implements a stack trace for a thread, not unlike sysrq-t does.  The advantage to this is that a break point can be placed on showreqs, so that upon showing the stack, you jump immediately into the debugger.
	While sysrq-t does the same thing, sysrq-t shows *all* threads stacks.  It also doesn't work right now.  In the future, I thought it might be acceptable to make this show all pids stacks, but perhaps leaving well
	enough alone and just using sysrq-t would be okay.  For now, upon receiving the stack command, UML switches context to that thread, dumps its registers, and then switches context back to the original thread.  Since 
	UML compacts all threads into one of 4 host threads, this sort of mechanism could be expanded in the future to include other debugging helpers that sysrq does not cover.  



Blaisorblade wrote:

>On Friday 02 September 2005 18:59, Jeff Dike wrote:
>  
>
>>On Wed, Aug 31, 2005 at 07:06:33PM -0400, Allan Graves wrote:
>>    
>>
>>>Jeff,
>>>Here's the patches.  Hope these meet your approval!
>>>      
>>>
>Could you please write a proper changelog? Reading a patch is possible, but 
>needs time which I don't have in the very moment.
>
>Also, what is the difference between your "stack trace" patch, which adds a 
>member to thread_struct, for each process, so I'd like a minimum of 
>justification, and one of the sysrq options which does exactly this?
>
>Apart that the second is currently buggy, and is global, as in what you plan 
>here:
>
>/* Would be nice:
>+           1) Send showregs output to mconsole.
>+           2) Add a way to stack dump all pids.
>+        */
>
>Sorry if these questions seem bad - but that's why changelogs are used.
>  
>
>>>Allan
>>>      
>>>
>
>  
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

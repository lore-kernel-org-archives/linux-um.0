Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZO9b-0005vY-Qz for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 23:44:27 -0800
Received: from smtp3.stanford.edu ([171.67.16.138])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EZO9Z-0005lr-MJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 23:44:28 -0800
Mime-Version: 1.0 (Apple Message framework v746.2)
In-Reply-To: <200511080109.06999.rob@landley.net>
References: <200511061723.32848.rob@landley.net>
	<91A93A3A-FE83-4002-A004-E8FD4AFBAA3C@stanford.edu>
	<200511080109.06999.rob@landley.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4A8812BF-70D2-451C-9E9F-4502ED468120@stanford.edu>
Content-Transfer-Encoding: 7bit
From: Can Sar <csar@stanford.edu>
Subject: Re: [uml-devel] Making UML Single Threader
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
Date: Mon, 7 Nov 2005 23:44:13 -0800
To: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net


On Nov 7, 2005, at 11:09 PM, Rob Landley wrote:

> On Monday 07 November 2005 23:13, Can Sar wrote:
>> Hi,
>>
>> I am trying to make a 1 thread version of UML that does not need to
>> be able to support user level programs.
>
> Why?
>

Trust me, I wouldn't do this if it were not for a reason. I have no  
intention of marketing this as a general purpose alternative to  
Linux. It's to check Linux for errors.

>
>> So I don't care about systemcall interception or anything like that,
>
> *blink*  *blink*
>
> Ok, you want user mode linux, but you don't want it to actually run  
> user
> processes, nor do want it to be able to intercept system calls.
>
> Um...  What's left?
>

The ability to call the kernel implementation of some system calls  
and then halt the kernel.

>> I just want a copy of
>> UML that gets a basic kernel environment running (where I could call
>> some kernel functions like sys_read or sys_open and then exit) that
>> never calls fork on the host.
>
> vfork, maybe?
>
> Have you tried just loading a module into the existing User Mode  
> Linux?
>
>> Sorry if this all sounds a bit weird, it's for a research project and
>> we are trying to port UML to an environment that only supports single
>> threaded operation.
>
> Define "port".  (Have you looked at mmu-less linux?  Are you saying  
> you
> haven't got a timer interrupt and can't fake up some kind of green- 
> threads
> approach like people managed to do under _DOS_?)
>
> Rob

Well, we are trying to check Linux for security holes/bugs with a  
system that does not support multithreaded programs. A former member  
of our group hacked this up for UML in 2.4.19 so that it would never  
use fork (it was doing it's own checkping and restore instead of  
context switches). Unfortunately he also added a lot of features that  
were necessary for other reasons so isolating the fork/threading code  
is a nightmare. I am trying to re-implement this for 2.6.14 but it  
seems UML has changed quite a bit since then.

My basic question is what the exact purpose of the 4 threads in skas  
are. SIGIO and async ubd one are pretty obvious. The other two are a  
bit ill-defined on the website:

"The UML kernel thread, which runs in the separate kernel address  
space, executes kernel code, and does system call interception on UML  
processes
The UML userspace thread, which runs all UML process code and  
switches between host address spaces on each UML context switch"

If the kernel forks a new kernel thread (e.g. kswapd), which has no  
user space context associated with it, what host address space will  
this show up in? Is the userspace proccess strictly for threads that  
have a userspace context associated with them, or does it run every  
thread that is not the original thread of execution that UML linux  
was booted from.

Thank you,
Can Sar


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

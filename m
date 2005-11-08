Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZLnl-0000zL-E4 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 21:13:45 -0800
Received: from smtp1.stanford.edu ([171.67.16.123])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EZLnk-0004z2-4f
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 21:13:45 -0800
Received: from [171.66.50.73] (DNab423249.Stanford.EDU [171.66.50.73])
	by smtp1.Stanford.EDU (8.12.11/8.12.11) with ESMTP id jA85DOol024882
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 7 Nov 2005 21:13:29 -0800
Mime-Version: 1.0 (Apple Message framework v746.2)
In-Reply-To: <200511061723.32848.rob@landley.net>
References: <200511061723.32848.rob@landley.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <91A93A3A-FE83-4002-A004-E8FD4AFBAA3C@stanford.edu>
Content-Transfer-Encoding: 7bit
From: Can Sar <csar@stanford.edu>
Subject: [uml-devel] Making UML Single Threader
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
Date: Mon, 7 Nov 2005 21:13:19 -0800
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I am trying to make a 1 thread version of UML that does not need to  
be able to support user level programs. So I don't care about  
systemcall interception or anything like that, I just want a copy of  
UML that gets a basic kernel environment running (where I could call  
some kernel functions like sys_read or sys_open and then exit) that  
never calls fork on the host.
 From looking at the various websites I am hoping that I can just rip  
out 3 of the 4 SKAS threads and only leave the kernel thread:
"The UML kernel thread, which runs in the separate kernel address  
space, executes kernel code, and does system call interception on UML  
processes." Do the other threads (particularly the user thread) ever  
do something else that would be important?
Furthermore is the actual kernel process multi threaded?

Sorry if this all sounds a bit weird, it's for a research project and  
we are trying to port UML to an environment that only supports single  
threaded operation.

Thanks,
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

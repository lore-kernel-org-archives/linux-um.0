Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZNba-0004kg-R6 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 23:09:18 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EZNbZ-0005Lc-B6
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 23:09:18 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Making UML Single Threader
References: <200511061723.32848.rob@landley.net>
	<91A93A3A-FE83-4002-A004-E8FD4AFBAA3C@stanford.edu>
In-Reply-To: <91A93A3A-FE83-4002-A004-E8FD4AFBAA3C@stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511080109.06999.rob@landley.net>
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
Date: Tue, 8 Nov 2005 01:09:06 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Can Sar <csar@stanford.edu>

On Monday 07 November 2005 23:13, Can Sar wrote:
> Hi,
>
> I am trying to make a 1 thread version of UML that does not need to
> be able to support user level programs.

Why?

Did you ever read Rik van Reil's list of the dumbest patches he's ever seen?  
This is the first entry in the list:

http://www.surriel.com/potm/apr2001.shtml

> So I don't care about systemcall interception or anything like that,

*blink*  *blink*

Ok, you want user mode linux, but you don't want it to actually run user 
processes, nor do want it to be able to intercept system calls.

Um...  What's left?

> I just want a copy of 
> UML that gets a basic kernel environment running (where I could call
> some kernel functions like sys_read or sys_open and then exit) that
> never calls fork on the host.

vfork, maybe?

Have you tried just loading a module into the existing User Mode Linux?

> Sorry if this all sounds a bit weird, it's for a research project and
> we are trying to port UML to an environment that only supports single
> threaded operation.

Define "port".  (Have you looked at mmu-less linux?  Are you saying you 
haven't got a timer interrupt and can't fake up some kind of green-threads 
approach like people managed to do under _DOS_?)

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Btzwo-0000Zt-Di for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Aug 2004 19:31:38 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1Btzwn-0002Ye-TN
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Aug 2004 19:31:38 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] help: uml as normal user space library
Message-ID: <20040809033145.GA22230@ccure.user-mode-linux.org>
References: <20040808185206.57113.qmail@web8301.mail.in.yahoo.com>
	<Pine.LNX.4.58.0408081547550.1450@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408081547550.1450@gradall.private.brainfood.com>
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
Date: Sun, 8 Aug 2004 23:31:45 -0400
To: narender yadav <narender1983_ait@yahoo.co.in>, Adam Heath <doogie@brainfood.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Aug 08, 2004 at 03:48:21PM -0500, Adam Heath wrote:
> On Sun, 8 Aug 2004, narender yadav wrote:
> 
> > We a group of 4 students intersted in doing the
> > project "UML as a normal user space library". Can
> > anybody tell me how much time will take to complete
> > the project provided each of have average knowledge of
> > linux kernel.
> 
> Well, since no one has done it, no one knows.
> 
> We aren't going to do your work for you.

That's rather impolite given
	they're not asking anyone to do their work for them
	a time estimate is a completely reasonable thing to ask for when you
are considering something is suitable as a term project or not

To answer the actual question

> how much time will take to complete
> the project provided each of have average knowledge of
> linux kernel.

"Average knowlege" means what?  Average college students?  The average college
student knows nothing about the linux kernel.

You also need to define what you're actually going to do, and that
means understanding what the project means.  As I've described it,
it's open-ended, and you can spend as much time as you have on it.

A library is no good if nothing uses it, so you need to decide what
you're going to link against libUML and how that thing is going to use it.

Since we are talking about students, I would define the simplest
possible use of such a library, and if you manage to get that working,
then move on to something fancier.

As a suggestion, I would consider something like a shell.  Package UML
as a library, link your shell against it so that when the shell runs,
its captive UML is also running and can be logged in to , then provide
some interface between the two that allows the UML user to set shell
variables, change the working directory, or spy on the commands being
run by the shell user.

That would make a perfectly good proof of concept, and could be
expanded on incrementally in a number of directions.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

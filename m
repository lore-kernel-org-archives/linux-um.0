Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQaUG-0007o2-G4 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 16:28:36 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BQaUF-0001Ki-UH
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 16:28:36 -0700
Message-Id: <200405200014.i4K0EJDt001988@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Wed, 19 May 2004 00:12:40 +0200."
	<093601c43d25$42633a20$2000000a@schlepptopp> 
References: <40AA0BD9.7070403@thermeoneurope.com>
	<093601c43d25$42633a20$2000000a@schlepptopp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: poll: uml bug management - was: Re: [uml-user] 2.6.6
	Kernel mconsole & mem
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
Date: Wed, 19 May 2004 20:14:19 -0400
To: roland <for_spam@gmx.de>
Cc: Mark Olliver <mpo@thermeoneurope.com>, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it

for_spam@gmx.de said:
> btw: should we file a bug-report at: http://sourceforge.net/tracker/
> ?group_id=429&atid=100429 or shouldn`t that bugtracker not being used
> anymore - in general ? if not, IMHO that bugtracker should be marked
> "obsolete"(like the SF cvs repository)

You shouldn't.  I don't pay any attention to it.  However, I don't see any
way of disabling it.

> i would like to give an example for a really nice "bug page": http://
> rockbox.haxx.se/bugs.shtml
>
> that page is created by a script, which extracts the information from
> SF and puts it into a  nicely formatted page: http://
> cvs.sourceforge.net/viewcvs.py/rockbox/www/getbugs.pl
>
> why not using it, too ? 

As you mentioned, I track bugs via the lists.  I have a todo folder into which
I link any messages which require some sort of action, mostly bug reports.

This does have the disadvantage that it is very opaque to everyone but me.
It has the advantage of having been screened, and of being easy to mark things
as requiring my attention at some point.

It does have other disadvantages, such as not being able to prioritize or
categorize things.

I would use a bug reporting system if
	it was screened so that the only open problems in it are real problems
	someone else maintained it, and did so consistently
	other people watch the lists, and add bugs that are reported there,
as well as updating the bugs with stuff like workarounds and patches

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AVSUA-0007I5-Uk
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Dec 2003 01:24:22 -0800
Received: from smtp3.att.ne.jp ([165.76.15.139])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AVSUA-0000A4-H8
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Dec 2003 01:24:22 -0800
From: Richard Potter <sbuml-deletethispart@zar.att.ne.jp>
Subject: Re: [uml-devel] demo of SBUML - swsusp functionality for UML
In-Reply-To: <03ce01c3c190$edde5c10$2000000a@schlepptopp>
References: <20031213130717.D57E.SBUML-DELETETHISPART@zar.att.ne.jp> <03ce01c3c190$edde5c10$2000000a@schlepptopp>
Message-Id: <20031214182343.D583.SBUML-DELETETHISPART@zar.att.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 14 Dec 2003 18:24:19 +0900
To: user-mode-linux-devel@lists.sourceforge.net

> hey this is GREAT!
> i`m currently downloading the whole stuff and give it a try.

If you have any problems with the demo, let me know what Linux host you
are testing it on.

> 
> > UML.  Eventually it will be announced and hosted at
> > sbuml.sourceforge.net
> can you explain why it will be hosted as an extra project? 
> i just see it as additional feature for uml - so why somewhat "forking" ?
> just independence?

This is a good question.  As for the core functionality (i.e. sbumlsave
and sbumlrestore), I hope it will be merged into the UML project code.
For now, the SBUML project can be a safe place to debug the core
functionality until it is stable enough and meets Jeff's standards.  (Or
someone may re-implement this functionality in a totally different way
for the UML project, in which case the SBUML project may adopt that code.)

In addition, the overall goal of SBUML is to support what we have been
calling "Computation Scrapbook" and "Snapshot Programming" ideas. SBUML
basically makes a UML machine act like a first-class programming object.
The SBUML project will explore the higher-level programs/scripts that
this makes possible.  Some of these programs/scripts will require
extended functionality for controlling the UML that might not be of
general interest to other UML users.  For example, our work with model
checking requires scripts to externally control the scheduling order of
processes in a UML machine.  So the SBUML project will do more than add
just one "addition feature" to UML.  It will also be adding various
experimental high-level scripts and extended functionality to support
them.

At this point, I think independence will be valuable, although I hope we
can keep the forking minimal as we confirm where the projects' goals
overlap.

> 
> >Potential users might include software
> > developers who wish to prepare demos without bothering potential users
> > with setup instructions, teachers of programming who want to distribute
> > debugging scenarios to students, or software users who would like
> > provide detailed bug reports (super core dumps :-) to developers.
> and security experts can snapshot infected honeypot UML`s and transfer them
> to other experts for analysis :D
> 
Somebody told me he wants to use it for pre-configuring a bunch of IRC
clients to stress test a server he is setting up.

--Richard




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

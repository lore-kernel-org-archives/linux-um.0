Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200312060005.hB605IAv008253@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: bug in COW? - Re: [uml-user] uml 2.6.0-test9 crash 
In-Reply-To: Your message of "Sun, 30 Nov 2003 12:36:33 +0100."
             <040801c3b736$35ec4720$2000000a@schlepptopp> 
References: <Pine.LNX.4.44.0311282234040.10367-100000@filer.marasystems.com> <035a01c3b6e9$cfee1df0$2000000a@schlepptopp> <20031130082348.GX16786@haman.kerbit.net>  <040801c3b736$35ec4720$2000000a@schlepptopp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Fri, 05 Dec 2003 19:05:18 -0500
To: roland <for_spam@gmx.de>
Cc: Lynn Kerby <lfk@kerbit.net>, Henrik Nordstrom <hno@marasystems.com>, mcmechanjw@juno.com, user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

for_spam@gmx.de said:
> i really wonder a little bit, that such "one liners" don`t find their
> way more  quickly into uml.

The one-liners are getting in.  I disposed of ~40 of them a few weeks ago.

> i`m NOT angry here and I don`t want to point my fingers to anybody -
> all are doing great work here - especially jeff(btw: where is he?)

Tokyo (or at least I was, now I'm in NH recovering from let lag).

> but IMHO patchtracking and bugfixing is one of the most important
> things in OSS  development). unfortunately bug/patchtracker usage on
> SF seems declining. is this done  more and more "manually" now or is
> bug/patchtracker moved to somewhere else? 

The bug tracker is the UML mailing lists.  I stick bug reports and patches in 
a todo folder and delete them from there when I fix (or merge) them.  I pay
almost no attention to the SF patch and bug report thingies.  So if you want
your bug to get attention, send it to one of the lists.

> i hope this doesn`t sound presumptuous - but is there need for a
> "patch/bug monkey", e.g. someone for filtering patch submissions and
> bug reports from the ML and put that into SF  "trackers" - just
> somebody supporting main developers with some "QA" work? maybe i`m
> just too impatient - but i`m wishfully awaiting 2.6_uml_stable. 

It would be useful for someone to start a new UML tree, collect patches, merge 
them in, get testing, and forward them on to me.  But so far, pretty much no
one is in the code but me, so you're limited by the time that I can put into
it.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

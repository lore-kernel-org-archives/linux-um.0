Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AVXj7-0003Pf-HD
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Dec 2003 07:00:09 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AVXj7-0003Il-21
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Dec 2003 07:00:09 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH]Modules support in 2.6: reaching the complete fix
References: <200312131828.03645.blaisorblade_spam@yahoo.it> <200312132019.hBDKJ8rL002905@ccure.user-mode-linux.org>
In-Reply-To: <200312132019.hBDKJ8rL002905@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312141604.32309.blaisorblade_spam@yahoo.it>
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
Date: Sun, 14 Dec 2003 16:04:32 +0100
To: user-mode-linux-devel@lists.sourceforge.net

First, I tried without CONFIG_MODVERSIONS, and the panic doesn't happen(which 
was obvious, since the offending code is compiled #ifdef MODVERSIONS) and no 
other one appears. And the module loading works.

Only thing which obviously can't work is the umlgdb script; I need 2.6 Uml 
modules because I need to test a change to the 2.6 loop device(i.e. the 
partition support).

[About user_ksyms.c]
> Yeah, this is nasty, but I couldn't think of any way of handling this
> without just copying stuff.
Yes, I understand you've tried(though I don't know why user code can't include 
even some kernel headers, but that's my fault).

> > 2) then, the UML build system is broken for USER_OBJS.
>
> This is separate from the module problem.  It still needs fixing though.
Yes, but the general rule does some post-processing which is needed for 
modules. See scripts/Makefile.build:134 and following ones(around the 
"cmd_modversions" definition).

>
> It would be nice just to have something in one Makefile, like
> arch/um/Makefile, which makes this work.  I haven't looked at whether this
> is possible.
I'm going to try!

> > And for this, I cannot help because I've not enough  experience with
> > link scripts(I've been able to learn the syntax, but I don't  know the
> > reason why some section missing in the i386 appear in the UML  script;
> > some are from libc, but I don't know which ones).
>
> The ones you deleted are all kernel sections.

I understand this well(I'm aware of how are they born), but check and see that 
the RODATA macro, know, already includes them... so it's useless(if not 
harmful, but it shouldn't) to list them twice.

Bye
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrUCZ-000670-Tp for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Jan 2005 20:45:47 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CrUCZ-0002ko-AF
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Jan 2005 20:45:47 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] UML build process uses perl? (With sed alternative.)
References: <200501140040.56592.rob@landley.net>
	<200501191955.55131.blaisorblade@yahoo.it>
In-Reply-To: <200501191955.55131.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501192244.16326.rob@landley.net>
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
Date: Wed, 19 Jan 2005 22:44:16 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 19 January 2005 01:55 pm, Blaisorblade wrote:

> > As far as I can tell, the following sed invocation will give more or less
> > what the perl does, without a dependency on perl.  (Busybox has sed.)  It
> > may need a bit of adapting to make the makefile happy (and adding
> > config.tmp to make clean), but the concept seems to work...
> >
> > sed -e 's/^.*$/"&\\n"/' /linux-2.6.9/.config > config.tmp
>
> It's ok, if the "&" stands for the matched string as I recall; I've done it
> through this equivalent form:
>
> sed -e 's/^/"/' -e 's/$/\\n"/' .config > config.tmp

Cool.

> I've also modified this further below for a different requirement.
>
> The only potential problem is the use of the temporary file which is not
> nice, however your need seems more important in fact...

There's bound to be a way to make the temporary file go away.  I couldn't 
quite figure out how to apply the in-place option for sed, but possibly the 
sed output could be assigned to an environment variable, and the shell could 
do the final splice of the data into place...

> > sed -e '/CONFIG/{' -e 's/"CONFIG"\;/""/' -e 'r config.tmp' -e 'a ""\;' \
> >  -e '}' config.c.in
>
> If you compare that with the real result, it does not match - and you see
> it because double quotes in .config (which exist, yes) are not escaped as
> here (the dollar is escaped in the original):

As I said, it needed more work.  I wanted to float the concept to see if 
people were agreeable to it.

> Which gives the same result as the original method (there is one trivial
> difference at the beginning of the output which is, IMHO, purely
> cosmethical:
>
> --- arch/um/kernel/config.c     2005-01-19 18:51:48.174446032 +0100
> +++ ./config.c  2005-01-19 18:52:46.015652832 +0100
> @@ -9,3 +9,4 @@
>
> -static __initdata char *config = "#\n"
> +static __initdata char *config = ""
> +"#\n"
>  "# Automatically generated make config: don't edit\n"
>
> This actually should work, indeed, if translated in the Makefile... which
> should be more or less like the attached patch.
>
> Also, I wanted to avoid writing more -e options for the same programs, to
> have it clearer... however I had problems to do it in the Makefile, so I

I probably could have gotten the result to match exactly, but the result would 
have been a more complex sed invocation for no real gain...

> Please double-check that the patch works with your busybox sed
> implementation, and compare the original and the new obtained config.c
> carefully, since the sed code you supplied wasn't good.

I maintain busybox sed, and if it can't handle something gnu sed can, I will 
fix it.

> In fact, I'm no expert in sed portability, so I'm not sure if it behaves
> well with busybox (actually I'm no sed expert, so it was difficult for me
> to read your code at first).

Sorry 'bout that.  I wasn't a sed expert before I extensively rewrote busybox 
sed, but I want to replace all the gnu command line tools with busybox ones 
(for general usage: the FSF took 833 lines of C to implement "cat".  That's 
just wrong).  Sed was heavily used in the ./configure steps of a lot of 
software packages.  The old one didn't work, now it does.

I'll take a closer look at the patch this evening.  Thanks.

Rob


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

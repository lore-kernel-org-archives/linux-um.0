Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EQChj-0003i3-Ad	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Oct 2005 16:41:43 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EQChi-0008Q1-Um
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Oct 2005 16:41:43 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Getting garbage in ps, as expected...
References: <200510112252.51849.rob@landley.net>
	<20051013162111.GB5352@ccure.user-mode-linux.org>
In-Reply-To: <20051013162111.GB5352@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510131841.23578.rob@landley.net>
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
Date: Thu, 13 Oct 2005 18:41:23 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thursday 13 October 2005 11:21, Jeff Dike wrote:
> On Tue, Oct 11, 2005 at 10:52:51PM -0500, Rob Landley wrote:
> > Great fun.  So I'm using UML in -skas0 mode built from 2.6.13.2, and it's
> > putting fun garbage in the ps display:
> >
> >  7284 ?        S      0:00 [pdflush]
> > 10480 pts/3    R      0:06 ?@???            ?   ?   ?    ???s   F?! @???{
> > 12783 ?        S      0:00 [pdflush]
> >  8454 pts/3    R      0:03  @???{        " ? ???
>
> The garbage is irrelevant.

But annoying.  It's corrupting the ps display and there's no way to killall 
those threads.

> UML is supposed to clean up after itself.  How reproducable is this, and
> how do you do it?

I normally run the build:
(cat /dev/zero | ./buildscript.sh > out.txt 2>&1 &) && tail -f out.txt

(Because the standard "tee" is buggy; it stops sending to a pipe if that pipe 
is ever full, which can happen due to the process it's feeding not getting 
scheduled fast enough.  This includes your xterm.  I fixed this in the 
busybox version...)

In the above, buildscript runs UML, which exits (with a panic) but doesn't 
_stop_.  Also "killall linux" will sometimes leave the garbage threads in T 
state, and when you -CONT them they turn into CPU hogs.

Rob


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

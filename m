Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Colxe-00054f-LV for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 09:07:10 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Colxa-00049U-O8 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 09:07:10 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)?
References: <200501082106.38306.rob@landley.net>
	<200501120023.05580.blaisorblade@yahoo.it>
	<23435.1105548900@marajade.sandelman.ottawa.on.ca>
In-Reply-To: <23435.1105548900@marajade.sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501121809.13623.blaisorblade@yahoo.it>
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
Date: Wed, 12 Jan 2005 18:09:13 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>, Rob Landley <rob@landley.net>

On Wednesday 12 January 2005 17:55, Michael Richardson wrote:
> >>>>> "Blaisorblade" == Blaisorblade  <blaisorblade@yahoo.it> writes:
>
>     Rob> Chapter 5 of current variants of LFS uses the host system to
>     Rob> create a toolchain you can chroot into and build the final
>     Rob> system with.  Then in chapter 6, you build the final system in

>     >> I think the use of chroot is a cop-out.

>     Rob> This requires root access (as does creating device nodes,
>     Rob> mounting /proc or loopback devices...  A rather large number of

>     >> I use "fakeroot" to do all of that for embedded work that I do...

>     Blaisorblade> What's this?

>   A tool which LD_PRELOAD's a library that intercepts all calls that
> require root, and "emulates" them.
>   I.e. if a program does "chown(2)", it just remembers that this
> occured, and when a stat() is made, it returns the "right" answer.
>   (so tar/mkjffs, etc. get the right answer)
Ah, ok... this means it cannot work onto UML, actually (unless you dinamically 
link it - which is not the common case...).
>   Used in debian a lot.
>   http://packages.debian.org/testing/utils/fakeroot

>     Blaisorblade> Yes, that's because it turns the console to raw mode
> (don't ask me why).

>   Because, you'd like to have ^C get passed to the program being run
> under the UML :-)
Ah, well, yes, but that happens when you use /dev/tty0 as console inside UML 
(and I don't do it).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

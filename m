Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ez081-0004uz-3g for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 15:20:41 -0800
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Ez07z-0001WQ-96
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 15:20:41 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <43CA5642.9060205@gentoo.org>
	<200601160314.05831.blaisorblade@yahoo.it>
	<43CD4B1B.1060806@gentoo.org>
In-Reply-To: <43CD4B1B.1060806@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601180020.26838.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: -bs patchset still useful for users?
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
Date: Wed, 18 Jan 2006 00:20:24 +0100
To: Daniel Drake <dsd@gentoo.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 17 January 2006 20:52, Daniel Drake wrote:
> Blaisorblade wrote:
> > Vanilla can do, however -bs has one little additional feature
> > (mconsole-exec) and contains all bug fixes written after the release
> > (only few important ones go to -stable, they're very restrictive and some
> > -bs patches don't fix critical "regressions"/crashes).
> >
> > In fact, most times 2.6.n-bs is entirely merged in 2.6.(n+1).
>
> Great.

> Unless you have any strong objections, I will probably drop
> usermode-sources from Gentoo, and suggest that users migrate to
> gentoo-sources.

> The problem is that usermode-sources doesn't have a maintainer within
> Gentoo.

Given I do use Gentoo, and I understand ebuilds, is that problem solvable 
(i.e. by me becoming maintainer?)

Don't know well what this implies (I looked at "How to become a Gentoo 
developer" docs and it seemed require much more than what I do for -bs), but 
could still be pursued.

> At the moment I've been taking care of it, but you know how 
> clueless I am about UML. Also, it's a lot of work to maintain a kernel
> within a distro, and Gentoo have too many...

> Thanks for helping us out with the UML bugs, and I hope you will
> continue spending a few minutes here and there providing input. I don't
> expect you will, but if you have time, you are always welcome to send
> important UML fixes to me for inclusion in Gentoo's patchset (we aren't
> quite as strict as -stable). I'll be keeping an eye on the -bs patchset
> anyway.

There is an useful feature in -bs which isn't included in mainline (because 
Jeff Dike legitimaly thinks it's not something which should be in kernel), 
and which could be added to gentoo-sources, I hope.

 i.e. Mconsole Exec support (basically, it allows to say to UML to start a new 
process inside the guest kernel, without working network and such, and easily 
scriptable).

"uml: mconsole exec support

Adds the "exec" command to mconsole; the command is passed to /bin/sh -c, so
you know its syntax, and can freely use redirections and so on."

Latest version is at:

http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.14-bs3/broken-out/uml-mconsole-exec

Probably you'll need a link from the home page to this patch by itself (for 
updated versions, even if it's very stable), which I'll happily add if you 
agree.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

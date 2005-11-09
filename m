Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZeaj-0004D3-0V for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 17:17:33 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EZeah-0005nO-GT
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 17:17:32 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Making UML Single Threader
References: <200511061723.32848.rob@landley.net>
	<200511081835.47575.rob@landley.net>
	<200511090148.26628.blaisorblade@yahoo.it>
In-Reply-To: <200511090148.26628.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511081917.22963.rob@landley.net>
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
Date: Tue, 8 Nov 2005 19:17:22 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 08 November 2005 18:48, Blaisorblade wrote:
> On Wednesday 09 November 2005 01:35, Rob Landley wrote:
> > On Tuesday 08 November 2005 01:44, Can Sar wrote:
> >
> > P.S. What on earth is CONFIG_CMDLINE_ON_HOST?  It doesn't seem to ever be
> > set anywhere, by anything...
>
> Totally unrelated. In short, it's TT-only, it implements the old behaviour
> (nice output on ps), but it requires UML to call exec() on itself (with a
> bigger arg list, so that enough space is allocated for argv); and I
> discovered gdb gets very confused on this.
>
> So I allowed to disable it, and gdb started working like a charm!

Is there any easy way to get decent ps output in SKAS0 mode?

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

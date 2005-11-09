Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZeie-0004p9-8e for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 17:25:44 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EZeib-0000zd-Uv
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 17:25:44 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Making UML Single Threader
References: <200511061723.32848.rob@landley.net>
	<200511090148.26628.blaisorblade@yahoo.it>
	<200511081917.22963.rob@landley.net>
In-Reply-To: <200511081917.22963.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511090231.57373.blaisorblade@yahoo.it>
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
Date: Wed, 9 Nov 2005 02:31:56 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Wednesday 09 November 2005 02:17, Rob Landley wrote:
> On Tuesday 08 November 2005 18:48, Blaisorblade wrote:
> > On Wednesday 09 November 2005 01:35, Rob Landley wrote:
> > > On Tuesday 08 November 2005 01:44, Can Sar wrote:
> > >
> > > P.S. What on earth is CONFIG_CMDLINE_ON_HOST?  It doesn't seem to ever
> > > be set anywhere, by anything...
> >
> > Totally unrelated. In short, it's TT-only, it implements the old
> > behaviour (nice output on ps), but it requires UML to call exec() on
> > itself (with a bigger arg list, so that enough space is allocated for
> > argv); and I discovered gdb gets very confused on this.
> >
> > So I allowed to disable it, and gdb started working like a charm!
>
> Is there any easy way to get decent ps output in SKAS0 mode?
No code. And I don't know exactly what's going on, so I must concentrate on 
bugfixes (say "How do I explain to every GCC on the world it can't use the 
stack as it's usual to do, without going to plain ASM, which would make 
things even worse?").
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

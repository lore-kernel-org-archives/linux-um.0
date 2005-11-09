Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZgUS-0000h2-Sl for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 19:19:12 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EZgUO-000287-UJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 19:19:10 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Making UML Single Threader
References: <200511061723.32848.rob@landley.net>
	<200511081917.22963.rob@landley.net>
	<200511090231.57373.blaisorblade@yahoo.it>
In-Reply-To: <200511090231.57373.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511082118.58614.rob@landley.net>
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
Date: Tue, 8 Nov 2005 21:18:58 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> > Is there any easy way to get decent ps output in SKAS0 mode?
>
> No code. And I don't know exactly what's going on, so I must concentrate on
> bugfixes (say "How do I explain to every GCC on the world it can't use the
> stack as it's usual to do, without going to plain ASM, which would make
> things even worse?").

I've been known to blow a weekend on cosmetic problems that annoy me, so:

1) Is there any documentation on SKAS0's design?  (A couple things floated by, 
but it was piecemeal and I didn't have the necessary context.)

2) What's the memory layout of the various SKAS0 threads?  (Or where in the 
code is it set up?  I can work this out for myself if necessary, it'll just 
take a while...)

3) What can -tt mode still do that -skas0 can't?  (Something about running 
under gdb, was it?)

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

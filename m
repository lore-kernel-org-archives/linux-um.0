Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DoU1l-0004wY-IH	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Jul 2005 15:30:29 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DoU1g-0001Yj-Nl	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Jul 2005 15:30:29 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] help on /include/asm-um/ptrace-i386.h
References: <838f7c500507011022240808cd@mail.gmail.com>
In-Reply-To: <838f7c500507011022240808cd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200507020036.08115.blaisorblade@yahoo.it>
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
Date: Sat, 2 Jul 2005 00:36:07 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net, ashwin tanugula <ashwin.tanugula@gmail.com>
Cc: user-mode-linux-user@lists.sourceforge.net

On Friday 01 July 2005 19:22, ashwin tanugula wrote:
> Hi,
> Can somebody explain to me the define statements in
> /include/asm-um/ptrace-i386.h file? I mean can somebody explain me how
> it was written.

> http://lxr.linux.no/source/include/asm-um/ptrace-i386.h
>
> Thanks,
> Ashwin
From a struct pt_regs, which in UML has a particular structure due to the =

existance of SKAS and TT modes, we must extract all those infos.

Those defines are simply wrappers from some UML names (applying to pt_regs)=
 to=20
UML internal names (applying to uml_pt_regs, which is a union whose=20
definition is known also by UML *_user.c and similar files).

Then, what's your doubt exactly?
--=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

=09

=09
	=09
___________________________________=20
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB=20
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lorenzo@google.com>) id 1ZywtR-0007q5-GE
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Nov 2015 07:11:01 +0000
Received: from mail-yk0-f180.google.com ([209.85.160.180])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZywtQ-0003kq-PW
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Nov 2015 07:11:01 +0000
Received: by ykdv3 with SMTP id v3so49104049ykd.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 Nov 2015 23:10:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <564C21FA.1010808@kot-begemot.co.uk>
References: <1446480997-155855-1-git-send-email-aivanov@brocade.com>
	<563D2217.1070002@nod.at>
	<CAKD1Yr29+9ZiG+ovhmpQE_Rm7Cp7u0sDDsN7fF6Co+y40cF3Gw@mail.gmail.com>
	<564C21FA.1010808@kot-begemot.co.uk>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Wed, 18 Nov 2015 16:10:35 +0900
Message-ID: <CAKD1Yr0uNgTk90J00URiaxaWgeDB6rxUA7+Osy1-macXz3dQ_Q@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH v4] um: Switch clocksource to hrtimers
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: Richard Weinberger <richard@nod.at>, Thomas Meyer <thomas@m3y3r.de>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Nov 18, 2015 at 4:00 PM, Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
> It is.
>
> You need -lrt to link in HR timers. However, the original patch should add
> that to the library list. I need to understand why it does not in the dm
> tree.

I noticed that command already does contain "-lrt", just in a
different place. It starts off with:

gcc -Wl,-rpath,/lib64 -m64 -Wl,-rpath,/lib -Wl,--wrap,malloc
-Wl,--wrap,free -Wl,--wrap,calloc -Wl,-m -Wl,elf_x86_64 -lrt <...>

That command line doesn't work, but if you remove the -lrt and put it
at the end of the line, it starts working. Is the order significant?
Or is it a bug in GCC's command line parsing?

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


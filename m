Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uJ2S-0004oG-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 02 Sep 2003 14:50:13 -0700
Received: from pisces.lunarpages.com ([64.235.234.123])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19uJ2S-0006kg-DS
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Sep 2003 14:50:12 -0700
Received: from adsl-63-205-197-100.dsl.scrm01.pacbell.net ([63.205.197.100] helo=nexxus)
	by pisces.lunarpages.com with smtp (Exim 4.20)
	id 19uJ2N-0007pS-D1
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Sep 2003 14:50:07 -0700
Message-ID: <002301c3719c$300de640$6401a8c0@nexxus>
From: "sean whalen" <swhalen@denature.org>
References: <000901c36eb4$20db7dd0$6401a8c0@nexxus>  <200309021850.h82Io5Hx001647@ccure.karaya.com>
Subject: Re: [uml-devel] uml trashes stdin 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 2 Sep 2003 14:50:09 -0700
To: user-mode-linux-devel@lists.sourceforge.net

2.5.70 is the latest which has a patch that applies cleanly and where the
kernel still compiles, that i have found.  if anyone has luck with a 2.5
series kernel/patch newer than this, pointers would be appreciated.

    -sean

----- Original Message ----- 
From: "Jeff Dike" <jdike@addtoit.com>
To: "sean whalen" <swhalen@denature.org>
Cc: <user-mode-linux-user@lists.sourceforge.net>;
<user-mode-linux-devel@lists.sourceforge.net>
Sent: Tuesday, September 02, 2003 11:50 AM
Subject: Re: [uml-devel] uml trashes stdin


> swhalen@denature.org said:
> > i'm running uml with a patched 2.5.70 kernel
>
> > i didn't see this in the archives, does anyone have any ideas?
>
> For starters, try running something more modern.
>
> Jeff
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

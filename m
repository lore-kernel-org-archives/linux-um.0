Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19woHl-00054s-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 12:36:21 -0700
Received: from gate.in-addr.de
	([212.8.193.158] helo=mx.in-addr.de ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19woHk-0000Rf-TE
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 09 Sep 2003 12:36:21 -0700
From: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [uml-devel] "Kernel panic: Segfault with no mm"
Message-ID: <20030909193437.GE10485@marowsky-bree.de>
References: <20030909180126.GC10485@marowsky-bree.de> <200309091914.h89JE6ja000983@car.linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <200309091914.h89JE6ja000983@car.linuxhacker.ru>
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
Date: Tue, 9 Sep 2003 21:34:37 +0200
Content-Transfer-Encoding: quoted-printable
To: Oleg Drokin <green@linuxhacker.ru>, user-mode-linux-devel@lists.sourceforge.net

On 2003-09-09T23:14:06,
   Oleg Drokin <green@linuxhacker.ru> said:

> LMB> #5  <signal handler called>
>=20
> This is signal kernel and one step up is your buggy code.
> You just need to go up to that point to see what's wrong.

Yes, I know that, too.

But on the host, I'd get a panic which said which kernel module caused
it etc. Is that not to be expected in UML?

If all kernel segvs in UML would lead to this, why is the
if (!is_user) ... branch in the segv() in trap_kern.c there anyway?

It looks like a kernel mode fault should also be handled differently,
and like the Segfault with no mm is sort of an exception.

Sorry if I'm wrong, but I am trying to understand what's going on ;-)


Sincerely,
    Lars Marowsky-Br=E9e <lmb@suse.de>

--=20
High Availability & Clustering		ever tried. ever failed. no matter.
SuSE Labs				try again. fail again. fail better.
Research & Development, SuSE Linux AG		-- Samuel Beckett



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

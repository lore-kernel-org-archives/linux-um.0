Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wzlH-0003MN-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 00:51:35 -0700
Received: from gate.in-addr.de
	([212.8.193.158] helo=mx.in-addr.de ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wzlF-000472-Fg
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 10 Sep 2003 00:51:33 -0700
From: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [uml-devel] "Kernel panic: Segfault with no mm"
Message-ID: <20030910074915.GJ10485@marowsky-bree.de>
References: <20030909180126.GC10485@marowsky-bree.de> <200309091914.h89JE6ja000983@car.linuxhacker.ru> <20030909193437.GE10485@marowsky-bree.de> <200309092233.h89MXO2J005300@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <200309092233.h89MXO2J005300@ccure.karaya.com>
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
Date: Wed, 10 Sep 2003 09:49:15 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

On 2003-09-09T18:33:24,
   Jeff Dike <jdike@addtoit.com> said:

> > But on the host, I'd get a panic which said which kernel module
> > caused it etc. Is that not to be expected in UML?=20
> UML is lacking some of the debugging stuff present in the other ports.
> No big problem to add, but I haven't seen any pressing need for it.

Ah, ok, so all is well. I was just wondering about the strange panic.

Thanks.


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

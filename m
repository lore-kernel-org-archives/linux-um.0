Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQaB9-0003d8-35 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 16:08:51 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BQaB8-00054v-Kn
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 16:08:50 -0700
Message-Id: <200405192354.i4JNsJDt001917@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] host context switch reduction 
In-Reply-To: Your message of "Wed, 19 May 2004 20:17:43 +0200."
	<1084990661.2255.28.camel@chartreuse> 
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
	<02dc01c43c4a$bb7c0490$2000000a@schlepptopp>
	<1084831251.1230.4.camel@chartreuse>
	<03ff01c43c5d$7db6e5e0$2000000a@schlepptopp>
	<20040518175904.GB29114@ccure.user-mode-linux.org>
	<1084987654.2250.4.camel@chartreuse>
	<012201c43dcb$402ca6a0$2000000a@schlepptopp>
	<1084990661.2255.28.camel@chartreuse> 
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 19 May 2004 19:54:19 -0400
Content-Transfer-Encoding: quoted-printable
To: Laurent Vivier <LaurentVivier@wanadoo.fr>
Cc: roland <for_spam@gmx.de>, user-mode-linux-devel@lists.sourceforge.net

LaurentVivier@wanadoo.fr said:
> Le mer 19/05/2004 =C3=A0 20:01, roland a =C3=A9crit :
> > since this would be the 2nd patch for the HOST (besides skas), would
> > it make sense, to merge "skas" and "sysemu" into one common
> > HOST-patch (if it has been tested and approved stable) ?
>
> YES, I think... but Jeff is the boss ;-)=20

Sometimes I wish I were less the boss.  There is absolutely nothing=20
preventing anyone from repackaging, porting, etc patches, and I wish people
were doing more of it.

That would make UML more useful for more people on more systems, and would
lessen my workload some.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g.=20
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id149&alloc_id=8166&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

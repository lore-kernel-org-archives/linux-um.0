Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hru2s-0001XC-7V for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 May 2007 04:02:50 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Hru2i-0000vX-Rn
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 May 2007 04:02:47 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 26 May 2007 13:02:29 +0200
References: <20070524092904.GB3768@sparc20.esperanza>
In-Reply-To: <20070524092904.GB3768@sparc20.esperanza>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200705261302.29761.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] fix SEGV in handle_page_fault() when current->mm is
	NULL
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
Cc: "Nicolas S. Dade" <n-dade@nsd.dyndns.org>

On gioved=EC 24 maggio 2007, Nicolas S. Dade wrote:
> In a non-uml kernel a get_user() when current->mm is NULL (kernel thread,
> or userspace process being torn down) returns error. In uml it SEGVs. The
> bug is that handle_page_fault() does not check for NULL before using mm.
> The trivial attached patch fixes this.
>
> -Nicolas Dade

Acked-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

--=20
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


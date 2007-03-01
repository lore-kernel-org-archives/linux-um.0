Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMvAH-0005vF-60 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 15:58:30 -0800
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HMvAF-00043K-Gg
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 15:58:25 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Fri, 2 Mar 2007 00:58:10 +0100
References: <E1HMdXC-0007w3-Ac@teori.refactor.fi>
In-Reply-To: <E1HMdXC-0007w3-Ac@teori.refactor.fi>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703020058.11168.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] fix misleading error message in
	tools/tunctl/tunctl.c
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
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Leonard =?iso-8859-1?q?Norrg=E5rd?= <vinsci@refactor.fi>

On Thursday 01 March 2007 06:08, Leonard Norrg=E5rd wrote:
> Fix misleading error message.
>
> Signed-off-by: Leonard Norrgard <vinsci@refactor.fi>
>
> Index: tunctl/tunctl.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/user-mode-linux/tools/tunctl/tunctl.c,v
> retrieving revision 1.4
> diff -u -r1.4 tunctl.c
> --- tunctl/tunctl.c	2 Nov 2002 19:34:19 -0000	1.4
> +++ tunctl/tunctl.c	1 Mar 2007 05:04:58 -0000
> @@ -101,7 +101,7 @@
>        exit(1);
>      }
>      if(ioctl(tap_fd, TUNSETOWNER, owner) < 0){
> -      perror("TUNSETPERSIST");
> +      perror("TUNSETOWNER");
>        exit(1);
>      }
>      if(brief)
>

Applied in my tree, thanks.
-- =

Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! =

 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com =



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

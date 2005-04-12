Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DLP8I-0002cQ-Qo for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2005 10:25:02 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DLP8F-00033H-LJ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2005 10:25:02 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] guest performance
References: <000501c53f6d$3b936df0$0201a8c0@lualele>
In-Reply-To: <000501c53f6d$3b936df0$0201a8c0@lualele>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Disposition: inline
Message-Id: <200504121932.31338.blaisorblade@yahoo.it>
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
Date: Tue, 12 Apr 2005 19:32:31 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: itamar <itamar@ispbrasil.com.br>, uml-user <user-mode-linux-user@lists.sourceforge.net>

On Tuesday 12 April 2005 16:37, itamar wrote:
> How to make a guest machine running more fast ?
>
>
> CONFIG_BLK_DEV_UBD_SYNC =3DY or CONFIG_BLK_DEV_UBD_SYNC=3DN
The second is surely faster but less safe.
> What=B4s the best for a uml provider ?
For recent (IIRC >=3D 2.6.9, at least) the difference of performance is=20
acceptable; however, in case of a host crash (a guest crash shouldn't creat=
e=20
a problem), with the second one you would get big problems on guest reboot =

(especially if you use journaled filesystems, especially like reiserfs,=20
because they want to be able to force datas out on the disk).
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_ide95&alloc_id=14396&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

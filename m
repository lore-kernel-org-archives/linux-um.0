Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dcb314@hotmail.com>) id 1ZEZim-0006g6-SP
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 09:08:20 +0000
Received: from dub004-omc3s18.hotmail.com ([157.55.2.27])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZEZim-0005rT-3c
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 09:08:20 +0000
Message-ID: <DUB128-W4287C49CC298A43BB8A3409C9C0@phx.gbl>
From: David Binderman <dcb314@hotmail.com>
Date: Mon, 13 Jul 2015 09:08:13 +0000
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] linux-4.2-rc2/arch/um/drivers/net_user.c:258: possible
 missing call to va_end ?
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Hello there,

[linux-4.2-rc2/arch/um/drivers/net_user.c:258]: (error) va_list 'ap' was op=
ened but not closed by va_end().

Source code is

=A0=A0=A0 va_start(ap, str);
=A0=A0=A0 while ((arg =3D va_arg(ap, char **)) !=3D NULL) {
=A0=A0=A0=A0=A0=A0=A0 if (*str =3D=3D '\0')
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NULL;
=A0=A0=A0=A0=A0=A0=A0 end =3D strchr(str, ',');
=A0=A0=A0=A0=A0=A0=A0 if (end !=3D str)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *arg =3D str;
=A0=A0=A0=A0=A0=A0=A0 if (end =3D=3D NULL)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NULL;
=A0=A0=A0=A0=A0=A0=A0 *end++ =3D '\0';
=A0=A0=A0=A0=A0=A0=A0 str =3D end;
=A0=A0=A0 }
=A0=A0=A0 va_end(ap);
=A0=A0=A0 return str;

If va_end needs to be called for successful return, it probably also
needs to be called for NULL return (twice).

Regards

David Binderman

 		 	   		  =

---------------------------------------------------------------------------=
---
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


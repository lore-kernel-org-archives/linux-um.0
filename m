Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ENvLY-0000fu-IE	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 09:45:24 -0700
Received: from mail.grupocentroclinico.com.br ([200.215.220.2])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ENvLV-0004G5-IQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 09:45:24 -0700
Received: from [192.168.1.254] (unknown [192.168.1.254])
	by mail.grupocentroclinico.com.br (Postfix) with ESMTP id 66AA0F67B
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri,  7 Oct 2005 14:20:56 -0300 (BRT)
Message-ID: <43467BEE.7000503@gmail.com>
From: Alan Menegotto <macnish@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] 2.6.13-bs3 amd64 compilation broken?
References: <1128695313.15932.30.camel@localhost.localdomain>
In-Reply-To: <1128695313.15932.30.camel@localhost.localdomain>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
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
Date: Fri, 07 Oct 2005 10:45:18 -0300
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Antoine Martin wrote:

>I tried twice to be sure, but compile fails near the end:
>
> CC      arch/um/sys-x86_64/stub_segv.o
>arch/um/sys-x86_64/stub_segv.c: In function `stub_segv_handler':
>arch/um/sys-x86_64/stub_segv.c:41: warning: implicit declaration of
>function `container_of'
>arch/um/sys-x86_64/stub_segv.c:41: error: parse error before "struct"
>make[1]: *** [arch/um/sys-x86_64/stub_segv.o] Error 1
>make: *** [arch/um/sys-x86_64] Error 2
>
>Antoine
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by:
>Power Architecture Resource Center: Free content, downloads, discussions,
>and more. http://solutions.newsforge.com/ibmarch.tmpl
>_______________________________________________
>User-mode-linux-devel mailing list
>User-mode-linux-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>
> =20
>
I've got no such errors compiling 2.6.13-bs9 (probably one version=20
further, I'm not sure about the version). Try the latest 'bs patch' and=20
the latest vanilla kernel version (2.6.13-3) and the error should be gone.

--=20
Sauda=E7=F5es

Alan Menegotto
Depto de Inform=E1tica
Grupo Centro Cl=EDnico
Fone: (51) 3287-9234



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

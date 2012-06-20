Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1ShSJk-0006cj-9J
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jun 2012 21:20:00 +0000
Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ShSJj-0002MA-IY
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jun 2012 21:20:00 +0000
Received: by lbol5 with SMTP id l5so1299722lbo.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 20 Jun 2012 14:19:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FDB6EDD.1010102@gmail.com>
References: <4FDB6EDD.1010102@gmail.com>
Date: Wed, 20 Jun 2012 23:19:52 +0200
Message-ID: <CAFLxGvxtN8wdP7g1jowqpAFbewATmTo8ZOWgPkZ6CrFYVQvXtQ@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] [PATCH v2] um: pass siginfo to guest process
To: =?ISO-8859-1?Q?Martin_P=E4rtel?= <martin.partel@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Jun 15, 2012 at 7:20 PM, Martin P=E4rtel <martin.partel@gmail.com> =
wrote:
> UML guest processes now get correct siginfo_t for SIGTRAP, SIGFPE,
> SIGILL and SIGBUS. Specifically, si_addr and si_code are now correct
> where previously they were si_addr =3D NULL and si_code =3D 128.
>
> Signed-off-by: Martin P=E4rtel <martin.partel@gmail.com>

Do we really need the _ignore_siginfo wrappers?
Can't you add siginto to all handlers (where it's needed) and
set it to NULL if the information is not available/used.

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


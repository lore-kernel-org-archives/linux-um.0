Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zgom-0006vz-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 11:14:20 -0700
Received: from smtp013.mail.yahoo.com ([216.136.173.57])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19zgol-0005lm-R5
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 11:14:19 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] hostfs as root
References: <26716.1062787141@marajade.sandelman.ottawa.on.ca>
In-Reply-To: <26716.1062787141@marajade.sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200309171843.49052.blaisorblade_spam@yahoo.it>
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
Date: Wed, 17 Sep 2003 18:43:49 +0200
Content-Transfer-Encoding: quoted-printable
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 20:39, venerd=EC 5 settembre 2003, Michael Richardson ha scritto:

>     >> If you have a simple /sbin/mount that you can recommend that solves
>     >> my problem, I will consider using it.
>
>     Matt> The fact that you said it broke _potato_'s mount, specifically,
> led Matt> me to believe that newer versions did not do this (they do).
>
>   Ah, so your fix basically breaks all distros? I have no idea.
>   Then clearly it needs to be fixed in the kernel, don't you think?
>
>     Matt> However, the fix to mount is trivial, so you can easily create =
an
>     Matt> /sbin/mount which should work.
>
>   I think that removing your patch is a better idea. Find another way to
> make tar happy.
>
>   Booting the system is pretty important.
I think that since anyway there is not a permission layer, you shouldn't bo=
ot=20
off an hostfs filesystem. Mount with -o loop a new file, then copy all the =

filesystem content. Or maybe(but ask to other developers/check docs) if you=
=20
have a whole partition, say ubd0=3D/dev/<your part> to UML. With hostfs,=20
anyway, if you don't run the guest with root privileges, files created by=20
root will be owned by the user running the Uml(i.e. it can happen that=20
everything works, especially if you login in the Uml only with a uid=3D<uid=
 of=20
Uml on the host>, but not everything will work), while root won't have acce=
ss=20
to certain files(you can avoid also this, by not putting in that hierarchy =

any file of root from the host).

--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

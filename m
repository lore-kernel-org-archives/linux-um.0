Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AY5S6-0007I8-DN
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 07:25:06 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AY5S4-0007C4-TC
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 07:25:05 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [patch] host-skas support for 2.6.0, other UML fixes
References: <Pine.LNX.4.58.0312171735540.8123@earth> <Pine.LNX.4.58.0312181209230.1327@earth> <Pine.LNX.4.58.0312181253460.2378@earth>
In-Reply-To: <Pine.LNX.4.58.0312181253460.2378@earth>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312201710.14249.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 20 Dec 2003 17:10:14 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 12:56, gioved=EC 18 dicembre 2003, Ingo Molnar ha scritto:

> To 'replicate' an existing tree, i use the following method:
>
> 	cd linux-host
> 	make mrproper
> 	cd ..
> 	cp -rl linux-host linux-UML

> this creates a hard-linked clone of the kernel tree. Now the linux-host
> kernel and the linux-UML kernels can be configured & compiled
> independently.
Since some time(a very little one) the build directory can be distinct from=
=20
the source one; wouldn't this feature be fine for this purpose, with two=20
different build dirs?

> Any change to an existing source file in one tree will
> affect the other tree too.

For users(Ingo knows this, obviously): note that this is not true with patc=
h:=20
when you patch one tree, the other tree remains unpatched. This happens sin=
ce=20
patch doesn't modify a file, but replaces it with another file(which is no =

more an hard link) containing the new version.

Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

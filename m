Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AMuZ9-0007yq-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 11:34:11 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AMuYz-0002f0-11
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 20 Nov 2003 11:34:01 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Host panic when UML reads host /dev/shm
References: <200311201915.29188.blaisorblade_spam@yahoo.it> <200311201956.39623.Frank.dekervel@student.kuleuven.ac.Be>
In-Reply-To: <200311201956.39623.Frank.dekervel@student.kuleuven.ac.Be>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200311202037.14480.blaisorblade_spam@yahoo.it>
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
Date: Thu, 20 Nov 2003 20:37:14 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 19:56, gioved=EC 20 novembre 2003, Frank Dekervel ha scritto:
> Op Thursday 20 November 2003 19:15, schreef BlaisorBlade:
> > I reported that if I leave an UML sleeping, it segfaults(once I saw the
> > killed by SIGSEGV from the shell, the other time nothing, maybe I had
> > detached the job from the shell).
> >
> > Now I've seen that what happens is that the host kernel oopses. I'm
> > posting it here to collect a bit more infos before posting it to the
> > LKML, and to know why only UML is able to trigger it. Since the bug see=
ms
> > related only to /dev/shm, maybe you could have some enlightenment about
> > it and how UML uses shared memory to make this happen.
>
> i saw the same crash.
Only an oops on linux or the same oops? If the second, it's useful news
> i worked around it by not using hostfs ...
So, probably there was a process runned from inside UML triggering the bug.

In fact, I'm seeing now 4:40, the time the oops happens, is when the slackw=
are=20
every day runs updatedb.

A little transcript from a UML session:

root [~: slack90: 1 (0)] # mount
/dev/ubda on / type ext3 (rw)
devpts on /dev/pts type devpts (rw,gid=3D5,mode=3D620)
proc on /proc type proc (rw)
host on /mnt/host type hostfs (rw,/)
root [~: slack90: 1 (0)] # ls /mnt/host/dev/sh
sheep_net  shm        shmiq
root [~: slack90: 1 (0)] # ls /mnt/host/dev/shm
<Pause because of the same host kernel oops.>

The host shell reported Segmentation fault(wrongly), so all the crashes I h=
ad=20
were due to this. I can even get the processes in D state(even a ls /dev/sh=
m=20
suffices).

Thanks, Frank. Your message was very useful and enlightening.

I think hostfs reads files just as any normal process on the host, right? O=
r=20
it does anything special or at least unusual?

Could the unusual thing be the context switching of SKAS?
I'll test if it happens within TT mode. Jeff, this seems easy reproduceable=
,=20
so try it, please.

Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

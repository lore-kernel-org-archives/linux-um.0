Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AeeZd-0003xx-GL for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Jan 2004 10:08:01 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AeeZc-0005Wt-Ta for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Jan 2004 10:08:01 -0800
From: BlaisorBlade <blaisorblade_work@yahoo.it>
Subject: Re: [uml-devel] Re: [kbuild-devel] Needed help for UML kbuild.
References: <200312242019.23335.blaisorblade_work@yahoo.it>
	<200401072012.05007.blaisorblade_work@yahoo.it>
	<200401080019.i080JOtd008375@ccure.user-mode-linux.org>
In-Reply-To: <200401080019.i080JOtd008375@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200401081907.56198.blaisorblade_work@yahoo.it>
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
Date: Thu, 8 Jan 2004 19:07:56 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 01:19, gioved=EC 8 gennaio 2004, Jeff Dike ha scritto:
> blaisorblade_work@yahoo.it said:
> > some modules(i.e. hostaudio) are built from a "userspace" (needing the
> > special  treatment) file and a "kernel" (to be compiled as usual)
> > file. How will  kbuild link them together?
> >
> > I have three workarounds:

> > - split the module into 2 separate ones, with the kernel one requiring
> > the other. BUT a lot of EXPORT_SYMBOLS should be added (one for each
> > function inside the userspace file at least)

> So, rather than have a module consisting of a userspace chunk and a kernel
> chunk needing to be turned into a single .o, I would rather look at having
> two modules, with the userspace piece plugging into an interface in the
> kernel piece.

> This is what I've envisioned for hostfs for a long time.  You don't need =
to
> stick host files underneath hostfs files - you can stick other host
> resources under them, and the way to do that is to have multiple hostfs
> userspace modules which plug into an interface in the hostfs kernel piece,
> each of which provides access to a different sort of host resource.

No idea about this hostfs feature - apart the fact it can be something good=
 to=20
have (I don't yet see samples but this can be my fault; if you have any=20
specific one I'd like it). However, I don't think this is needed for all=20
modules. However, this can be delayed to after (or at least, I'd like to=20
implement it, after having some other "host resource" to manage). For now, =
I=20
would split the modules into two parts and add needed EXPORT_SYMBOL's. It's=
=20
worth noting that while in 2.4 a module exports all symbols, in 2.6 symbols=
=20
must be exported explicitly.

**So: would you merge this patch?**
If yes, can I be smart about files to just move? (Shipping a list of mv=20
commands would be ok?)
Also, the *_user.c (+ the other user-objs) should go under under=20
os-Linux/{drivers, kernel, kernel/tt, kernel/skas} ..., right?

The other modules I found in UML 2.6, for which I don't see an obvious reas=
on=20
to use a "register_xxx" thing, are:
-hostaudio
-the watchdogs (what are they?)
-hppfs
-cow (but why tristate? Maybe related to the standalone cow device, that I =

have not understood).
-Example IO memory driver.

--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

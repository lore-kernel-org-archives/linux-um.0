Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AX3qJ-00060g-Ni
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 11:29:51 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AX3qJ-0007qh-5b
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 11:29:51 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH]Modules support in 2.6: reaching the complete fix
References: <200312131828.03645.blaisorblade_spam@yahoo.it> <200312171851.18353.blaisorblade_spam@yahoo.it> <200312180119.hBI1JBkS008102@ccure.user-mode-linux.org>
In-Reply-To: <200312180119.hBI1JBkS008102@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312182032.50394.blaisorblade_spam@yahoo.it>
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
Date: Thu, 18 Dec 2003 20:32:50 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 02:19, gioved=EC 18 dicembre 2003, Jeff Dike ha scritto:
> blaisorblade_spam@yahoo.it said:
> > If not, I can just patch this way scripts/Makefile.lib:
>
> This seems promising.  Can the new infrastructure be put in
> arch/um/Makefile?

I'm going to check... the variables are all set with =3D so it should work,=
 but=20
my problem is that it seems that the arch/um/Makefile is not included when =
it=20
descends in sub-directories. However, even if it CAN be put there, I think =

this should NOT happen, and that it should be cleaned enough to be accepted=
=20
in mainline. Why?
I think that it should have to be tuned for each release, and would not be =

likely to always be tunable(i.e. it could have to be re-engeneered if they =

change Makefile.lib enough). I don't use in fact an external interface of=20
KBUILD, but I mingle inside its implementation(i.e. I violate encapsulation=
).

> This would isolate it nicely to UML since it's the only arch which needs
> it.

> Although, thinking about this some more, this isn't the right way to do it
> in the long run.  Ultimately, the userspace stuff will be confined to
> arch/um/os, along with the userspace CFLAGS.  So, the arch/um/os/Makefile
> will contain this nonsense, and nothing outside there will have to worry
> about it.

> So, if you want to sign up to a longer project, you might start moving the
> userspace stuff into arch/um/os-Linux instead of trying to fix the build.

I don't agree for "instead". I.e. I think that as the first thing this must=
 be=20
fixed, and then we will go hunting the bug for MODVERSIONS(it needs that we=
=20
post-process userspace files).
After this, then I could do this user space change(I can't promise for now =
but=20
I hope I'll be able); but it is a bit problematical because KBUILD isn't=20
built to link objects from different directories.
Obviously I work for 2.6, not 2.4: clean-ups like this don't need duplicate=
d=20
effort. (And 2.6 is much more fun than 2.4, since it's all better).

Could symlink be accepted as a solution for this(i.e. a symlink from=20
drivers/hostaudio_user.c to some file inside the os/ directory)?

In this case, the fix I'm writing is needed anyway and probably won't even =

need to be changed.

I'm now going to fix the various Makefiles and post the complete fix, since=
 it=20
it at least promising.

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

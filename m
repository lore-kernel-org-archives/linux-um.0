Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYsCB-0006Ev-9p
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 23 Dec 2003 11:27:55 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AYsCA-0006be-K9
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 23 Dec 2003 11:27:54 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH]Modules support in 2.6: reaching the complete fix
References: <200312131828.03645.blaisorblade_spam@yahoo.it> <20031218221357.GD4090@ccure.user-mode-linux.org> <200312192051.32244.blaisorblade_spam@yahoo.it>
In-Reply-To: <200312192051.32244.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200312232031.45301.blaisorblade_spam@yahoo.it>
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
Date: Tue, 23 Dec 2003 20:31:45 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:51, venerd=EC 19 dicembre 2003, BlaisorBlade ha scritto:
> > > I'm going to check... the variables are all set with =3D so it should
> > > work, but my problem is that it seems that the arch/um/Makefile is not
> > > included when it descends in sub-directories.
> >
> > Hummm, so all the state that's set up by the arch Makefile is made
> > available in environment variables to the subdir makes?  That's
> > inconvenient.
>
> No, I'm saying the opposite; I haven't had the time to check, but the iss=
ue
> I'm afraid of is that the variables I set in the arch/um/Makefile are not
> visible when used from scripts/Makefile.build(i.e. when descending in
> subdirs); in that case(i.e. they are not visible) the fix must go into
> scripts/Makefile.lib.

Now I've checked; what is used from arch/um/Makefile when recursing is only=
=20
what it exports.

But that will be overriden by redefinition in each sub-make, if we speak ab=
out=20
things as c_flags; also, it seems to me that I'll have to move even the lin=
es=20
about UML_USER_OBJS and UML_USER_SINGLE_OBJS so on(the new name I gave to=20
USER_OBJS, to avoid conflicts) inside Makefile.lib;
what I can experiment is that when I export a variable, its content is=20
expanded, even if it is a '=3D' variable rather than a ':=3D' var. I haven'=
t=20
found this inside make docs, so I may be wrong; but I've done a little test=
=20
with the real Makefiles(details at request, this mail is just too long).

By the way: are you aiming to get an up-to-date UML into 2.6.1/.2?
I'm going to try shortly to get soon the patch reviewed by Kbuild developer=
s,=20
so that the patch is accepted by them, or they find a better way to handle =

this.

> Note that it's only from a design point of view: I'll have to debug it
> more, since it stopped kernel compilation at the point of compiling
> scripts/empty.c(which is listed in "always").
Fixed this, just a silly typo; now I've almost succeeded in compiling a who=
le=20
UML kernel with this, and I'm going to put all my patches on the web.

The only problem is that there are some files not in UML ending in _user.c:=
=20
i.e. fs/ext[23]/xattr_user.c, for now.
I'm trying to fix this, but it's not straightforward; my idea is using only=
=20
files whose path starts with  arch/um, but it's not a 1 sec. fix, especiall=
y=20
because I'm doing a lot of things at the very moment.
However, my patches can now be found at:

http://web.tiscali.it/no-redirect-tiscali/blaisorblade/linux/archives/UML/v=
1/index.html

They must be applied in order to the UML patch against the -test9 patch and=
=20
the 2.6.0 kernel. They just fix Makefiles and module building. For now,=20
disable extended attributes on ext2/ext3, since it triggers the build probl=
em=20
about xattr_user.c; use the align fix as needed. I've uploaded the files ve=
ry=20
quickly, so the files themself are ok(works for me), but nothing is ok in t=
he=20
"website".
(Sorry for the HTML index, but the hosting doesn't like a plain .htaccess, =

though they use Apache).

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

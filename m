Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACOMH-00057z-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 22 Oct 2003 12:09:25 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1ACNe0-0004eg-7M
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 22 Oct 2003 11:23:40 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Exactly what is wanted with hostfs UID/GID operation
References: <3F8B2B6E.30709@easyco.com>
In-Reply-To: <3F8B2B6E.30709@easyco.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200310221954.35229.blaisorblade_spam@yahoo.it>
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
Date: Wed, 22 Oct 2003 19:54:34 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Doug Dumitru <doug@easyco.com>

Alle 00:47, marted=EC 14 ottobre 2003, Doug Dumitru ha scritto:
> There have been a number of messages dancing around regarding
> UID/GID/permissions with hostfs.
[...] Ok, now I understood very well what you are doing.
>
>  From my point of view, there are five options here.
>
> 1.  Leave the hostfs UID/GID mappings as is (ie. broken).  They are good
> enough to store files and boot from, although some applications seems to
> complain.
Not to boot from(there are problems about this+workarounds floating).
> 2.  Do a patch like I have the keeps the UID/GID "correct" thru to the
> host assuming that UML is running as root.  This is a bit of a security
> risk for "untrusted" UML situations such as "mass hosting" (which is
> part of what we do).
> 3.  Do patch #2 so that UML is setuid root.  This is a very small amount
>   better in the security department than #2, but still has a lot of
> potential "holes".

Do this. But it's not a fix for hostfs that required root UID/GID, it shoul=
d=20
be rather a fix for when you run it as root. I.e., even if you use option 5=
,=20
you still need to be careful about permissions on the host. Letting an=20
unpriviledged UML user create a root-owned file on the host is not good. Ye=
s,=20
hostfs isn't something to trust, but anyway making it more secure isn't bad.

But the patch:
1) must not change anything when UML is not run as root

2) when Uml is run as root, it must also change the umask, with that of the=
=20
current process(at least for open and creat), and also call setgroups(see=20
below).

3) must be clean: i.e. the io calls must be surrounded by=20
functions/inlines/macros, not by the actual calls. I think that it can be=20
done easily "setuid-cleanly". Or better, the more work is for the not-setui=
d=20
case, where you must set explicitly the saved UID/GID.

4) you speak, for the SMP case, about "static data". This seems to mean you=
're=20
writing it badly.

Just add some more params to the hostfs_user relevant functions. Or better,=
 to=20
avoid modifying all those params, add(inside hostfs_user) the function whic=
h=20
calls sete[ug]id + umask, taking the right params, and then call them from =

hostfs_kern in the right points(i.e., read, write and close shouldn't need =

this, but open does, if I'm not missing something great).

5) What's more, once you creat() files with right permissions and IDs, then=
=20
there shouldn't be the need to do the seteuid calls. This because UML VFS=20
already checked permissions.

6) There is also another issue: supplementary GIDs. I.e. a file with g+w an=
d=20
GID 103, a process with 103 as supplementary group ID, might not be able to=
=20
open the file with O_WRONLY/O_RDWR if you don't call setgroups, too(open on=
=20
an existing file shouldn't need the ID changes, see my point 5).
>
>
> 4.  Do patch #2 and build a "helper" process that is root than mangles
> file ownership externally.  This is probably much harder to breach but
> might be a bit of a performance bottleneck.  Implementation wise, it
> would just be a pair of pipes and an RPC across them to do the actual IO
> operations.
Wouldn't this have race conditions? I.e. here you have a moment were the fi=
le=20
is created and has not get the appropriate permissions. Then, to be atomic =

inside UML, you'd probably need to lock the whole UML kernel(since any task=
=20
could try accessing the file) and wait the helper has done its work. So, th=
is=20
isn't very good. And on the host you can try to use that file(while it's=20
owned by root) for an exploit(how to do it, but if a file was created by th=
e=20
admin then it's more trustable).

I agree that it's probably harder to breach than UML running as root, but=20
still weaker than the #5 option.
>
> 5.  Build a "mapping layer" that stores the UID/GID external to the
> files themselves.  This is what some people are talking about.  There
> are a whole slew of ways to implement this, but I would vote for
> simplicity and "minimal prerequisites" over performance.  A parellel set
> of directories with text files containing the UID/GID would be one
> approach.  I would vote against anything that requires a formal database
> setup even though that would outperform other options.
UMSDOS already exists(but better wait for 2.6 one, since the 2.4 one just u=
ses=20
8.3 host names). Let they think to performance and then use it.
>
> Everything here except for #2/#3 has SMP ramifications.  I think that
> just seteuid/setegid will work SMP pretty much as is in that each thread
> in SMP can change independently.

You have different threads/processes inside UML, but they are mapped on few=
er=20
ones on the host. This, with 2.6 preemption, will mean you need to disable =

preemption on hostfs:
a process could be preempted after having changed id, then a 2nd proc tries=
 to=20
change to another id and maybe get a refusal or looses priviledges, i.e.=20
cannot any more turn back to root id(see the real/effective/file saved ids =

semantics, I'm not checking here). But then, the 1st process is preempted=20
back and creates the file with the wrong id.

>  You have to be careful how you
> transition down UID/GID structs (statics are bad) but this is probably
> doable.
> I am not personally running UML SMP so I don't have a lot of
> experience here (it is just too convenient to be single-threaded).
>
> I am looking for some discussion here before I start up a formal patch
> set, so any input would be appreciated.
>
> --------------------------------------------------------------------
> Doug Dumitru     800-470-2756     (610-237-2000)
Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN




-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

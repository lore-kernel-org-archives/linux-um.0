Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zgor-0006wU-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 11:14:25 -0700
Received: from smtp013.mail.yahoo.com ([216.136.173.57])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19zgor-0005mw-0C
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 11:14:25 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] compile error ...(now tracked down)
References: <200309161329.39725.user-mode-linux-devel@goldenspud.com>
In-Reply-To: <200309161329.39725.user-mode-linux-devel@goldenspud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200309171329.57323.blaisorblade_spam@yahoo.it>
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
Date: Wed, 17 Sep 2003 13:29:57 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:29, marted=EC 16 settembre 2003, Matthew R. Scott ha scritto:

> With both of these patches I am getting the following error during compil=
e:
I use the headers from glibc-devel-2.3.1-10mdk(from mandrake 9.1) and I get=
=20
the same errors. Supposed that the patch compiles well somewhere else, it's=
=20
something changed with glibc from the system of who released the patch. See=
=20
below, especially where the code snippets speak about backward compatibilit=
y.

> In file included from umid.c:18:
> /home/gldnspud/uml/build/buildkernel-build/linux/arch/um/include/os.h:41:
> warning: no semicolon at end of struct or union
> /home/gldnspud/uml/build/buildkernel-build/linux/arch/um/include/os.h:41:
> parse error before `.'
> /home/gldnspud/uml/build/buildkernel-build/linux/arch/um/include/os.h:42:
> parse error before `.'
> /home/gldnspud/uml/build/buildkernel-build/linux/arch/um/include/os.h:43:
> parse error before `.'
>
> When I look at line 41, 42, and 43 in arch/um/include/os.h though, there
> doesn't seem to be any sort of problems.  Those lines are in the middle of
> a perfectly valid-looking struct.

I agree, but cd to that folder and rerun the exact gcc command, replacing -=
c=20
-o umid.o with -E(to preprocess only the file), then use less(the=20
preprocessed output is sent to stdout). On about line 5295(on me, look well=
),=20
you can see that those line, because of a preprocessor #define, get turned =

into something else. The os.h file is good, but in umid.c it's included aft=
er=20
sys/stat.h(which is the glibc one!). It then includes in turn bits/stat.h:

#ifdef __USE_MISC				=09
# define st_atime st_atim.tv_sec        /* Backward compatibility.  */
# define st_mtime st_mtim.tv_sec
# define st_ctime st_ctim.tv_sec
...
__USE_MISC comes from features.h; if you define __BSD_SOURCE(to choose this=
=20
dialect of Unix) it gets defined; if you don't define anything, it comes up=
=20
automatically. Anyway we need it in the code below.

I've given this command inside arch/um to find what includes both os.h and =

sys/stat.h
# grep 'os\.h\"' $(grep 'sys/stat\.h' `find . -name '*.[ch]'` -l)
./drivers/chan_user.c:#include "os.h"
./os-Linux/file.c:#include "os.h"
./kernel/umid.c:#include "os.h"
./kernel/initrd_user.c:#include "os.h"

I've tried #undefining them, but they are needed somewhere else(in file.c),=
 so=20
I've simply swapped the order of the two includes(so that os.h is included =

with those define's not in place). And yet, it doesn't compile. It stops on=
=20
file.c.

This is the offending code(which was absent from the cleanup of -4um):
static void copy_stat(struct uml_stat* dst, struct stat64* src)
{
        *dst=3D((struct uml_stat) {
                .st_dev     =3D src->st_dev,     /* device */
                .st_ino     =3D src->st_ino,     /* inode */
                .st_mode    =3D src->st_mode,    /* protection */
                .st_nlink   =3D src->st_nlink,   /* number of hard links */
                .st_uid     =3D src->st_uid,     /* user ID of owner */
                .st_gid     =3D src->st_gid,     /* group ID of owner */
                .st_size    =3D src->st_size,    /* total size, in bytes */
                .st_blksize =3D src->st_blksize, /* blocksize for filesys I=
/O */
                .st_blocks  =3D src->st_blocks,  /* number of blocks alloca=
ted=20
*/
                .st_atime   =3D src->st_atime,   /* time of last access */
                .st_mtime   =3D src->st_mtime,   /* time of last modificati=
on */
                .st_ctime   =3D src->st_ctime,   /* time of last change */
        });
}

As you can see, on the same line it needs that st_{a,m,c}time is its litera=
l=20
value on the right and the original vaue on the left. I am available to=20
anyone who wants to fix the bug with help, actual hacking and whatever, but=
=20
I'm not starting because I don't know how... if I #undef the things, then I=
=20
need to patch the above function to use directly st_atim.tv_sec, and then=20
maybe things won't work on systems where they worked before.
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

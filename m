Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zgov-0006x0-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 11:14:29 -0700
Received: from smtp013.mail.yahoo.com ([216.136.173.57])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19zgou-0005nt-NO
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 11:14:28 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Starting a command inside UML from mconsole
References: <200309131820.45833.blaisorblade_spam@yahoo.it> <200309162027.22242.blaisorblade_spam@yahoo.it>
In-Reply-To: <200309162027.22242.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CxJa/ZjE6GY0tch"
Message-Id: <200309171939.14384.blaisorblade_spam@yahoo.it>
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
Date: Wed, 17 Sep 2003 19:39:14 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jeff@blaisorblade



--Boundary-00=_CxJa/ZjE6GY0tch
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alle 20:27, marted=EC 16 settembre 2003, BlaisorBlade ha scritto:
> Hi, I have finally some working code. I've cleaned it up and it works qui=
te
> well, now I only need to setup the file handling. Also, it can be
> configured with CONFIG_MCONSOLE_EXEC. Note that if disabled, for header
> issues, it defines the exec command anyway but it pretends not to exist(a=
nd
> is not showed in the
I missed the "help" word here: the command is not showed in the help but=20
something is there. The header issues are that I cannot include=20
linux/config.h in *_user.c files(the include path are explicitally removed=
=20
for those files, I think for a good reason), so I must always put the comma=
nd=20
in the command table. Obviously, if I could move the table on the other=20
file(and the prototypes of commands out of mconsole.h), everything would be=
=20
fine, but I've not fully understood the differences between _user.c and=20
_kern.c(I've noticed all differences created by Makefiles, but not in other=
=20
places, i.e. the link scripts).

> However, there is a problem I'm investigating on. Even if the execve fail=
s,
> it reports success. I've debugged it and it showed up that threads
> synchronize properly(i.e. CLONE_VFORK works) and that the fault seems to =
be
> in kmod.c:exec_usermodehelper.
>
> It seems that this code, at the end of the function:
>         if (execve(program_path, argv, envp) < 0)
>                 return -errno;
>         return 0;

I was wrong. On the i386 arch(and I think others, too) the translation from=
=20
return value to errno setting is done in include/asm-i386/unistd.h. Instead=
,=20
UML doesn't do it. I'm posting a patch to correct this in=20
include/asm-um/unistd.h for mainline, but I think that the rest of Uml will=
=20
have to be changed, probably, to conform to the new(and correct) semantic. =
If=20
you agree that this patch will have to go in, I'll complete it with complet=
e=20
checking for errno. But I think I'll need a working version of -4um(see my=
=20
message above), since I think that version has added/changed also much uses=
=20
of errno.
=2D-=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN

--Boundary-00=_CxJa/ZjE6GY0tch
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="errno.patch"
Content-Disposition: inline; filename="errno.patch"
Content-Transfer-Encoding: 7bit

--- linuxUm/include/asm-um/unistd.h.notfixed	2003-09-17 13:30:42.000000000 +0200
+++ linuxUm/include/asm-um/unistd.h	2003-09-17 19:15:58.000000000 +0200
@@ -33,7 +33,11 @@
 	set_fs(KERNEL_DS);			\
 	ret = sys(args);			\
 	set_fs(fs);				\
-	return ret;
+	if (ret < 0) {				\
+	  errno = -ret;				\
+	  return -1;				\
+	}					\
+	return 0;
 
 static inline long open(const char *pathname, int flags, int mode) 
 {

--Boundary-00=_CxJa/ZjE6GY0tch--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

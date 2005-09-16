Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGEJ9-0005fs-JO	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Sep 2005 04:23:07 -0700
Received: from xproxy.gmail.com ([66.249.82.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EGEJ9-0002Tb-5U
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Sep 2005 04:23:07 -0700
Received: by xproxy.gmail.com with SMTP id h31so942113wxd
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 16 Sep 2005 04:23:00 -0700 (PDT)
Message-ID: <2accc2ff0509160423743a1ed6@mail.gmail.com>
From: Nelson Castillo <nelsoneci@gmail.com>
Reply-To: nelsoneci@gmail.com
In-Reply-To: <200509131952.22631.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_19415_523588.1126869780266"
References: <2accc2ff0509111117747e8639@mail.gmail.com>
	 <200509131952.22631.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [uml-user] 2.6.13 / cannot set up LDT for
	thread-local storage
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
Date: Fri, 16 Sep 2005 06:23:00 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

------=_Part_19415_523588.1126869780266
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 9/13/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
(cut)
=20
> >
> > What should I try? Do I need a patch?
> mv /lib/tls /lib/tls.away, after loop-mounting the filesystem on the host=
=20
> , or booting with init=3D/bin/bash (not sure the second will work).

I did some tests. I just found out that
In Debian the best solution is to run:

  # echo "LD_ASSUME_KERNEL=3D2.4.1" >> etc/environment

in the chroot.
(See http://people.redhat.com/drepper/assumekernel.html)
=20
I found something in this thread:

http://lists.debian.org/debian-user/2005/01/msg04226.html
---------------------------------------
--- "Todd A. Jacobs" <nospam@codegnome.org> wrote:=20
> On Fri, Jan 28, 2005 at 10:43:44PM -0500, kynn@panix.com wrote:
> > Is the file /etc/environment _documented_ *anywhere*???
>=20
> It's a highly non-standard, non-portable file that is source by PAM (and
> possibly other applications) on a Debian system.

That is as maybe, but /etc/environment is the
only shell-agnostic file there is, and where it can be
used, it certainly serves a good purpose.
---------------------------------------

I did 2 equivalent tests
  1) patching init/main.c to add the variable to the environment
  2) using a wrapper to /sbin/init

but it seems the environment is just discarded before
running what is in inittab (I'm not sure, I should read the
sources later).

sysvinit should have a way to add a variable to the
environment. Can it be done in intitab?

With : cd /etc && grep  "/etc/environment" * -RH 2>/dev/null

Among others, I found pam.d/login
# This module parses /etc/environment (the standard for  setting
# environ vars) and also allows you to use an extended config

- Do they mean standard in Debian?

BTW,

- when is NPTL (not) supported in UML?

I'm sending for your consideration a small patch for the FAQ
 (that may need some update. I'll do it as I learn more about
this issue).

 Thanks,
 Nelson.-

 --=20
Homepage : http://geocities.com/arhuaco

The first principle is that you must not fool yourself
and you are the easiest person to fool.
     -- Richard Feynman.

------=_Part_19415_523588.1126869780266
Content-Type: text/x-patch; name=faq.html.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="faq.html.patch"

538a539,589
> <a name="kernel Panic, cannot set up thread-local storage"/><table width="100%" bgcolor="#e0e0e0">
>             <tr>
>               <td>
>                 <b>
>                   <font color="black">kernel Panic, cannot set up thread-local storage</font>
>                 </b>
>               </td>
>             </tr>
>           </table>
> <blockquote>
> Your UML kernel doesn't support Native Posix Thread Library and the binaries
> you're running are being dynamically linked to the NTPL libraries.
> <br><br>
> You can boot moving the NTPL libraries away.
> <ul>
> <li> <font color="black"># mount root_fs mnt-uml/ -o loop</font>
> <li> <font color="black"># mv mnt-uml/lib/tls mnt-uml/lib/tls.away</font>
> <li> <font color="black"># umount mnt-uml</font>
> </ul>
> If you're running Debian, you can get away with:
> <pre><font color="black">
>  # mount root_fs mnt-uml/ -o loop
>  # echo "LD_ASSUME_KERNEL=2.4.1" >> /mnt-uml/etc/environment
>  # umount mnt-uml/
> </font></pre>
> 
> It seems that using /etc/environment is Debian specific,
> as <a href="http://lists.debian.org/debian-user/2005/01/msg04226.html">discussed here</a>.
> 
> The LD_ASSUME_KERNEL=2.4.1 environment variable precludes
> the dynamic linker from using the NTPL libraries, as explained
> <a href="http://people.redhat.com/drepper/assumekernel.html">here</a>.
> 
> If you decide to move away /lib/tls/ and you're running Debian, you might
> prefer to use dpkg-divert.
> <pre><font color="black">
>   # export LD_ASSUME_KERNEL=2.4.1
>   # mount root_fs mnt-uml/ -o loop
>   # chroot mnt-uml
>   # mkdir /lib/tls.off
>   # cd /lib/tls
>   # pwd
>   #  for f in *;
>      do
>        dpkg-divert --divert --local --rename --divert /lib/tls.off/$f --add /lib/tls/$f;
>      done
>   # exit
>   # umount mnt-uml
> </font></pre>
> </blockquote>
> 

------=_Part_19415_523588.1126869780266--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

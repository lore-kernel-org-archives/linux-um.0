Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGGEs-00039c-AO	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Sep 2005 06:26:50 -0700
Received: from xproxy.gmail.com ([66.249.82.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EGGEr-0005TX-Qk
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Sep 2005 06:26:50 -0700
Received: by xproxy.gmail.com with SMTP id h31so986221wxd
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 16 Sep 2005 06:26:40 -0700 (PDT)
Message-ID: <2accc2ff050916060122acc08b@mail.gmail.com>
From: Nelson Castillo <nelsoneci@gmail.com>
Reply-To: nelsoneci@gmail.com
In-Reply-To: <2accc2ff0509160423743a1ed6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_19811_18648395.1126875667106"
References: <2accc2ff0509111117747e8639@mail.gmail.com>
	 <200509131952.22631.blaisorblade@yahoo.it>
	 <2accc2ff0509160423743a1ed6@mail.gmail.com>
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
Date: Fri, 16 Sep 2005 08:01:07 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

------=_Part_19811_18648395.1126875667106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 9/16/05, Nelson Castillo <nelsoneci@gmail.com> wrote:

> On 9/13/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> sysvinit should have a way to add a variable to the
> environment. Can it be done in intitab?

I just fixed the patch for the FAQ. It's much simpler
(and correct, I hope) now.

-------------

I tried with the patched init/main.c and:

inittab:
1:2345:respawn:/usr/bin/env LD_ASSUME_KERNEL=3D2.4.1 /sbin/getty 38400 tty1

(w/o the LD_ASSUME_KERNEL=3D2.4.1 the entry in
/etc/environment).

And it dies just after I log in, but I don't get a panic,
just another password prompt. So I guess it's bash
who is not taking the environment that /sbin/init
sets...

And that's why things work when I set
the variable in "/etc/environment"

(and also send a modified environment to
/sbin/init .... with LD_ASSUME_KERNEL=3D2.4.1.
You must do both, I said that setting
/etc/environment was enough in my previous
email and I was quite wrong. Sorry).

Regards.

--=20
Homepage : http://geocities.com/arhuaco

The first principle is that you must not fool yourself
and you are the easiest person to fool.
     -- Richard Feynman.

------=_Part_19811_18648395.1126875667106
Content-Type: text/x-patch; name=faq.html.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="faq.html.patch"

538a539,574
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
> If you're running Debian, you might prefer to use dpkg-divert.
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

------=_Part_19811_18648395.1126875667106--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

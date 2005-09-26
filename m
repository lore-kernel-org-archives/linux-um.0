Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJypv-0004u9-R1	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Sep 2005 12:40:27 -0700
Received: from zproxy.gmail.com ([64.233.162.199])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EJypt-0003RK-UR
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Sep 2005 12:40:27 -0700
Received: by zproxy.gmail.com with SMTP id i11so119160nzh
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 26 Sep 2005 12:40:13 -0700 (PDT)
Message-ID: <229e70f205092612406fa7ecc3@mail.gmail.com>
From: Etay Meiri <etay.meiri@gmail.com>
Reply-To: Etay Meiri <etay.meiri@gmail.com>
Subject: Re: [uml-devel] 2.6.13.2 + gcc 4.01 link error
In-Reply-To: <200509251727.00589.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_19673_32141046.1127763613581"
References: <229e70f2050924085215707921@mail.gmail.com>
	 <200509251727.00589.blaisorblade@yahoo.it>
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
Date: Mon, 26 Sep 2005 22:40:13 +0300
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

------=_Part_19673_32141046.1127763613581
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 9/25/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
>
> > dnsdomainname: Unknown host
> This error is not related to Uml at all and shouldn't give problems in
> itself,
> but why dnsdomainname doesn't work on your machine? You should probably
> fix
> that.


Etay: looks like name resolving is not working ok on my machine. I'm gettin=
g
'host not
found' when running host on my machine name. The name is configured in
/etc/hosts
and 'files' is set first in nsswitch.conf. Looks like the resolver is
bypassing the hosts file
and goes directly to the DNS server of my ISP.

Read my previous answer, however if you want the fix it's in 2.6.13-bs2 -
> and
> it was already in 2.6.14 current Linus tree.


Etay: I updated my kernel tree using:

git pull
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

(is that the correct way to pull Linus tree?)

and got the following errors on compilation:

[cl@amber linux-2.6]$ ARCH=3Dum make
make[1]: `arch/um/sys-i386/util/mk_sc' is up to date.
CHK arch/um/include/uml-config.h
UPD arch/um/include/uml-config.h
CHK include/linux/version.h
UPD include/linux/version.h
SPLIT include/linux/autoconf.h -> include/config/*
gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -ffreestanding -O2 -fomit-frame-pointer -g -fprofile-arcs
-ftest-coverage -D__arch_um__ -DSUBARCH=3D\"i386\" -Iarch/um/include
-I/home/cl/kernel/linux-2.6/arch/um/kernel/tt/include
-I/home/cl/kernel/linux-2.6/arch/um/kernel/skas/include -Dvmap=3Dkernel_vma=
p
-Din6addr_loopback=3Dkernel_in6addr_loopback -Derrno=3Dkernel_errno
-Dsigprocmask=3Dkernel_sigprocmask -fno-unit-at-a-time -U__i386__ -Ui386
-D_LARGEFILE64_SOURCE -Wdeclaration-after-statement -Wno-pointer-sign
-nostdinc -isystem /usr/lib/gcc/i386-redhat-linux/4.0.1/include -D__KERNEL_=
_
-Iinclude -S -o arch/um/kernel-offsets.s arch/um/sys-i386/kernel-offsets.c
In file included from include/asm/thread_info.h:17,
from include/linux/thread_info.h:21,
from include/linux/spinlock.h:53,
from include/linux/capability.h:45,
from include/linux/sched.h:7,
from arch/um/sys-i386/kernel-offsets.c:3:
include/asm/processor.h:69: error: 'CONFIG_X86_L1_CACHE_SHIFT' undeclared
here (not in a function)
include/asm/processor.h:69: error: requested alignment is not a constant
In file included from include/linux/sched.h:12,
from arch/um/sys-i386/kernel-offsets.c:3:
include/linux/jiffies.h:27:5: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:29:7: warning: "CONFIG_HZ" is not defined

Thanks a lot for your help,

-Etay

--
> Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
> Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ
> 215621894)
> http://www.user-mode-linux.org/~blaisorblade
>
>
> ___________________________________
> Yahoo! Messenger: chiamate gratuite in tutto il mondo
> http://it.messenger.yahoo.com
>
>


--
------------------------------------------------------
Etay Meiri
etay.meiri@gmail.com

------=_Part_19673_32141046.1127763613581
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">On 9/25/05, <b class=3D"gmail_send=
ername">Blaisorblade</b> &lt;<a href=3D"mailto:blaisorblade@yahoo.it">blais=
orblade@yahoo.it</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;">
&gt; dnsdomainname: Unknown host<br>This error is not related to Uml at all=
 and shouldn't give problems in itself,<br>but why dnsdomainname doesn't wo=
rk on your machine? You should probably fix<br>that.</blockquote><div><br>

Etay: looks like name resolving is not working ok on my machine. I'm gettin=
g 'host not<br>
found' when running host on my machine name. The name is configured in /etc=
/hosts<br>
and 'files' is set first in nsswitch.conf. Looks like the resolver is bypas=
sing the hosts file<br>
and goes directly to the DNS server of my ISP.<br>
<br>
&nbsp;</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px sol=
id rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Read =
my previous answer, however if you want the fix it's in 2.6.13-bs2 - and<br=
>it was already in=20
2.6.14 current Linus tree.</blockquote><div><br>
Etay: I updated my kernel tree using:<br>
<br>
git pull <a href=3D"rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torva=
lds/linux-2.6.git">rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torval=
ds/linux-2.6.git</a><br>
<br>
(is that the correct way to pull Linus tree?)<br>
<br>
and got the following errors on compilation:<br>
<br>
[cl@amber linux-2.6]$ ARCH=3Dum make<br>
make[1]: `arch/um/sys-i386/util/mk_sc' is up to date.<br>
&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; arch/um/include/uml-config.h<br>
&nbsp; UPD&nbsp;&nbsp;&nbsp;&nbsp; arch/um/include/uml-config.h<br>
&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h<br>
&nbsp; UPD&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h<br>
&nbsp; SPLIT&nbsp;&nbsp; include/linux/autoconf.h -&gt; include/config/*<br=
>
gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
-fno-strict-aliasing -fno-common -ffreestanding
-O2&nbsp;&nbsp;&nbsp;&nbsp; -fomit-frame-pointer -g -fprofile-arcs
-ftest-coverage -D__arch_um__ -DSUBARCH=3D\&quot;i386\&quot;
-Iarch/um/include&nbsp;
-I/home/cl/kernel/linux-2.6/arch/um/kernel/tt/include&nbsp;
-I/home/cl/kernel/linux-2.6/arch/um/kernel/skas/include
-Dvmap=3Dkernel_vmap -Din6addr_loopback=3Dkernel_in6addr_loopback
-Derrno=3Dkernel_errno -Dsigprocmask=3Dkernel_sigprocmask
-fno-unit-at-a-time -U__i386__ -Ui386 -D_LARGEFILE64_SOURCE
-Wdeclaration-after-statement -Wno-pointer-sign&nbsp; -nostdinc
-isystem /usr/lib/gcc/i386-redhat-linux/4.0.1/include -D__KERNEL__
-Iinclude&nbsp; -S -o arch/um/kernel-offsets.s
arch/um/sys-i386/kernel-offsets.c<br>
In file included from include/asm/thread_info.h:17,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
from include/linux/thread_info.h:21,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
from include/linux/spinlock.h:53,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
from include/linux/capability.h:45,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from include/linux/sched.h:7,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
from arch/um/sys-i386/kernel-offsets.c:3:<br>
include/asm/processor.h:69: error: 'CONFIG_X86_L1_CACHE_SHIFT' undeclared h=
ere (not in a function)<br>
include/asm/processor.h:69: error: requested alignment is not a constant<br=
>
In file included from include/linux/sched.h:12,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
from arch/um/sys-i386/kernel-offsets.c:3:<br>
include/linux/jiffies.h:27:5: warning: &quot;CONFIG_HZ&quot; is not defined=
<br>
include/linux/jiffies.h:29:7: warning: &quot;CONFIG_HZ&quot; is not defined=
<br>
<br>
Thanks a lot for your help,<br>
<br>
-Etay<br>
&nbsp;</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">-=
-<br>Inform me of my mistakes, so I can keep imitating Homer Simpson's &quo=
t;Doh!&quot;.
<br>Paolo Giarrusso, aka Blaisorblade (Skype ID &quot;PaoloGiarrusso&quot;,=
 ICQ 215621894)<br><a href=3D"http://www.user-mode-linux.org/~blaisorblade"=
>http://www.user-mode-linux.org/~blaisorblade</a><br><br><br>______________=
_____________________
<br>Yahoo! Messenger: chiamate gratuite in tutto il mondo<br><a href=3D"htt=
p://it.messenger.yahoo.com">http://it.messenger.yahoo.com</a><br><br></bloc=
kquote></div><br><br clear=3D"all"><br>-- <br>-----------------------------=
-------------------------
<br>Etay Meiri<br><a href=3D"mailto:etay.meiri@gmail.com">etay.meiri@gmail.=
com</a>

------=_Part_19673_32141046.1127763613581--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

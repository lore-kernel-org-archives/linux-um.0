Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <d875c4ca0902111928o60f8daddt7b0c84902bae380d@mail.gmail.com>
References: <d875c4ca0902111928o60f8daddt7b0c84902bae380d@mail.gmail.com>
Date: Thu, 12 Feb 2009 17:02:58 -0800
Message-ID: <d875c4ca0902121702n774678o65c2f0aeb27ccd7f@mail.gmail.com>
From: David Francisco Rodriguez Perez <david.francisco.rodriguez@gmail.com>
Subject: Re: [uml-devel] linux 2.6.29-rc2
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3392923948060167646=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net

--===============3392923948060167646==
Content-Type: multipart/alternative; boundary=000e0cd3116ad783750462c26515

--000e0cd3116ad783750462c26515
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

I decided to post on a wider audience. So far the uml vmlinux  gets block on
bootup at
page_ok(top) ->  n = *address;
when calculating the top of the address space.

So my only guess so far is that the RHEL 5.0 has the option:
CONFIG_DEBUG_HIGHMEM
enable and the Ubuntu does not.
If I change the top starting address from:
unsigned long top = 0xffffd000 >> UM_KERN_PAGE_SHIFT
to
unsigned long top = 0xf0000000 >> UM_KERN_PAGE_SHIFT
it works.

Does anybody know why it would be?

Thanks

David Rodriguez



On Wed, Feb 11, 2009 at 7:28 PM, David Francisco Rodriguez Perez <
david.francisco.rodriguez@gmail.com> wrote:

> Hi All
>
>
> I downloaded linux 2.6.29-rc2 and I did applied a recent patch from Heiko
> Carstens (link below) to fix a link problem.
>
> http://marc.info/?l=linux-kernel&m=123400805007855&w=2
>
> If I run in ubuntu 8.04 (libc 2.7) it runs okay. But If I run in RHEL 5.0
> (libc2.5) it gets bock in:
> $ ./vmlinux mem=128M
> Locating the bottom of the address space ... 0x0
> Locating the top of the address space ...
>
> So it looks like a problem seen before like
>
> http://kerneltrap.org/mailarchive/linux-kernel/2008/8/5/2828244
>
> But that patch is already in. So does anybody know why would it be
> happening?
>
> Thanks
>
> David Rodriguez
>
> PS. So far it stops at:
>
> (gdb) n
> 31            n = *address;
> (gdb) n
>
>

--000e0cd3116ad783750462c26515
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi<br><br>I decided to post on a wider audience. So far the uml vmlinux&nbs=
p; gets block on bootup at<br>page_ok(top) -&gt;&nbsp; n =3D *address;<br>w=
hen calculating the top of the address space.<br><br>So my only guess so fa=
r is that the RHEL 5.0 has the option:<br>
CONFIG_DEBUG_HIGHMEM<br>enable and the Ubuntu does not.<br>If I change the =
top starting address from:<br>unsigned long top =3D 0xffffd000 &gt;&gt; UM_=
KERN_PAGE_SHIFT<br>to<br>unsigned long top =3D 0xf0000000 &gt;&gt; UM_KERN_=
PAGE_SHIFT<br>

it works.&nbsp; <br><br>Does anybody know why it would be?<br><br>Thanks<br=
><br>David Rodriguez<br><br><br><br><div class=3D"gmail_quote">On Wed, Feb =
11, 2009 at 7:28 PM, David Francisco Rodriguez Perez <span dir=3D"ltr">&lt;=
<a href=3D"mailto:david.francisco.rodriguez@gmail.com">david.francisco.rodr=
iguez@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi All<br><br><br=
>I downloaded linux 2.6.29-rc2 and I did applied a recent patch from Heiko =
Carstens (link below) to fix a link problem.<br>
<br><a href=3D"http://marc.info/?l=3Dlinux-kernel&amp;m=3D123400805007855&a=
mp;w=3D2" target=3D"_blank">http://marc.info/?l=3Dlinux-kernel&amp;m=3D1234=
00805007855&amp;w=3D2</a><br>
<br>If I run in ubuntu 8.04 (libc 2.7) it runs okay. But If I run in RHEL 5=
.0 (libc2.5) it gets bock in:<br>$ ./vmlinux mem=3D128M<br>Locating the bot=
tom of the address space ... 0x0<br>Locating the top of the address space .=
.. <br>

<br>So it looks like a problem seen before like<br><br><a href=3D"http://ke=
rneltrap.org/mailarchive/linux-kernel/2008/8/5/2828244" target=3D"_blank">h=
ttp://kerneltrap.org/mailarchive/linux-kernel/2008/8/5/2828244</a><br><br>
But that patch is already in. So does anybody know why would it be happenin=
g?<br>
<br>Thanks<br><br>David Rodriguez<br><br>PS. So far it stops at:<br><br>(gd=
b) n<br>31&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; n =3D *a=
ddress;<br>(gdb) n<br><br>
</blockquote></div><br>

--000e0cd3116ad783750462c26515--


--===============3392923948060167646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
--===============3392923948060167646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============3392923948060167646==--



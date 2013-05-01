Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <terry.shoes@gmail.com>) id 1UXbFc-0000xK-Li
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 May 2013 17:55:32 +0000
Received: from mail-la0-f50.google.com ([209.85.215.50])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UXbFb-0005tm-EO
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 May 2013 17:55:32 +0000
Received: by mail-la0-f50.google.com with SMTP id fl20so1526348lab.37
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 01 May 2013 10:55:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <311858522.18447.1367339268757.JavaMail.root@sigma-star.at>
References: <CA+ve00STDD3cud+U_f7=nJpgygE0_vjRoOjiDJBVAiHEzQgxRQ@mail.gmail.com>
	<311858522.18447.1367339268757.JavaMail.root@sigma-star.at>
From: Terry Hsu <terry.shoes@gmail.com>
Date: Wed, 1 May 2013 13:54:44 -0400
Message-ID: <CAER6Ckc5PpTBZNy93WtK1ZvJqCaoQkGgKDYcUtTmCfmhwYNmow@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7311670551219803408=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] UML Hardware Virt Support
To: "Richard RW. Weinberger" <richard@sigma-star.at>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--===============7311670551219803408==
Content-Type: multipart/alternative; boundary=089e01161bf485a96604dbabd218

--089e01161bf485a96604dbabd218
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2013 at 12:27 PM, Richard RW. Weinberger <
richard@sigma-star.at> wrote:

> ----- Urspr=FCngliche Mail -----
> >
> >
> > > UML development mostly stopped in favor to KVM.
> >
> >
> > so you mean to say that KVM is preferable to UML?
> > (I Guess it may depend on the situation?)
>
> KVM is *much* faster than UML and *much* less hacky. :-)
>
>
Indeed, I am developing some functions for the virtual memory subsystem in
the kernel.
Qemu replaces UML in my case. I run qemu without kvm support because I
don't seem to be able to run nested virtualization in virtualbox.
Anyway now Qemu serves me well. :)

Is Jeff Dike still developing UML?


>  Thanks,
> //richard
>
>
> -------------------------------------------------------------------------=
-----
> Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
> Get 100% visibility into your production application - at no cost.
> Code-level diagnostics for performance bottlenecks with <2% overhead
> Download for free and get started troubleshooting in minutes.
> http://p.sf.net/sfu/appdyn_d2d_ap1
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>

--089e01161bf485a96604dbabd218
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Tue, Apr 30, 2013 at 12:27 PM, Richard RW. Weinberger <span dir=
=3D"ltr">&lt;<a href=3D"mailto:richard@sigma-star.at" target=3D"_blank">ric=
hard@sigma-star.at</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">----- Urspr=FCngliche Mail -----<br>
<div class=3D"im">&gt;<br>
&gt;<br>
&gt; &gt; UML development mostly stopped in favor to KVM.<br>
&gt;<br>
&gt;<br>
&gt; so you mean to say that KVM is preferable to UML?<br>
&gt; (I Guess it may depend on the situation?)<br>
<br>
</div>KVM is *much* faster than UML and *much* less hacky. :-)<br>
<div class=3D""><div class=3D"h5"><br></div></div></blockquote><div class=
=3D"gmail_quote"><br></div>Indeed, I am developing some functions for the v=
irtual memory subsystem in the kernel.</div><div class=3D"gmail_quote">Qemu=
 replaces UML in my case. I run qemu without kvm support because I don&#39;=
t seem to be able to run nested virtualization in virtualbox.</div>

<div class=3D"gmail_quote">Anyway now Qemu serves me well. :)</div><div cla=
ss=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Is Jeff Dike still =
developing UML?<br><div>=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,2=
04,204);border-left-style:solid;padding-left:1ex">

<div class=3D""><div class=3D"h5">
Thanks,<br>
//richard<br>
<br>
---------------------------------------------------------------------------=
---<br>
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET<br>
Get 100% visibility into your production application - at no cost.<br>
Code-level diagnostics for performance bottlenecks with &lt;2% overhead<br>
Download for free and get started troubleshooting in minutes.<br>
<a href=3D"http://p.sf.net/sfu/appdyn_d2d_ap1" target=3D"_blank">http://p.s=
f.net/sfu/appdyn_d2d_ap1</a><br>
_______________________________________________<br>
User-mode-linux-devel mailing list<br>
<a href=3D"mailto:User-mode-linux-devel@lists.sourceforge.net">User-mode-li=
nux-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/user-mode-linux-dev=
el" target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/user-mod=
e-linux-devel</a><br>
</div></div></blockquote></div><br></div></div>

--089e01161bf485a96604dbabd218--


--===============7311670551219803408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
--===============7311670551219803408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============7311670551219803408==--



Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <earlenceferns@gmail.com>) id 1UXDkl-0007Ta-Kn
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Apr 2013 16:50:07 +0000
Received: from mail-wg0-f45.google.com ([74.125.82.45])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UXDkk-0003Yb-Og
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Apr 2013 16:50:07 +0000
Received: by mail-wg0-f45.google.com with SMTP id l18so693970wgh.24
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 30 Apr 2013 09:50:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <311858522.18447.1367339268757.JavaMail.root@sigma-star.at>
References: <CA+ve00STDD3cud+U_f7=nJpgygE0_vjRoOjiDJBVAiHEzQgxRQ@mail.gmail.com>
	<311858522.18447.1367339268757.JavaMail.root@sigma-star.at>
From: Earlence Fernandes <earlenceferns@gmail.com>
Date: Tue, 30 Apr 2013 12:49:39 -0400
Message-ID: <CA+ve00QZq=tDAprLwZcthgqKk262RW_+Vq4YmHvWO5bECxzv=Q@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8623711167225263821=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] UML Hardware Virt Support
To: "Richard RW. Weinberger" <richard@sigma-star.at>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--===============8623711167225263821==
Content-Type: multipart/alternative; boundary=f46d043c7ddec8870504db96ca85

--f46d043c7ddec8870504db96ca85
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

But then there's a fundamental question of whether KVM has similar
semantics.
UML was incredibly useful to my project since it ran a whole "kernel +
processes" in user space.
Now i'm confused as to whether I need to change my work so that it works
with KVM (I'm trying to read thru KVM docs to understand the semantics).

Basically, my project involved redirecting the system calls of one process
to the UML kernel.


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
> Thanks,
> //richard
>

--f46d043c7ddec8870504db96ca85
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">But then there&#39;s a fundamental question of whether KVM=
 has similar semantics.<div>UML was incredibly useful to my project since i=
t ran a whole &quot;kernel + processes&quot; in user space.</div><div>Now i=
&#39;m confused as to whether I need to change my work so that it works wit=
h KVM (I&#39;m trying to read thru KVM docs to understand the semantics).</=
div>

<div><br></div><div>Basically, my project involved redirecting the system c=
alls of one process to the UML kernel.=A0</div></div><div class=3D"gmail_ex=
tra"><br><br><div class=3D"gmail_quote">On Tue, Apr 30, 2013 at 12:27 PM, R=
ichard RW. Weinberger <span dir=3D"ltr">&lt;<a href=3D"mailto:richard@sigma=
-star.at" target=3D"_blank">richard@sigma-star.at</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">----- Urspr=FCngliche Mail -----<br>
<div class=3D"im">&gt;<br>
&gt;<br>
&gt; &gt; UML development mostly stopped in favor to KVM.<br>
&gt;<br>
&gt;<br>
&gt; so you mean to say that KVM is preferable to UML?<br>
&gt; (I Guess it may depend on the situation?)<br>
<br>
</div>KVM is *much* faster than UML and *much* less hacky. :-)<br>
<br>
Thanks,<br>
//richard<br>
</blockquote></div><br></div>

--f46d043c7ddec8870504db96ca85--


--===============8623711167225263821==
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
--===============8623711167225263821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============8623711167225263821==--



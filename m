Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <earlenceferns@gmail.com>) id 1UWX4d-00009b-PD
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Apr 2013 19:15:47 +0000
Received: from mail-wg0-f49.google.com ([74.125.82.49])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UWX4c-0005h8-Vq
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Apr 2013 19:15:47 +0000
Received: by mail-wg0-f49.google.com with SMTP id x12so3083387wgg.28
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 28 Apr 2013 12:15:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFLxGvxQz=wbzkFqp5wx33VyAEknhUQ6yEY81iDcNVk3CR2DaQ@mail.gmail.com>
References: <CA+ve00RvAsBBqZ1TFt_q3fCxDTS54aUN5MpL7pK_+6u3O-=rwg@mail.gmail.com>
	<CAFLxGvxQz=wbzkFqp5wx33VyAEknhUQ6yEY81iDcNVk3CR2DaQ@mail.gmail.com>
From: Earlence Fernandes <earlenceferns@gmail.com>
Date: Sun, 28 Apr 2013 15:15:20 -0400
Message-ID: <CA+ve00RjQYR99iQy_8OG9Kw2rA8PHPyOYb8QxidVuknMkDOOoQ@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2169156638066489637=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Code for tracing thread
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--===============2169156638066489637==
Content-Type: multipart/alternative; boundary=14dae9cc9f960e8ce504db709831

--14dae9cc9f960e8ce504db709831
Content-Type: text/plain; charset=ISO-8859-1

so does the code for interception now live in skas/ ?

-Earlence


On Sun, Apr 28, 2013 at 3:07 PM, richard -rw- weinberger <
richard.weinberger@gmail.com> wrote:

> On Sun, Apr 28, 2013 at 5:43 PM, Earlence Fernandes
> <earlenceferns@gmail.com> wrote:
> > I keep reading that there is a tracing thread that intercepts process
> > syscalls and I've been grepping thru the kernel sources to find this.
>
> UML intercepts all system calls in any mode.
> Tracing thread mode (tt) was the very first operating mode it was
> dropped years ago
> in flavor to SKAS0 mode.
>
> --
> Thanks,
> //richard
>

--14dae9cc9f960e8ce504db709831
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">so does the code for interception now live in skas/ ?<div>=
<br></div><div>-Earlence</div></div><div class=3D"gmail_extra"><br><br><div=
 class=3D"gmail_quote">On Sun, Apr 28, 2013 at 3:07 PM, richard -rw- weinbe=
rger <span dir=3D"ltr">&lt;<a href=3D"mailto:richard.weinberger@gmail.com" =
target=3D"_blank">richard.weinberger@gmail.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Sun, Apr 28, 2013 at 5:=
43 PM, Earlence Fernandes<br>
&lt;<a href=3D"mailto:earlenceferns@gmail.com">earlenceferns@gmail.com</a>&=
gt; wrote:<br>
&gt; I keep reading that there is a tracing thread that intercepts process<=
br>
&gt; syscalls and I&#39;ve been grepping thru the kernel sources to find th=
is.<br>
<br>
</div>UML intercepts all system calls in any mode.<br>
Tracing thread mode (tt) was the very first operating mode it was<br>
dropped years ago<br>
in flavor to SKAS0 mode.<br>
<br>
--<br>
Thanks,<br>
//richard<br>
</blockquote></div><br></div>

--14dae9cc9f960e8ce504db709831--


--===============2169156638066489637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
--===============2169156638066489637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2169156638066489637==--



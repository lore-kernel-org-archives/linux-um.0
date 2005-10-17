Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERZeB-0005Oh-9R	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Oct 2005 11:23:43 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ERZe6-0001r6-Ew
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Oct 2005 11:23:43 -0700
Received: by wproxy.gmail.com with SMTP id i5so487006wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 17 Oct 2005 11:23:32 -0700 (PDT)
Message-ID: <229e70f20510171123o21d4bda8t3c03a5c229e85ad2@mail.gmail.com>
From: Etay Meiri <etay.meiri@gmail.com>
Subject: Re: [uml-devel] Starting uml with the debugger
In-Reply-To: <20051017175328.GA8015@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7146_1185149.1129573412746"
References: <229e70f20510171009x103fe854ncb91021c3ce0e31e@mail.gmail.com>
	 <20051017175328.GA8015@localhost.localdomain>
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
Date: Mon, 17 Oct 2005 20:23:32 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

------=_Part_7146_1185149.1129573412746
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 10/17/05, Jeff Dike <jdike@addtoit.com> wrote:
>
> On Mon, Oct 17, 2005 at 07:09:21PM +0200, Etay Meiri wrote:
> > Hi,
> >
> > I'm trying to start uml under the controller of gdb using the following
> > command:
>
> What version?


2.6.13 with 2.6.13-bs2 patch.

> ./vmlinux mem=3D128m ubda=3Droot_fs.fc4_client ubdb=3Dswap_client con=3Dx=
term
> > eth0=3Dtuntap,,,10.10.20.10 <http://10.10.20.10> <http://10.10.20.10>
> debug
>
> WTF is <http://10.10.20.10>?


hmm...looks like copy&paste problem. ignore it, it was not in the command
line.

If this thing is new enough to have skas0, then just disable CONFIG_MODE_TT
> and gdb it normally.


Will it still run if my host kernel is not skas enabled?



--
------------------------------------------------------
Etay Meiri
etay.meiri@gmail.com

------=_Part_7146_1185149.1129573412746
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 10/17/05, <b class=3D"gmail_sendername">Jeff Dike</b> &lt;<a href=3D"mai=
lto:jdike@addtoit.com">jdike@addtoit.com</a>&gt; wrote:<div><span class=3D"=
gmail_quote"></span><blockquote class=3D"gmail_quote" style=3D"border-left:=
 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex=
;">
On Mon, Oct 17, 2005 at 07:09:21PM +0200, Etay Meiri wrote:<br>&gt; Hi,<br>=
&gt;<br>&gt; I'm trying to start uml under the controller of gdb using the =
following<br>&gt; command:<br><br>What version?</blockquote><div><br>
2.6.13 with 2.6.13-bs2 patch. <br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; ./vmli=
nux mem=3D128m ubda=3Droot_fs.fc4_client ubdb=3Dswap_client con=3Dxterm<br>=
&gt; eth0=3Dtuntap,,,
<a href=3D"http://10.10.20.10">10.10.20.10</a> &lt;<a href=3D"http://10.10.=
20.10">http://10.10.20.10</a>&gt; debug<br><br>WTF is &lt;<a href=3D"http:/=
/10.10.20.10">http://10.10.20.10</a>&gt;?</blockquote><div><br>
hmm...looks like copy&amp;paste problem. ignore it, it was not in the comma=
nd line.<br>
&nbsp;</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I=
f this thing is new enough to have skas0, then just disable CONFIG_MODE_TT<=
br>and gdb it normally.
</blockquote><div><br>
Will it still run if my host kernel is not skas enabled?<br>
&nbsp;</div></div><br><br clear=3D"all"><br>-- <br>------------------------=
------------------------------<br>Etay Meiri<br><a href=3D"mailto:etay.meir=
i@gmail.com">etay.meiri@gmail.com</a>

------=_Part_7146_1185149.1129573412746--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

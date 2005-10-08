Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EO874-00043x-Rp	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 23:23:18 -0700
Received: from wproxy.gmail.com ([64.233.184.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EO873-00089S-JB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 23:23:18 -0700
Received: by wproxy.gmail.com with SMTP id i4so430459wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 07 Oct 2005 23:23:11 -0700 (PDT)
Message-ID: <229e70f20510072323u725b2406l84b19c66942254ac@mail.gmail.com>
From: Etay Meiri <etay.meiri@gmail.com>
Subject: Re: [uml-devel] Respawning too fast - 2.6.13-bs2
In-Reply-To: <200510071707.41531.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2390_32881564.1128752591828"
References: <229e70f20510070643h79c3a661q116d6093d0a63bdf@mail.gmail.com>
	 <200510071707.41531.blaisorblade@yahoo.it>
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
Date: Sat, 8 Oct 2005 08:23:11 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

------=_Part_2390_32881564.1128752591828
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>
> > INIT: Id "0" respawning too fast: disabled for 5 minutes
> > INIT: no more processes left in this runlevel
> >
> > I did play with it earlier (updated a few rpms and configured nfs) but
> > I'm not sure which of my steps caused this.
> > Any idea how to debug it?
> Problems like this come usually from:
> b) messing up /etc/inittab (possibly from RPM?) - it must use non-DevFS
> names
>

/etc/inittab contained 'tty0' as the device. It doesn't exist in /dev. I
changed
it to 'console' and now it is working correctly.

Thanks a lot,

--
------------------------------------------------------
Etay Meiri
etay.meiri@gmail.com

------=_Part_2390_32881564.1128752591828
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; INIT: I=
d &quot;0&quot; respawning too fast: disabled for 5 minutes<br>&gt; INIT: n=
o more processes left in this runlevel
<br>&gt;<br>&gt; I did play with it earlier (updated a few rpms and configu=
red nfs) but<br>&gt; I'm not sure which of my steps caused this.<br>&gt; An=
y idea how to debug it?<br>Problems like this come usually from:<br>b) mess=
ing up /etc/inittab (possibly from RPM?) - it must use non-DevFS names
<br></blockquote></div><br>
/etc/inittab contained 'tty0' as the device. It doesn't exist in /dev. I ch=
anged<br>
it to 'console' and now it is working correctly.<br>
<br>
Thanks a lot,<br clear=3D"all"><br>-- <br>---------------------------------=
---------------------<br>Etay Meiri<br><a href=3D"mailto:etay.meiri@gmail.c=
om">etay.meiri@gmail.com</a>

------=_Part_2390_32881564.1128752591828--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

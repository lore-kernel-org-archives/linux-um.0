Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ENsVp-0008VW-6M	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 06:43:49 -0700
Received: from wproxy.gmail.com ([64.233.184.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ENsVo-000255-2M
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 06:43:49 -0700
Received: by wproxy.gmail.com with SMTP id i4so344309wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 07 Oct 2005 06:43:41 -0700 (PDT)
Message-ID: <229e70f20510070643h79c3a661q116d6093d0a63bdf@mail.gmail.com>
From: Etay Meiri <etay.meiri@gmail.com>
Reply-To: Etay Meiri <etay.meiri@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_47962_33096533.1128692621292"
Subject: [uml-devel] Respawning too fast - 2.6.13-bs2
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
Date: Fri, 7 Oct 2005 15:43:41 +0200
To: user-mode-linux-devel@lists.sourceforge.net

------=_Part_47962_33096533.1128692621292
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm suddenly unable to boot my 2.6.13-bs2 based uml system.
Getting the following errors at the end:

Starting anacron: [ OK ]
Starting atd: [ OK ]
Starting system message bus: [ OK ]
Starting HAL daemon: [ OK ]
INIT: Id "0" respawning too fast: disabled for 5 minutes
INIT: no more processes left in this runlevel

I did play with it earlier (updated a few rpms and configured nfs) but
I'm not sure which of my steps caused this.
Any idea how to debug it?

Thanks,

--
------------------------------------------------------
Etay Meiri
etay.meiri@gmail.com

------=_Part_47962_33096533.1128692621292
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
I'm suddenly unable to boot my 2.6.13-bs2 based uml system.<br>
Getting the following errors at the end:<br>
<br>
Starting anacron: [&nbsp; OK&nbsp; ]<br>
Starting atd: [&nbsp; OK&nbsp; ]<br>
Starting system message bus: [&nbsp; OK&nbsp; ]<br>
Starting HAL daemon: [&nbsp; OK&nbsp; ]<br>
INIT: Id &quot;0&quot; respawning too fast: disabled for 5 minutes<br>
INIT: no more processes left in this runlevel<br>
<br>
I did play with it earlier (updated a few rpms and configured nfs) but<br>
I'm not sure which of my steps caused this. <br>
Any idea how to debug it?<br>
<br>
Thanks,<br>
<br>-- <br>------------------------------------------------------<br>Etay M=
eiri<br><a href=3D"mailto:etay.meiri@gmail.com">etay.meiri@gmail.com</a>

------=_Part_47962_33096533.1128692621292--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

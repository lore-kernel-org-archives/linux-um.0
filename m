Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jagan.kernel@gmail.com>) id 1Qtq6T-0002qL-AH
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 00:04:57 +0000
Received: from mail-pz0-f42.google.com ([209.85.210.42])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Qtq6S-00086S-Im
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 00:04:57 +0000
Received: by pzk37 with SMTP id 37so1962154pzk.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 17 Aug 2011 17:04:50 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 18 Aug 2011 09:04:50 +0900
Message-ID: <CANjRM=ZeZJoZDucaTSC4QR-j93EG0Zi1RdDwCi-kAESmRwNj_g@mail.gmail.com>
From: jagan kernel <jagan.kernel@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4845895769198727785=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [linux-3.0] Regarding deprecation of
	__lookup_machine_type in arch/arm/kernel/head.S
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============4845895769198727785==
Content-Type: multipart/alternative; boundary=000e0cd312ec95064504aabc5cf1

--000e0cd312ec95064504aabc5cf1
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am Kernel Developer.
Currently I am working to port Linux-3.0 on to ARM target.

I compiled the kernel with board additions, But it's not booting.
While I am debugging, I found that __lookup_machine_type is deprecated in
arch/arm/kernel/head.S
I manually added this function from previous kernel and again I try to boot
this time* It will show the
halting message with all ARM register contents & Stops.*

Could you help me out this issue, adding __lookup_machine_type is reasonable
or any like implementation in 3.0

Thanks your time  & I am awaiting for your replay

Regards,
Jagan

--000e0cd312ec95064504aabc5cf1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am Kernel Developer.<br>Currently I am working to port Linux-3=
.0 on to ARM target.<br><br>I compiled the kernel with board additions, But=
 it&#39;s not booting.<br>While I am debugging, I found that <span style=3D=
"color: rgb(255, 0, 0);">__lookup_machine_type</span> is deprecated in arch=
/arm/kernel/head.S<br>


I manually added this function from previous kernel and again I try to boot=
 this time<b> It will show the<br>halting message with all ARM register con=
tents &amp; Stops.</b><br><br>Could you help me out this issue, adding __lo=
okup_machine_type is reasonable or any like implementation in 3.0<br>


<br>Thanks your time=A0 &amp; I am awaiting for your replay<br><br>Regards,=
<br><font color=3D"#888888"><font color=3D"#888888">Jagan</font>
</font>

--000e0cd312ec95064504aabc5cf1--


--===============4845895769198727785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
--===============4845895769198727785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============4845895769198727785==--



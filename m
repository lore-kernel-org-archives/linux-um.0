Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shlomopongratz@gmail.com>) id 1LzVsT-0003cZ-Na
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Apr 2009 13:00:37 +0000
Received: from mail-bw0-f222.google.com ([209.85.218.222])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LzVsI-0008U3-NI for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Apr 2009 13:00:27 +0000
Received: by bwz22 with SMTP id 22so1798343bwz.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 30 Apr 2009 06:00:24 -0700 (PDT)
MIME-Version: 1.0
From: Shlomo Pongratz <shlomopongratz@gmail.com>
Date: Thu, 30 Apr 2009 16:00:04 +0300
Message-ID: <88ea9a580904300600p35dae66ake68916536ed9b472@mail.gmail.com>
Subject: [uml-devel] Use iomem for cluster interconnect
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2491788047779438331=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============2491788047779438331==
Content-Type: multipart/alternative; boundary=001636c5ac7a7e341f0468c5470d

--001636c5ac7a7e341f0468c5470d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi All,

In Jeff Dike's book User Mode Linux it is mentioned in page 247 that iomem
driver "is mostly used for writing emulated drivers and cluster
interconnect".
Did anyone encountered an example of one of these usages? Except for the
obvious demo driver mmapper_kern.c
I'm trying to emulate two boards connected via PCIe (one is of course root
complex and the other is an endpoint). Thus iomem seems the obvious
solution.
I'm also interested with simulating PCIe doorbell interrupt from one
simulated board to the other.

Best regards,

S.P.

--001636c5ac7a7e341f0468c5470d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<br><br>In Jeff Dike&#39;s book User Mode Linux it =
is mentioned in
page 247 that iomem driver &quot;is mostly used for writing emulated driver=
s
and cluster interconnect&quot;.<br>Did anyone encountered an example of one=
 of
these usages? Except for the obvious demo driver mmapper_kern.c<br>
I&#39;m trying to emulate two boards connected via PCIe (one is of course r=
oot complex and the other is an endpoint). Thus iomem seems the obvious sol=
ution.<br>I&#39;m also interested with simulating PCIe doorbell interrupt f=
rom one simulated board to the other.<br>

<br>Best regards,<br>

=A0<br>S.P.</div>

--001636c5ac7a7e341f0468c5470d--


--===============2491788047779438331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
--===============2491788047779438331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2491788047779438331==--



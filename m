Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dDE2g-0001sS-73
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 May 2017 17:56:22 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dDE2e-0001t5-QC
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 May 2017 17:56:22 +0000
MIME-Version: 1.0
From: Thomas Meyer <thomas@m3y3r.de>
Date: Tue, 23 May 2017 19:56:15 +0200
Message-Id: <E1dDE2Y-0002Kh-CQ@www17.your-server.de>
Subject: [uml-devel] um: xstate changes breaks my UML setup
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7688386951627966873=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--===============7688386951627966873==
Content-Type: multipart/alternative;
	boundary="_E75430F9-95C9-4D57-ACF1-E5030AB46FE7_"

--_E75430F9-95C9-4D57-ACF1-E5030AB46FE7_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

to make UML work again with the latest Fedora Installation I Need to revert=
 those commits:
b6024b21fec8367ef961a771cc9dde31f1831965
a78ff1112263fdd871d3506dbcff44f6f12e8423

A reproducer script/config is available here:
https://github.com/thomasmey/uml/blob/master/fedora-26-install.sh

with Kind regards
thomas



--_E75430F9-95C9-4D57-ACF1-E5030AB46FE7_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta ht=
tp-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta name=
=3DGenerator content=3D"Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3DDE link=3D"#0563C1" vlink=3D"#954F72"><div c=
lass=3DWordSection1><p class=3DMsoNormal>Hi,</p><p class=3DMsoNormal><o:p>&=
nbsp;</o:p></p><p class=3DMsoNormal>to make UML work again with the latest =
Fedora Installation I Need to revert those commits:</p><p class=3DMsoNormal=
>b6024b21fec8367ef961a771cc9dde31f1831965</p><p class=3DMsoNormal>a78ff1112=
263fdd871d3506dbcff44f6f12e8423</p><p class=3DMsoNormal><o:p>&nbsp;</o:p></=
p><p class=3DMsoNormal>A reproducer script/config is available here:</p><p =
class=3DMsoNormal><a href=3D"https://github.com/thomasmey/uml/blob/master/f=
edora-26-install.sh">https://github.com/thomasmey/uml/blob/master/fedora-26=
-install.sh</a></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMso=
Normal>with Kind regards</p><p class=3DMsoNormal>thomas</p><p class=3DMsoNo=
rmal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><=
/body></html>=

--_E75430F9-95C9-4D57-ACF1-E5030AB46FE7_--



--===============7688386951627966873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============7688386951627966873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============7688386951627966873==--




Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DzQR7-0002hS-Nf	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2005 19:53:53 -0700
Received: from web131873-3.gw.connect.com.au ([210.11.57.5]
	helo=newbushfire.webwombat.com.au)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1DzQR7-00017l-46
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2005 19:53:53 -0700
Received: from phill2knb ([10.1.1.60])j712reg01146
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 1 Aug 2005 12:53:40 +1000
Message-ID: <003e01c59644$3893a5b0$3c01010a@webwombat.com.au>
From: "Phill Wombat" <uml@webwombat.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_003B_01C59698.0A1FAA90"
Subject: [uml-devel] sysctl -w va.legacy_va_layout=1
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
Date: Mon, 1 Aug 2005 12:53:39 +1000
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

------=_NextPart_000_003B_01C59698.0A1FAA90
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

RegardsHi Paolo,

Looking into another issue (my son's gaming machine - counter-strike =
source on linux) I came across this interesting parameter whereby =
winex/Cedega won't run steam unless legacy support for legacy VA layout =
is enabled on a 2.6.9 kernel.

Well, I thought, I'd better try that out......

With 2.6.12+bs9 on x86_64 the error now changes

On the host set:
sysctl -w va.legacy_va_layout=3D1
sysctl -w kernel.randomize_va_space=3D0

Starting the uml with init=3D/bin/sh starts up as usual. Performing the =
ls command now result in a different thing happening:
Bad op in do_proc_op

Where as before it produced:
Child 22915 exited with signal 11

Furthermore, Ctrl-C shuts everything down cleanly. Don't the =
significance if any of all this, but if feels better.

Conducting the same test on 32bit 2.6.12+bs9 results in total disaster =
(feels very bad):

<0>Kernel panic - not syncing: fix_range fixing wrong address space, =
current=3D0xabebf6c0
folloed by lost of register dumps and traceback stuff (2 lots actually - =
which I take to mean it really really crashed).

I can only get init=3D/bin/sh to go when kernel.randomize_va_space=3D1 =
and vm.legacy_va_layout=3D0
Running the ls command then results in a message similar to:
Child 22915 exited with signal 11

Perhaps the only thing of value in all this is va.legacy_va_layout which =
may be useful to UML. It seems to do something, I just don't know what.

Cheers
Phill.

>Hi Paolo,
>
>>Try also following this (from another email) - it appeared in vanilla
>>2.6.12=20
>>and may be in your FC4 kernel. Not sure but it may be playing a role
>>here:
>>
>>"It looks like VA space randomization is the culprit.  The problem =
only
>>shows up when the host is 2.6.12, and can be solved by setting the
>>kernel.randomize_va_space sysctl to zero.  Thanks for the pointer
>>there."
>
>Here are the results with sysctl -w kernel.randomize_va_space=3D0.
>Essentially no effect observed.


------=_NextPart_000_003B_01C59698.0A1FAA90
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns:o =3D "urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word"><HEAD><TITLE>Regards</TITLE><BASE=
=20
href=3D"file://S:\Mail SignOff\">
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dwindows-1252">
<META content=3DWord.Document name=3DProgId>
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR>
<META content=3D"Microsoft Word 9" name=3DOriginator><LINK=20
href=3D"./Peter%20Sign-off_files/filelist.xml" rel=3DFile-List><!--[if =
gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>peterm</o:Author>
  <o:Template>Normal</o:Template>
  <o:LastAuthor>peterm</o:LastAuthor>
  <o:Revision>1</o:Revision>
  <o:TotalTime>6</o:TotalTime>
  <o:Created>2004-05-24T01:13:00Z</o:Created>
  <o:LastSaved>2004-05-24T01:19:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Company>Web Wombat Pty Ltd</o:Company>
  <o:Lines>1</o:Lines>
  <o:Paragraphs>1</o:Paragraphs>
  <o:Version>9.2720</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<STYLE>@font-face {
	font-family: Wingdings;
}
@font-face {
	font-family: Verdana;
}
@font-face {
	font-family: ver;
}
@font-face {
	font-family: Trebuchet MS;
}
@page Section1 {size: 595.3pt 841.9pt; margin: 72.0pt 90.0pt 72.0pt =
90.0pt; mso-header-margin: 35.4pt; mso-footer-margin: 35.4pt; =
mso-paper-source: 0; }
P.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: "Times New Roman"
}
LI.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: "Times New Roman"
}
DIV.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: "Times New Roman"
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline; text-underline: single
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline; text-underline: single
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline; text-underline: single
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline; text-underline: single
}
DIV.Section1 {
	page: Section1
}
</STYLE>
</HEAD>
<BODY lang=3DEN-AU style=3D"tab-interval: 36.0pt" vLink=3D#999999 =
link=3D#999999=20
bgColor=3D#ffffff><![if !supportLineBreakNewLine]><![endif]><![if =
!supportEmptyParas]><![endif]>
<DIV>Hi Paolo,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Looking into another issue (my son's gaming machine - =
counter-strike source=20
on linux) I came across this interesting parameter whereby winex/Cedega =
won't=20
run steam unless legacy support for legacy VA layout is enabled on a =
2.6.9=20
kernel.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Well, I thought, I'd better try that out......</DIV>
<DIV>&nbsp;</DIV>
<DIV>With 2.6.12+bs9 on x86_64 the error now changes</DIV>
<DIV>&nbsp;</DIV>
<DIV>On the host set:</DIV>
<DIV>sysctl -w va.legacy_va_layout=3D1</DIV>
<DIV>sysctl -w kernel.randomize_va_space=3D0</DIV>
<DIV>&nbsp;</DIV>
<DIV>Starting the uml with init=3D/bin/sh starts up as usual. Performing =
the ls=20
command now result in a different thing happening:</DIV>
<DIV>Bad op in do_proc_op</DIV>
<DIV>&nbsp;</DIV>
<DIV>Where as before it produced:</DIV>
<DIV>Child 22915 exited with signal 11<BR><BR>Furthermore, Ctrl-C shuts=20
everything down cleanly. Don't the significance if any of all this, but =
if feels=20
better.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Conducting the same test on 32bit 2.6.12+bs9 results in total =
disaster=20
(feels very bad):</DIV>
<DIV>&nbsp;</DIV>
<DIV>&lt;0&gt;Kernel panic - not syncing: fix_range fixing wrong address =
space,=20
current=3D0xabebf6c0</DIV>
<DIV>folloed by lost of register dumps and traceback stuff (2 lots =
actually -=20
which I take to mean it really really crashed).</DIV>
<DIV>&nbsp;</DIV>
<DIV>I can only get init=3D/bin/sh to go when =
kernel.randomize_va_space=3D1 and=20
vm.legacy_va_layout=3D0</DIV>
<DIV>Running the ls command then results in a message similar to:</DIV>
<DIV>Child 22915 exited with signal 11</DIV>
<DIV>&nbsp;</DIV>
<DIV>Perhaps the only thing of value in all this is va.legacy_va_layout =
which=20
may be useful to UML. It seems to do something, I just don't know =
what.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Cheers</DIV>
<DIV>Phill.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&gt;Hi Paolo,<BR>&gt;<BR>&gt;&gt;Try also following this (from =
another=20
email) - it appeared in vanilla<BR>&gt;&gt;2.6.12 <BR>&gt;&gt;and may be =
in your=20
FC4 kernel. Not sure but it may be playing a=20
role<BR>&gt;&gt;here:<BR>&gt;&gt;<BR>&gt;&gt;"It looks like VA space=20
randomization is the culprit.&nbsp; The problem only<BR>&gt;&gt;shows up =
when=20
the host is 2.6.12, and can be solved by setting=20
the<BR>&gt;&gt;kernel.randomize_va_space sysctl to zero.&nbsp; Thanks =
for the=20
pointer<BR>&gt;&gt;there."<BR>&gt;<BR>&gt;Here are the results with =
sysctl -w=20
kernel.randomize_va_space=3D0.<BR>&gt;Essentially no effect=20
observed.<BR><BR></DIV></BODY></HTML>

------=_NextPart_000_003B_01C59698.0A1FAA90--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

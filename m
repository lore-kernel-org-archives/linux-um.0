Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <madhurjf@yahoo.com>) id 1YcUnl-0007xL-Bb
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Mar 2015 08:12:05 +0000
Received: from nm18-vm3.bullet.mail.sg3.yahoo.com ([106.10.149.98])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YcUnj-0004Uk-Qt
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Mar 2015 08:12:05 +0000
Date: Mon, 30 Mar 2015 08:11:42 +0000 (UTC)
From: madhusudan r <madhurjf@yahoo.com>
Message-ID: <1820010598.668456.1427703102065.JavaMail.yahoo@mail.yahoo.com>
MIME-Version: 1.0
Reply-To: madhusudan r <madhurjf@yahoo.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4239906401082469173=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] UML Interfaces
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--===============4239906401082469173==
Content-Type: multipart/alternative; 
	boundary="----=_Part_668455_2124443790.1427703102063"
Content-Length: 1591

------=_Part_668455_2124443790.1427703102063
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,
I would like to know if the User Mode linux creates (and initialises) 'stru=
ct uml_net_private' for every interface device on it? To be specific, if th=
ere are multiple l2tpv3 tunnels on the UML, does it warrant the creation of=
 as many 'dev's, and consequently associate it with a corresponding 'uml_ne=
t_private'?
Thanks,Madhu=C2=A0
------=_Part_668455_2124443790.1427703102063
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><body><div style="color:#000; background-color:#fff; font-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, Sans-Serif;font-size:16px"><div dir="ltr" id="yui_3_16_0_1_1427702638127_16347">Hi,</div><div dir="ltr" id="yui_3_16_0_1_1427702638127_16282"><br></div><div dir="ltr" id="yui_3_16_0_1_1427702638127_16263">I would like to know if the User Mode linux creates (and initialises) 'struct uml_net_private' for every interface device on it? To be specific, if there are multiple l2tpv3 tunnels on the UML, does it warrant the creation of as many 'dev's, and consequently associate it with a corresponding 'uml_net_private'?</div><div dir="ltr" id="yui_3_16_0_1_1427702638127_16263"><br></div><div dir="ltr" id="yui_3_16_0_1_1427702638127_16263">Thanks,</div><div dir="ltr" id="yui_3_16_0_1_1427702638127_16263">Madhu</div><div dir="ltr" id="yui_3_16_0_1_1427702638127_16263" class="" style="">&nbsp;</div></div></body></html>
------=_Part_668455_2124443790.1427703102063--


--===============4239906401082469173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
--===============4239906401082469173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============4239906401082469173==--



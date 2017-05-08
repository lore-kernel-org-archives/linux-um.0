Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
References: <8EF94724-26BB-423D-B75F-1CF6646F72C3@m3y3r.de>
	<CAFLxGvyHNTgYm6FP1LUFV4TSTna4aHTfV+4rEfv55-s0W_9uxA@mail.gmail.com>
	<20170508170235.Horde.YC-JKHq_morEKrQOv2d0DV3@webmail.your-server.de>
	<d46e744a-da30-fe81-fb4d-2a4648550a27@nod.at>
Mime-Version: 1.0 (1.0)
In-Reply-To: <d46e744a-da30-fe81-fb4d-2a4648550a27@nod.at>
Message-Id: <76397EFF-15DB-4F55-B402-DBE7BA1FB02D@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Mon, 8 May 2017 17:32:26 +0200
Subject: Re: [uml-devel] [uml-user] UML on WSL
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2328220073079753094=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net


--===============2328220073079753094==
Content-Type: multipart/alternative;
	boundary=Apple-Mail-B197C420-B404-40F8-8EA2-954D8BA75220
Content-Transfer-Encoding: 7bit


--Apple-Mail-B197C420-B404-40F8-8EA2-954D8BA75220
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable


> Am 08.05.2017 um 17:05 schrieb Richard Weinberger <richard@nod.at>:
>=20
> Thomas,
>=20
>> Am 08.05.2017 um 17:02 schrieb Thomas Meyer:
>> Sadly, UML executable bails out very early. it Looks like WSL is missing s=
ome PTRACE stuff:
>>=20
>> thomas@DESKTOP-DQBDJ0U:/mnt/c/Users/thomas/Downloads$ ./linux
>> Core dump limits :
>>        soft - NONE
>>        hard - NONE
>> Checking that ptrace can change system call numbers...check_ptrace: PTRAC=
E_OLDSETOPTIONS failed: Invalid Argument
>=20
> We could figure how to report issues to WSL, create self-hosting unit test=
s and ask them to add/fix
> these features.

Turns out there was already a bug report by somebody about missing UML suppo=
rt in WSL:

https://github.com/Microsoft/BashOnWindows/issues/1692

>=20
> Thanks,
> //richard
>=20
> --------------------------------------------------------------------------=
----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Apple-Mail-B197C420-B404-40F8-8EA2-954D8BA75220
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><div><br></div><div>Am 08.05.2017 um 17:05 s=
chrieb Richard Weinberger &lt;<a href=3D"mailto:richard@nod.at">richard@nod.=
at</a>&gt;:<br><br></div><blockquote type=3D"cite"><div><span>Thomas,</span>=
<br><span></span><br><span>Am 08.05.2017 um 17:02 schrieb Thomas Meyer:</spa=
n><br><blockquote type=3D"cite"><span>Sadly, UML executable bails out very e=
arly. it Looks like WSL is missing some PTRACE stuff:</span><br></blockquote=
><blockquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D=
"cite"><span>thomas@DESKTOP-DQBDJ0U:/mnt/c/Users/thomas/Downloads$ ./linux</=
span><br></blockquote><blockquote type=3D"cite"><span>Core dump limits :</sp=
an><br></blockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;soft - NONE</span><br></blockquote><blockquote type=3D"ci=
te"><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hard - NONE</span><br><=
/blockquote><blockquote type=3D"cite"><span>Checking that ptrace can change s=
ystem call numbers...check_ptrace: PTRACE_OLDSETOPTIONS failed: Invalid Argu=
ment</span><br></blockquote><span></span><br><span>We could figure how to re=
port issues to WSL, create self-hosting unit tests and ask them to add/fix</=
span><br><span>these features.</span><br></div></blockquote><div><br></div>T=
urns out there was already a bug report by somebody about missing UML suppor=
t in WSL:<div><br></div><div><a href=3D"https://github.com/Microsoft/BashOnW=
indows/issues/1692">https://github.com/Microsoft/BashOnWindows/issues/1692</=
a></div><div><br><blockquote type=3D"cite"><div><span></span><br><span>Thank=
s,</span><br><span>//richard</span><br><span></span><br><span>--------------=
----------------------------------------------------------------</span><br><=
span>Check out the vibrant tech community on one of the world's most</span><=
br><span>engaging tech sites, <a href=3D"http://slashdot.org">Slashdot.org</=
a>! <a href=3D"http://sdm.link/slashdot">http://sdm.link/slashdot</a></span>=
<br><span>_______________________________________________</span><br><span>Us=
er-mode-linux-devel mailing list</span><br><span><a href=3D"mailto:User-mode=
-linux-devel@lists.sourceforge.net">User-mode-linux-devel@lists.sourceforge.=
net</a></span><br><span><a href=3D"https://lists.sourceforge.net/lists/listi=
nfo/user-mode-linux-devel">https://lists.sourceforge.net/lists/listinfo/user=
-mode-linux-devel</a></span><br></div></blockquote></div></body></html>=

--Apple-Mail-B197C420-B404-40F8-8EA2-954D8BA75220--


--===============2328220073079753094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============2328220073079753094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2328220073079753094==--



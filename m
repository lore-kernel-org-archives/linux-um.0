Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
References: <8EF94724-26BB-423D-B75F-1CF6646F72C3@m3y3r.de>
	<CAFLxGvyHNTgYm6FP1LUFV4TSTna4aHTfV+4rEfv55-s0W_9uxA@mail.gmail.com>
	<20170508170235.Horde.YC-JKHq_morEKrQOv2d0DV3@webmail.your-server.de>
	<d46e744a-da30-fe81-fb4d-2a4648550a27@nod.at>
	<76397EFF-15DB-4F55-B402-DBE7BA1FB02D@m3y3r.de>
	<3f832424-0ae6-1009-cf87-c94794e919ef@nod.at>
Mime-Version: 1.0 (1.0)
In-Reply-To: <3f832424-0ae6-1009-cf87-c94794e919ef@nod.at>
Message-Id: <0419DC3A-B4B7-4005-B068-EF0583433B92@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Mon, 8 May 2017 17:40:17 +0200
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
Content-Type: multipart/mixed; boundary="===============0317526955377450030=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net


--===============0317526955377450030==
Content-Type: multipart/alternative;
	boundary=Apple-Mail-2DDDB2AA-238B-4D9F-B900-C054924720D2
Content-Transfer-Encoding: 7bit


--Apple-Mail-2DDDB2AA-238B-4D9F-B900-C054924720D2
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable


> Am 08.05.2017 um 17:35 schrieb Richard Weinberger <richard@nod.at>:
>=20
> Thomas,
>=20
> Am 08.05.2017 um 17:32 schrieb Thomas Meyer:
>>> We could figure how to report issues to WSL, create self-hosting unit te=
sts and ask them to add/fix
>>> these features.
>>=20
>> Turns out there was already a bug report by somebody about missing UML su=
pport in WSL:
>>=20
>> https://github.com/Microsoft/BashOnWindows/issues/1692
>=20
> Ah, there are tons of ptrace() features missing.
> UML is a major user of ptrace(), worse than GDB. ;-\

Yes, I know.

Probably also worh quoting the discussion from the relevant GH issue regardi=
ng OLDPTRACE :

"
Also, for a little context, the onlysoftware I can find on the planet that c=
ares is User Mode Linux. Unless someone tries to run some statically linked s=
trace or maybe gdb binary from the 2.4 era, this will simply never be hit on=
 WSL in 2017. UML seems to still care, entirely academically, to maintain bi=
nary compatibility with 2.4. You can think of it as UML never buying into th=
e idea the value changed, while everyone else moved"

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

--Apple-Mail-2DDDB2AA-238B-4D9F-B900-C054924720D2
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><div><br></div><div>Am 08.05.2017 um 17:35 s=
chrieb Richard Weinberger &lt;<a href=3D"mailto:richard@nod.at">richard@nod.=
at</a>&gt;:<br><br></div><blockquote type=3D"cite"><div><span>Thomas,</span>=
<br><span></span><br><span>Am 08.05.2017 um 17:32 schrieb Thomas Meyer:</spa=
n><br><blockquote type=3D"cite"><blockquote type=3D"cite"><span>We could fig=
ure how to report issues to WSL, create self-hosting unit tests and ask them=
 to add/fix</span><br></blockquote></blockquote><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><span>these features.</span><br></blockquote></block=
quote><blockquote type=3D"cite"><span></span><br></blockquote><blockquote ty=
pe=3D"cite"><span>Turns out there was already a bug report by somebody about=
 missing UML support in WSL:</span><br></blockquote><blockquote type=3D"cite=
"><span></span><br></blockquote><blockquote type=3D"cite"><span><a href=3D"h=
ttps://github.com/Microsoft/BashOnWindows/issues/1692">https://github.com/Mi=
crosoft/BashOnWindows/issues/1692</a></span><br></blockquote><span></span><b=
r><span>Ah, there are tons of ptrace() features missing.</span><br><span>UML=
 is a major user of ptrace(), worse than GDB. ;-\</span><br></div></blockquo=
te><div><br></div>Yes, I know.<div><br></div><div>Probably also worh quoting=
 the discussion from the relevant GH issue regarding OLDPTRACE :</div><div><=
br></div><div>"</div><div><span style=3D"background-color: rgba(255, 255, 25=
5, 0);">Also, for a little context, the&nbsp;<em style=3D"box-sizing: border=
-box;">only</em>software I can find&nbsp;<em style=3D"box-sizing: border-box=
;">on the planet</em>&nbsp;that cares is User Mode Linux. Unless someone tri=
es to run some statically linked&nbsp;<code style=3D"box-sizing: border-box;=
 padding: 0.2em 0px; margin: 0px; border-top-left-radius: 3px; border-top-ri=
ght-radius: 3px; border-bottom-right-radius: 3px; border-bottom-left-radius:=
 3px;">strace</code>&nbsp;or maybe&nbsp;<code style=3D"box-sizing: border-bo=
x; padding: 0.2em 0px; margin: 0px; border-top-left-radius: 3px; border-top-=
right-radius: 3px; border-bottom-right-radius: 3px; border-bottom-left-radiu=
s: 3px;">gdb</code>&nbsp;binary from the 2.4 era, this will simply never be h=
it on WSL in 2017. UML seems to still care, entirely academically, to mainta=
in binary compatibility with 2.4. You can think of it as UML never buying in=
to the idea the value changed, while everyone else moved"</span></div><div><=
br><blockquote type=3D"cite"><div><span></span><br><span>Thanks,</span><br><=
span>//richard</span><br><span></span><br><span>----------------------------=
--------------------------------------------------</span><br><span>Check out=
 the vibrant tech community on one of the world's most</span><br><span>engag=
ing tech sites, <a href=3D"http://slashdot.org">Slashdot.org</a>! <a href=3D=
"http://sdm.link/slashdot">http://sdm.link/slashdot</a></span><br><span>____=
___________________________________________</span><br><span>User-mode-linux-=
devel mailing list</span><br><span><a href=3D"mailto:User-mode-linux-devel@l=
ists.sourceforge.net">User-mode-linux-devel@lists.sourceforge.net</a></span>=
<br><span><a href=3D"https://lists.sourceforge.net/lists/listinfo/user-mode-=
linux-devel">https://lists.sourceforge.net/lists/listinfo/user-mode-linux-de=
vel</a></span><br></div></blockquote></div></body></html>=

--Apple-Mail-2DDDB2AA-238B-4D9F-B900-C054924720D2--


--===============0317526955377450030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============0317526955377450030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0317526955377450030==--



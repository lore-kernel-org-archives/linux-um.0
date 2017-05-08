Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
References: <8EF94724-26BB-423D-B75F-1CF6646F72C3@m3y3r.de>
	<CAFLxGvyHNTgYm6FP1LUFV4TSTna4aHTfV+4rEfv55-s0W_9uxA@mail.gmail.com>
	<20170508170235.Horde.YC-JKHq_morEKrQOv2d0DV3@webmail.your-server.de>
	<d46e744a-da30-fe81-fb4d-2a4648550a27@nod.at>
	<76397EFF-15DB-4F55-B402-DBE7BA1FB02D@m3y3r.de>
	<3f832424-0ae6-1009-cf87-c94794e919ef@nod.at>
	<0419DC3A-B4B7-4005-B068-EF0583433B92@m3y3r.de>
Mime-Version: 1.0 (1.0)
In-Reply-To: <0419DC3A-B4B7-4005-B068-EF0583433B92@m3y3r.de>
Message-Id: <D39536F2-909A-40FB-B47F-44A31C56D286@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Mon, 8 May 2017 18:09:57 +0200
Subject: Re: [uml-devel] [uml-user]   UML on WSL
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7870380361871486807=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net


--===============7870380361871486807==
Content-Type: multipart/alternative;
	boundary=Apple-Mail-ACC481AB-43DD-4E45-835E-8B5271688270
Content-Transfer-Encoding: 7bit


--Apple-Mail-ACC481AB-43DD-4E45-835E-8B5271688270
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable


> Am 08.05.2017 um 17:40 schrieb Thomas Meyer <thomas@m3y3r.de>:
>=20
>=20
>> Am 08.05.2017 um 17:35 schrieb Richard Weinberger <richard@nod.at>:
>>=20
>> Thomas,
>>=20
>> Am 08.05.2017 um 17:32 schrieb Thomas Meyer:
>>>> We could figure how to report issues to WSL, create self-hosting unit t=
ests and ask them to add/fix
>>>> these features.
>>>=20
>>> Turns out there was already a bug report by somebody about missing UML s=
upport in WSL:
>>>=20
>>> https://github.com/Microsoft/BashOnWindows/issues/1692
>>=20
>> Ah, there are tons of ptrace() features missing.
>> UML is a major user of ptrace(), worse than GDB. ;-\
>=20
> Yes, I know.
>=20
> Probably also worh quoting the discussion from the relevant GH issue regar=
ding OLDPTRACE :
>=20
> "
> Also, for a little context, the onlysoftware I can find on the planet that=
 cares is User Mode Linux. Unless someone tries to run some statically linke=
d strace or maybe gdb binary from the 2.4 era, this will simply never be hit=
 on WSL in 2017. UML seems to still care, entirely academically, to maintain=
 binary compatibility with 2.4. You can think of it as UML never buying into=
 the idea the value changed, while everyone else moved"
>=20

Or asked he other way around:

Is somewhere documented what's the minimum host kernel version that a UML ke=
rnel will run on?

E.g.:
building a UML kernel from 4.11 will need a host kernel version 2.6.18 with f=
eatures x, y and z enabled?

>>=20
>> Thanks,
>> //richard
>>=20
>> -------------------------------------------------------------------------=
-----
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> User-mode-linux-devel mailing list
>> User-mode-linux-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> --------------------------------------------------------------------------=
----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user

--Apple-Mail-ACC481AB-43DD-4E45-835E-8B5271688270
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><div><br></div><div>Am 08.05.2017 um 17:40 s=
chrieb Thomas Meyer &lt;<a href=3D"mailto:thomas@m3y3r.de">thomas@m3y3r.de</=
a>&gt;:<br><br></div><blockquote type=3D"cite"><div><meta http-equiv=3D"cont=
ent-type" content=3D"text/html; charset=3Dutf-8"><div><br></div><div>Am 08.0=
5.2017 um 17:35 schrieb Richard Weinberger &lt;<a href=3D"mailto:richard@nod=
.at">richard@nod.at</a>&gt;:<br><br></div><blockquote type=3D"cite"><div><sp=
an>Thomas,</span><br><span></span><br><span>Am 08.05.2017 um 17:32 schrieb T=
homas Meyer:</span><br><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span>We could figure how to report issues to WSL, create self-hosting unit t=
ests and ask them to add/fix</span><br></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span>these features.</span><br></b=
lockquote></blockquote><blockquote type=3D"cite"><span></span><br></blockquo=
te><blockquote type=3D"cite"><span>Turns out there was already a bug report b=
y somebody about missing UML support in WSL:</span><br></blockquote><blockqu=
ote type=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><s=
pan><a href=3D"https://github.com/Microsoft/BashOnWindows/issues/1692">https=
://github.com/Microsoft/BashOnWindows/issues/1692</a></span><br></blockquote=
><span></span><br><span>Ah, there are tons of ptrace() features missing.</sp=
an><br><span>UML is a major user of ptrace(), worse than GDB. ;-\</span><br>=
</div></blockquote><div><br></div>Yes, I know.<div><br></div><div>Probably a=
lso worh quoting the discussion from the relevant GH issue regarding OLDPTRA=
CE :</div><div><br></div><div>"</div><div><span style=3D"background-color: r=
gba(255, 255, 255, 0);">Also, for a little context, the&nbsp;<em style=3D"bo=
x-sizing: border-box;">only</em>software I can find&nbsp;<em style=3D"box-si=
zing: border-box;">on the planet</em>&nbsp;that cares is User Mode Linux. Un=
less someone tries to run some statically linked&nbsp;<code style=3D"box-siz=
ing: border-box; padding: 0.2em 0px; margin: 0px; border-top-left-radius: 3p=
x; border-top-right-radius: 3px; border-bottom-right-radius: 3px; border-bot=
tom-left-radius: 3px;">strace</code>&nbsp;or maybe&nbsp;<code style=3D"box-s=
izing: border-box; padding: 0.2em 0px; margin: 0px; border-top-left-radius: 3=
px; border-top-right-radius: 3px; border-bottom-right-radius: 3px; border-bo=
ttom-left-radius: 3px;">gdb</code>&nbsp;binary from the 2.4 era, this will s=
imply never be hit on WSL in 2017. UML seems to still care, entirely academi=
cally, to maintain binary compatibility with 2.4. You can think of it as UML=
 never buying into the idea the value changed, while everyone else moved"</s=
pan></div><div><br></div></div></blockquote><div><br></div>Or asked he other=
 way around:<div><br></div><div>Is somewhere documented what's the minimum h=
ost kernel version that a UML kernel will run on?</div><div><br></div><div>E=
.g.:</div><div>building a UML kernel from 4.11 will need a host kernel versi=
on 2.6.18 with features x, y and z enabled?</div><div><br><blockquote type=3D=
"cite"><div><div><blockquote type=3D"cite"><div><span></span><br><span>Thank=
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
-mode-linux-devel</a></span><br></div></blockquote></div></div></blockquote>=
<blockquote type=3D"cite"><div><span>---------------------------------------=
---------------------------------------</span><br><span>Check out the vibran=
t tech community on one of the world's most</span><br><span>engaging tech si=
tes, <a href=3D"http://slashdot.org">Slashdot.org</a>! <a href=3D"http://sdm=
.link/slashdot">http://sdm.link/slashdot</a></span></div></blockquote><block=
quote type=3D"cite"><div><span>_____________________________________________=
__</span><br><span>User-mode-linux-user mailing list</span><br><span><a href=
=3D"mailto:User-mode-linux-user@lists.sourceforge.net">User-mode-linux-user@=
lists.sourceforge.net</a></span><br><span><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/user-mode-linux-user">https://lists.sourceforge.net/li=
sts/listinfo/user-mode-linux-user</a></span><br></div></blockquote></div></b=
ody></html>=

--Apple-Mail-ACC481AB-43DD-4E45-835E-8B5271688270--


--===============7870380361871486807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============7870380361871486807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============7870380361871486807==--



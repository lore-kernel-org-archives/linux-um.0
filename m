Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <james_mcmechan@hotmail.com>) id 1TI0t8-0006VN-B1
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Sep 2012 17:31:38 +0000
Received: from col0-omc2-s4.col0.hotmail.com ([65.55.34.78])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TI0t7-0004dL-Ix for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Sep 2012 17:31:38 +0000
Message-ID: <COL101-W596EE5B44B0F26AE2B404EE2810@phx.gbl>
From: James McMechan <james_mcmechan@hotmail.com>
Date: Sat, 29 Sep 2012 10:31:31 -0700
In-Reply-To: <1348702738.50639212c887a@postoffice.tpg.com.au>
References: <1348702738.50639212c887a@postoffice.tpg.com.au>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2367295709809415880=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] strange behaviour of ubd
To: nippur@tpg.com.au, uml devel <user-mode-linux-devel@lists.sourceforge.net>

--===============2367295709809415880==
Content-Type: multipart/alternative;
	boundary="_24c9407b-ad87-4988-8e6b-1042fe83d22a_"

--_24c9407b-ad87-4988-8e6b-1042fe83d22a_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> Date: Thu=2C 27 Sep 2012 09:38:58 +1000
> From: nippur@tpg.com.au
> To: James_McMechan@hotmail.com
> Subject: strange behaviour of ubd
>=20
> Hello James=2C
> I have been using User Mode Linux since 2004 as virtual lab for studying.
> I have always used ubdb=2Cc=2Cd and so on to have more than a "bare" file=
 system
> to play with: a good file system without an access to a cdrom=2Cdvd=2Cusb=
 and so
> on is not very interesting ( and Internet is not always available).
> I am a little frustrated because "ubd" is working only for "root_fs" : no

It appears that you are backing your ubd device with a physical drive

Nothing wrong with that=2C but it is not a case I use much=2C
you should be able to use any virtual block device not backed directly to h=
ardware
virtual drives that are mapped to hardware it appears may need to be fixed =
to
use an alternate method of finding out how big the drive is and possibly fi=
xing
up the special ioctl calls like eject.

> cdrom=2C no dvd and so on ( I am using debian squeeze 64bit). I have veri=
fied
> similar behavior with debian testing (kernel 3.2.x). I have been playing =
with
> every combination of parameter of activation.
> The result : linux ubda=3Droot_fs ubdb=3D/dev/cdrom does not work AT ALL.

I will have to try this=2C is it only ubdb that is failing or does it take =
down ubda also?

> It worked=2C I have already used with kernel 2.4.x.
>=20
It used to work when the host system was running 2.4.x for example debian
running on a real machine and running a UML on top. Correct?
I have run very recent kernels on top of very old host systems. A 2.4.18 ho=
st
for example=2C running a 3.2 UML on top. =20

>=20
> Internet is full of crappy/obsolete stuff.
> Everyone is avoiding (on purpose i guess) to talk about this: only exampl=
es
> about swap !!!=20
>=20
No=2C I expect people just don't think to do it this way very often.
Last time I backed with physical drives I had a 30 drive RAID array that wa=
s
throwing ICRC errors every day or so and dropping a drive. Since ICRC is
basically harmless (checksum error on a IDE/SATA cable=2C it retries) this =
was
a hassle for no gain so I ran my recovery inside a UML since it could not t=
o it
in a read only fashion before another ICRC came in and broke the entire=20
RAID array.

> I am writing to you because I have found a "dirty" trick and it is workin=
g
> better than expected.
>=20
> file : ubd_kern.c   function ubd_add ( )  line number 831  : I have simpl=
y
> enclosed the goto in a comment.
>=20
>=20
>=20
> 833         err =3D ubd_file_size(ubd_dev=2C &ubd_dev->size)=3B
> 834         if(err < 0){
> 835                 *error_out =3D "Couldn't determine size of device's f=
ile"=3B
> 836             /*    goto out=3B */  MODIFIED by me  !!!!
> 837         }
> 838
>=20
Yes=2C we should have a better solution however.
Maybe checking the errno and trying a different command to
find the drive size on physical drives (or virtual drives in a enclosing um=
l)

> well ... is working bloody well.
>=20
> If you want I can be more accurate  if this is not enough for you .... ?!=
?!
> Please fix this problem ( ... mine is just a trick=2C of course).
>=20
> Thanks for your attention.
> Kind Regards.
>=20
> Sal Poleo
>=20
> p.s. : I am a really good fan of this project.
>=20
Glad to see that others are still using it too.
I like it also=2C and use it for hours=2C most days.

Jim McMechan
 		 	   		  =

--_24c9407b-ad87-4988-8e6b-1042fe83d22a_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
&gt=3B Date: Thu=2C 27 Sep 2012 09:38:58 +1000<br><div>&gt=3B From: nippur@=
tpg.com.au<br>&gt=3B To: James_McMechan@hotmail.com<br>&gt=3B Subject: stra=
nge behaviour of ubd<br>&gt=3B <br>&gt=3B Hello James=2C<br>&gt=3B I have b=
een using User Mode Linux since 2004 as virtual lab for studying.<br>&gt=3B=
 I have always used ubdb=2Cc=2Cd and so on to have more than a "bare" file =
system<br>&gt=3B to play with: a good file system without an access to a cd=
rom=2Cdvd=2Cusb and so<br>&gt=3B on is not very interesting ( and Internet =
is not always available).<br>&gt=3B I am a little frustrated because "ubd" =
is working only for "root_fs" : no<br><br>It appears that you are backing y=
our ubd device with a physical drive<br>
Nothing wrong with that=2C but it is not a case I use much=2C<br>you should=
 be able to use any virtual block device not backed directly to hardware<br=
>virtual drives that are mapped to hardware it appears may need to be fixed=
 to<br>use an alternate method of finding out how big the drive is and poss=
ibly fixing<br>up the special ioctl calls like eject.<br><br>&gt=3B cdrom=
=2C no dvd and so on ( I am using debian squeeze 64bit). I have verified<br=
>&gt=3B similar behavior with debian testing (kernel 3.2.x). I have been pl=
aying with<br>&gt=3B every combination of parameter of activation.<br>&gt=
=3B The result : linux ubda=3Droot_fs ubdb=3D/dev/cdrom does not work AT AL=
L.<br><br>I will have to try this=2C is it only ubdb that is failing or doe=
s it take down ubda also?<br><br>&gt=3B It worked=2C I have already used wi=
th kernel 2.4.x.<br>&gt=3B <br>It used to work when the host system was run=
ning 2.4.x for example debian<br>running on a real machine and running a UM=
L on top. Correct?<br>I have run very recent kernels on top of very old hos=
t systems. A 2.4.18 host<br>for example=2C running a 3.2 UML on top.&nbsp=
=3B <br><br>&gt=3B <br>&gt=3B Internet is full of crappy/obsolete stuff.<br=
>&gt=3B Everyone is avoiding (on purpose i guess) to talk about this: only =
examples<br>&gt=3B about swap !!! <br>&gt=3B <br>No=2C I expect people just=
 don't think to do it this way very often.<br>Last time I backed with physi=
cal drives I had a 30 drive RAID array that was<br>throwing ICRC errors eve=
ry day or so and dropping a drive. Since ICRC is<br>basically harmless (che=
cksum error on a IDE/SATA cable=2C it retries) this was<br>a hassle for no =
gain so I ran my recovery inside a UML since it could not to it<br>in a rea=
d only fashion before another ICRC came in and broke the entire <br>RAID ar=
ray.<br><br>&gt=3B I am writing to you because I have found a "dirty" trick=
 and it is working<br>&gt=3B better than expected.<br>&gt=3B <br>&gt=3B fil=
e : ubd_kern.c   function ubd_add ( )  line number 831  : I have simply<br>=
&gt=3B enclosed the goto in a comment.<br>&gt=3B <br>&gt=3B <br>&gt=3B <br>=
&gt=3B 833         err =3D ubd_file_size(ubd_dev=2C &amp=3Bubd_dev-&gt=3Bsi=
ze)=3B<br>&gt=3B 834         if(err &lt=3B 0){<br>&gt=3B 835               =
  *error_out =3D "Couldn't determine size of device's file"=3B<br>&gt=3B 83=
6             /*    goto out=3B */  MODIFIED by me  !!!!<br>&gt=3B 837     =
    }<br>&gt=3B 838<br>&gt=3B <br>Yes=2C we should have a better solution h=
owever.<br>Maybe checking the errno and trying a different command to<br>fi=
nd the drive size on physical drives (or virtual drives in a enclosing uml)=
<br><br>&gt=3B well ... is working bloody well.<br>&gt=3B <br>&gt=3B If you=
 want I can be more accurate  if this is not enough for you .... ?!?!<br>&g=
t=3B Please fix this problem ( ... mine is just a trick=2C of course).<br>&=
gt=3B <br>&gt=3B Thanks for your attention.<br>&gt=3B Kind Regards.<br>&gt=
=3B <br>&gt=3B Sal Poleo<br>&gt=3B <br>&gt=3B p.s. : I am a really good fan=
 of this project.<br>&gt=3B <br>Glad to see that others are still using it =
too.<br>I like it also=2C and use it for hours=2C most days.<br><br>Jim McM=
echan<br></div> 		 	   		  </div></body>
</html>=

--_24c9407b-ad87-4988-8e6b-1042fe83d22a_--


--===============2367295709809415880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
How fast is your code?
3 out of 4 devs don\\\'t know how their code performs in production.
Find out how slow your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219672;13503038;z?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
--===============2367295709809415880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2367295709809415880==--



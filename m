Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPzWt-0000Ur-5R for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 01:00:51 -0700
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BPzWs-00053P-Aq for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 01:00:50 -0700
Message-ID: <058d01c43caf$37167ae0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.44.0405180141460.28239-100000@filer.marasystems.com>
	<40A9970F.9060201@netd.com>
Subject: Re: [uml-devel] how to do programming in UML
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_058A_01C43CBF.F9DD3360"
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
Date: Tue, 18 May 2004 10:07:50 +0200
To: pronoy debnath <pdebnath@netd.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.

------=_NextPart_000_058A_01C43CBF.F9DD3360
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

hi!
>    The root_fs, I am using for uml, does not contain gcc.
you can install gcc inside your uml!

>Is it possible to compile a program using host machine's gcc and =
libraries?
you mean, you want to use the host machinse gcc and libraries inside =
uml? (by hosfs mount or whatever?)
no - i wouldn`t recommend that.
you can compile your stuff outside your uml on the host itself and =
transfer the binaries to the uml afterwards - you just need to make sure =
that your host and your uml(root_fs) OS-version don`t differ too much - =
otherwise you will get problems with library dependency (that`s just the =
same issue as if you compile on a redhat 9 and transfer the binaries to =
a suse 6.4 :)

>If yes, how can I do it?
just as usual?
configurer
make
make install.....

regards
roland


  ----- Original Message -----=20
  From: pronoy debnath=20
  Cc: user-mode-linux-devel@lists.sourceforge.net=20
  Sent: Tuesday, May 18, 2004 6:54 AM
  Subject: [uml-devel] how to do programming in UML



  Hi,
      The root_fs, I am using for uml, does not contain gcc.
     =20
       Is it possible to compile a program using host machine's gcc and =
libraries?
       If yes, how can I do it?

  Thanks,
  Pronoy


  Henrik Nordstrom wrote:

On Mon, 17 May 2004, Joe Marzot wrote:

  A little more data on this one - the behaviour I see with these mounts =

is that

mount -t hostfs none /mnt/mybob -o /view/myview/vob/myvob

succeeds but mounts the hosts / dir instead of the desired view extended =

pathname of the ClearCase vob.
   =20
This is a known bug in 2.4.24-2. A patch can be found in the archives or =

from http://marasystems.com/download/uml/

If you need hostfs then you should probably stick to 2.4.24-1 for the =
time
being. Jeff is doing some heavy restructuring of the uml host file =
access
methods while adding the humfs and as a result of this the hostfs =
support
has become very unstable while the combined supporting framework for =
humfs
and hostfs is taking shape. Hopefully this will soon result in a much=20
better hostfs than before, but at the moment things is a bit shaky..

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=3D2562&alloc_id=3D6184&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
  
------=_NextPart_000_058A_01C43CBF.F9DD3360
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE></TITLE>
<META http-equiv=3DContent-Type =
content=3Dtext/html;charset=3DISO-8859-1>
<META content=3D"MSHTML 6.00.2800.1226" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY text=3D#000000 bgColor=3D#ffffff>
<DIV><FONT face=3DArial>hi!</FONT></DIV>
<DIV><FONT face=3DArial>&gt;&nbsp;&nbsp;&nbsp; The root_fs, I am using =
for uml,=20
does not contain gcc.</FONT></DIV>
<DIV><FONT face=3DArial>you can install gcc inside your =
uml!<BR></FONT><FONT=20
face=3DArial></FONT></DIV>
<DIV><FONT face=3DArial>&gt;Is it possible to compile a program using =
host=20
machine's gcc and libraries?</FONT></DIV>
<DIV><FONT face=3DArial>you mean, you want to use the host machinse gcc =
and=20
libraries inside uml? (by hosfs mount or whatever?)</FONT></DIV>
<DIV><FONT face=3DArial>no - i wouldn`t recommend that.<BR>you can =
compile your=20
stuff outside your uml on the host itself and transfer the binaries to =
the uml=20
afterwards&nbsp;- you just need to make sure that your host and your=20
uml(root_fs) OS-version don`t differ too much - otherwise you will get =
problems=20
with library dependency (that`s just the same issue as if you compile on =
a=20
redhat 9 and transfer the binaries to a suse 6.4 :)</FONT></DIV>
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial>&gt;If yes, how can I do it?</FONT></DIV>
<DIV><FONT face=3DArial>just as usual?</FONT></DIV>
<DIV><FONT face=3DArial>configurer</FONT></DIV>
<DIV><FONT face=3DArial>make</FONT></DIV>
<DIV><FONT face=3DArial>make install.....</FONT></DIV>
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial>regards</FONT></DIV>
<DIV><FONT face=3DArial>roland</FONT></DIV>
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2></FONT>&nbsp;</DIV></FONT>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dpdebnath@netd.com href=3D"mailto:pdebnath@netd.com">pronoy =
debnath</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Cc:</B> <A=20
  title=3Duser-mode-linux-devel@lists.sourceforge.net=20
  =
href=3D"mailto:user-mode-linux-devel@lists.sourceforge.net">user-mode-lin=
ux-devel@lists.sourceforge.net</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Tuesday, May 18, 2004 =
6:54 AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> [uml-devel] how to do=20
  programming in UML</DIV>
  <DIV><BR></DIV><BR>Hi,<BR>&nbsp;&nbsp;&nbsp; The root_fs, I am using =
for uml,=20
  does not contain gcc.<BR>&nbsp;&nbsp;&nbsp; =
<BR>&nbsp;&nbsp;&nbsp;&nbsp; Is it=20
  possible to compile a program using host machine's gcc and=20
  libraries?<BR>&nbsp;&nbsp;&nbsp;&nbsp; If yes, how can I do=20
  it?<BR><BR>Thanks,<BR>Pronoy<BR><BR><BR>Henrik Nordstrom wrote:<BR>
  <BLOCKQUOTE=20
  =
cite=3DmidPine.LNX.4.44.0405180141460.28239-100000@filer.marasystems.com =

  type=3D"cite"><PRE wrap=3D"">On Mon, 17 May 2004, Joe Marzot wrote:

  </PRE>
    <BLOCKQUOTE type=3D"cite"><PRE wrap=3D"">A little more data on this =
one - the behaviour I see with these mounts=20
is that

mount -t hostfs none /mnt/mybob -o /view/myview/vob/myvob

succeeds but mounts the hosts / dir instead of the desired view extended =

pathname of the ClearCase vob.
    </PRE></BLOCKQUOTE><PRE wrap=3D""><!---->
This is a known bug in 2.4.24-2. A patch can be found in the archives or =

from <A class=3Dmoz-txt-link-freetext =
href=3D"http://marasystems.com/download/uml/">http://marasystems.com/down=
load/uml/</A>

If you need hostfs then you should probably stick to 2.4.24-1 for the =
time
being. Jeff is doing some heavy restructuring of the uml host file =
access
methods while adding the humfs and as a result of this the hostfs =
support
has become very unstable while the combined supporting framework for =
humfs
and hostfs is taking shape. Hopefully this will soon result in a much=20
better hostfs than before, but at the moment things is a bit shaky..

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
<A class=3Dmoz-txt-link-freetext =
href=3D"http://ads.osdn.com/?ad_id=3D2562&amp;alloc_id=3D6184&amp;op=3Dcl=
ick">http://ads.osdn.com/?ad_id=3D2562&amp;alloc_id=3D6184&amp;op=3Dclick=
</A>
_______________________________________________
User-mode-linux-devel mailing list
<A class=3Dmoz-txt-link-abbreviated =
href=3D"mailto:User-mode-linux-devel@lists.sourceforge.net">User-mode-lin=
ux-devel@lists.sourceforge.net</A>
<A class=3Dmoz-txt-link-freetext =
href=3D"https://lists.sourceforge.net/lists/listinfo/user-mode-linux-deve=
l">https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel</A>=

  </PRE></BLOCKQUOTE></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_058A_01C43CBF.F9DD3360--



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

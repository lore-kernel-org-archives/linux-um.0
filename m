Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxgMT-00077o-6R for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 21:53:05 -0800
Received: from [202.54.124.178] (helo=rediffmail.com)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Axfu0-00014L-Ip for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 21:23:40 -0800
Message-ID: <20040301054052.2312.qmail@webmail9.rediffmail.com>
MIME-Version: 1.0
From: "Rahul Deshmukh" <deshmukh_rs@rediffmail.com>
Reply-To: "Rahul Deshmukh" <deshmukh_rs@rediffmail.com>
Subject: Re: Re: [uml-devel] Kernel panic: VFS: Unable to mount root fs
Content-type: multipart/alternative;
	boundary="Next_1078119652---0-202.54.124.178-2260"
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
Date: 1 Mar 2004 05:40:52 -0000
To: M A Young <m.a.young@durham.ac.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net


 This is a multipart mime message


--Next_1078119652---0-202.54.124.178-2260
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0AHi<BR>=0A<BR>=0AThanks a lot for your mail. As I have missed to selec=
t the<BR>=0Aoption realted to UBD device in Block device while compiling.<B=
R>=0ANow the problem is get solved.<BR>=0A<BR>=0ARahul.<BR>=0A<BR>=0AOn Thu=
, 26 Feb 2004 M A Young wrote :<BR>=0A&gt;On Thu, 26 Feb 2004, Rahul Deshmu=
kh wrote:<BR>=0A&gt;<BR>=0A&gt; &gt;I am facing the problem of &quot;Kernel=
 panic: VFS: Unable to mount root fs&quot; I<BR>=0A&gt; &gt;am not getting =
what is the solution for the problem.As I have gone<BR>=0A&gt; &gt;through =
mailing as well got solution as to give root=3D/dev/ubd/0 . But<BR>=0A&gt; =
&gt;that thing is also not working.<BR>=0A&gt;<BR>=0A&gt;root=3D/dev/ubd/0 =
is for when you have devfs enabled. One of /dev/ubd0<BR>=0A&gt;/dev/ubda or=
 98:0 should work (assuming you do have a root image called<BR>=0A&gt;root_=
fs).<BR>=0A&gt;<BR>=0A&gt; &nbsp; &nbsp; &nbsp;Michael Young<BR>=0A=0A</P>=
=0A=0A=0A<br>=0A<br>=0AKnowledge speaks,&nbsp;but wisdom&nbsp;listens.<br>=
=0A<br>=0A<br><br>=0A<A target=3D"_blank" HREF=3D"http://clients.rediff.com=
/signature/track_sig.asp"><IMG SRC=3D"http://ads.rediff.com/RealMedia/ads/a=
dstream_nx.cgi/www.rediffmail.com/inbox.htm@Bottom" BORDER=3D0 VSPACE=3D0 H=
SPACE=3D0 HEIGHT=3D74 WIDTH=3D496></a>=0A
--Next_1078119652---0-202.54.124.178-2260
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi=0A=0AThanks a lot for your mail. As I have missed to select the=0Aoption=
 realted to UBD device in Block device while compiling.=0ANow the problem i=
s get solved.=0A=0ARahul.=0A=0AOn Thu, 26 Feb 2004 M A Young wrote :=0A>On =
Thu, 26 Feb 2004, Rahul Deshmukh wrote:=0A>=0A> >I am facing the problem of=
 "Kernel panic: VFS: Unable to mount root fs" I=0A> >am not getting what is=
 the solution for the problem.As I have gone=0A> >through mailing as well g=
ot solution as to give root=3D/dev/ubd/0 . But=0A> >that thing is also not =
working.=0A>=0A>root=3D/dev/ubd/0 is for when you have devfs enabled. One o=
f /dev/ubd0=0A>/dev/ubda or 98:0 should work (assuming you do have a root i=
mage called=0A>root_fs).=0A>=0A> 	Michael Young=0A=0A=0A=0A=0AKnowledge spe=
aks, but wisdom listens.=0A=0A
--Next_1078119652---0-202.54.124.178-2260--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

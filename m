Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tschmelcher@google.com>) id 1Tsfh7-0005LK-AZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Jan 2013 20:22:45 +0000
Received: from mail-ob0-f181.google.com ([209.85.214.181])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Tsfh6-0001Qa-39
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Jan 2013 20:22:45 +0000
Received: by mail-ob0-f181.google.com with SMTP id oi10so1180789obb.12
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 08 Jan 2013 12:22:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130108074356.03f539c2@spider.haslach.nod.at>
References: <CADNZ+wT==gf=MLjeqx5J1Lw3EEmNOmVjWyVrR6jh4QoTM+xoxw@mail.gmail.com>
	<20130108074356.03f539c2@spider.haslach.nod.at>
From: Tristan Schmelcher <tschmelcher@google.com>
Date: Tue, 8 Jan 2013 12:22:17 -0800
Message-ID: <CADNZ+wRfo6W_x4bg4PX7=yDYJ3Y1e6En-+0gHmzNcPKNs3YLkA@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0165770485302814595=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] File corruption with hostfs and GNU Gold linker
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

--===============0165770485302814595==
Content-Type: multipart/alternative; boundary=f46d0445182100e38204d2ccb5f2

--f46d0445182100e38204d2ccb5f2
Content-Type: text/plain; charset=ISO-8859-1

On 7 January 2013 22:43, Richard Weinberger <richard@nod.at> wrote:

> Am Mon, 7 Jan 2013 17:55:29 -0800
> schrieb Tristan Schmelcher <tschmelcher@google.com>:
>
> > Hello,
> >
> > I am using UML as part of a hermetic build system and I have
> > encountered an odd file corruption problem with the GNU Gold linker.
> > When linking a binary inside a UML VM with Gold, if the output path
> > is on a hostfs mount then all bytes in the output file produced by
> > Gold are zero. However, the size of the output file is correct and
> > the debugging output from running gold with --debug suggests that
> > everything is working, so it seems like the content is being produced
> > by Gold correctly but the file ends up containing all zeros instead.
> > It has happened 100% of the time so far and it seems to be
> > independent of the linker command line or input files.
> >
> > Are there any known issues where hostfs file content could end up as
> > all zeros?
>
> Is the file corrupted or does it *always* contain zeros?
>

It's always all zeros. Not "corruption" in the normal sense.


> If yes, the write command seems to fail.
>
> I'm wondering how gold writes a file.
> Can you find out the system call sequence? (E.g using strace).
>

Certainly.

Outside UML: http://pastebin.com/rJRL4guJ
Inside UML writing to hostfs: http://pastebin.com/HyykiKfq

The output file that gets the all-zero content
is out/Debug/libvpx_obj_int_extract. Looks like gold uses posix_fallocate
but that isn't implemented on hostfs, and glibc falls back to forcing
blocks to be allocated via pwrite. Then it mmap's the file, presumably
writes the content to the mmap'ed region, and closes.

Hmm, maybe gold doesn't write anything to the mmap'ed region? Nope, it
does: http://pastebin.com/nAzAibFv

Hmm, maybe the EOPNOTSUPP code path in glibc is broken? Nope, works outside
UML even if EOPNOTSUPP is forced: http://pastebin.com/nS90fB6t

Perhaps there is a race in hostfs that causes the pwrite'ed pages to be
written out after the mmap'ed data is written out?


>
> Thanks,
> //richard
>

--f46d0445182100e38204d2ccb5f2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div class=3D"gmail_extra"><br><br><div cla=
ss=3D"gmail_quote">On 7 January 2013 22:43, Richard Weinberger <span dir=3D=
"ltr">&lt;<a href=3D"mailto:richard@nod.at" target=3D"_blank">richard@nod.a=
t</a>&gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">Am Mon, 7 Jan 2013 17:55:29 -0800<br>
schrieb Tristan Schmelcher &lt;<a href=3D"mailto:tschmelcher@google.com" ta=
rget=3D"_blank">tschmelcher@google.com</a>&gt;:<br>
<div><br>
&gt; Hello,<br>
&gt;<br>
&gt; I am using UML as part of a hermetic build system and I have<br>
&gt; encountered an odd file corruption problem with the GNU Gold linker.<b=
r>
&gt; When linking a binary inside a UML VM with Gold, if the output path<br=
>
&gt; is on a hostfs mount then all bytes in the output file produced by<br>
&gt; Gold are zero. However, the size of the output file is correct and<br>
&gt; the debugging output from running gold with --debug suggests that<br>
&gt; everything is working, so it seems like the content is being produced<=
br>
&gt; by Gold correctly but the file ends up containing all zeros instead.<b=
r>
&gt; It has happened 100% of the time so far and it seems to be<br>
&gt; independent of the linker command line or input files.<br>
&gt;<br>
&gt; Are there any known issues where hostfs file content could end up as<b=
r>
&gt; all zeros?<br>
<br>
</div>Is the file corrupted or does it *always* contain zeros?<br></blockqu=
ote><div><br></div><div>It&#39;s always all zeros. Not &quot;corruption&quo=
t; in the normal sense.</div><div>=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color=
:rgb(204,204,204);border-left-style:solid;padding-left:1ex">



If yes, the write command seems to fail.<br>
<br>
I&#39;m wondering how gold writes a file.<br>
Can you find out the system call sequence? (E.g using strace).<br></blockqu=
ote><div><br></div><div>Certainly.</div><div><br></div><div>Outside UML:=A0=
<a href=3D"http://pastebin.com/rJRL4guJ" target=3D"_blank">http://pastebin.=
com/rJRL4guJ</a><br>


</div><div>Inside UML writing to hostfs:=A0<a href=3D"http://pastebin.com/H=
yykiKfq" target=3D"_blank">http://pastebin.com/HyykiKfq</a><br></div><div><=
br></div><div>The output file that gets the all-zero content is=A0out/Debug=
/libvpx_obj_int_extract. Looks like gold uses posix_fallocate but that isn&=
#39;t implemented on hostfs, and glibc falls back to forcing blocks to be a=
llocated via pwrite. Then it mmap&#39;s the file, presumably writes the con=
tent to the mmap&#39;ed region, and closes.</div>

<div><br></div><div>Hmm, maybe gold doesn&#39;t write anything to the mmap&=
#39;ed region? Nope, it does:=A0<a href=3D"http://pastebin.com/nAzAibFv">ht=
tp://pastebin.com/nAzAibFv</a></div><div><br></div><div style>Hmm, maybe th=
e EOPNOTSUPP code path in glibc is broken? Nope, works outside UML even if =
EOPNOTSUPP is forced:=A0<a href=3D"http://pastebin.com/nS90fB6t">http://pas=
tebin.com/nS90fB6t</a></div>

<div style><br></div><div style>Perhaps there is a race in hostfs that caus=
es the pwrite&#39;ed pages to be written out after the mmap&#39;ed data is =
written out?</div>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left=
-style:solid;padding-left:1ex">
<br>
Thanks,<br>
//richard<br>
</blockquote></div><br></div></div>

--f46d0445182100e38204d2ccb5f2--


--===============0165770485302814595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Master SQL Server Development, Administration, T-SQL, SSAS, SSIS, SSRS
and more. Get SQL Server skills now (including 2012) with LearnDevNow -
200+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only - learn more at:
http://p.sf.net/sfu/learnmore_122512
--===============0165770485302814595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0165770485302814595==--



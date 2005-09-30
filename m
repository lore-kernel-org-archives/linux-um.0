Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ELKwG-0006wE-TR	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2005 06:28:36 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ELKwB-0000Az-9h
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2005 06:28:36 -0700
Received: by wproxy.gmail.com with SMTP id 37so97247wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 30 Sep 2005 06:28:25 -0700 (PDT)
Message-ID: <229e70f205093006281da277cf@mail.gmail.com>
From: Etay Meiri <etay.meiri@gmail.com>
Reply-To: Etay Meiri <etay.meiri@gmail.com>
Subject: Re: [uml-devel] Error running UML
In-Reply-To: <229e70f205093004533d68e798@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7465_4325701.1128086905385"
References: <229e70f205093003511a49c171@mail.gmail.com>
	 <200509301306.08001.blaisorblade@yahoo.it>
	 <229e70f2050930041251654370@mail.gmail.com>
	 <200509301320.18389.blaisorblade@yahoo.it>
	 <229e70f205093004533d68e798@mail.gmail.com>
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
Date: Fri, 30 Sep 2005 16:28:25 +0300
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

------=_Part_7465_4325701.1128086905385
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Seems like the root fs I was using was not UML ready and needed
quite a lot of work. I followed the instructions in:
http://uml.harlowhill.com/index.php/UML_Fedora_Core_4
and was able to get it up and running.

Thanks for you help, Blaisorblade.

-Etay

On 9/30/05, Etay Meiri <etay.meiri@gmail.com> wrote:
>
> I tries the following without success:
>
> 1. 'con=3Dpts' instead of 'con=3Dpty'.
> 2. 'con=3Dxterm' instead of 'con=3Dpty'.
> 3. added 'init=3D/bin/sh' to both of the above.
> 4. compiled the guest kernel again with 'make defconfig'.
> 5. moved away /lib/tls in the guest fs.
>
> I'm still getting the same warning about the console. When I try
> with xterm it just opens and immediately closes the xterm and
> I don't have a chance to see what's there.
>
> -Etay
>
> On 9/30/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> >
> > On Friday 30 September 2005 13:12, Etay Meiri wrote:
> > > Thanks for your response.
> > >
> > > I tried running it with a simple: ./vmlinux ubd0=3Droot_fs.2005062201
> > > and now it says:
> > Well, the only option which *must* be dropped is root=3D/dev/ubd/0. The
> > rest is
> > harmless, and may help.
> >
> > Note that if you use con=3Dpty rather than con=3Dxterm, you'll need to
> > connect to
> > the consoles manually and look for them. Plus /dev/pty* are deprecated,
> > and
> > some host kernel don't support them any more.
> >
> > At least, using con=3Dpts is more modern (it's supported on any recent
> > kernel).
> > > [42949373.420000] Console initialized on /dev/tty0
> > > [42949373.420000] ubda: unknown partition table
> > > [42949373.420000 ] kjournald starting. Commit interval 5 seconds
> > > [42949373.420000] EXT3-fs: mounted filesystem with ordered data mode.
> > > [42949373.420000] VFS: Mounted root (ext3 filesystem) readonly.
> > > [42949373.420000 ] Warning: unable to open an initial console.
> > This warning, normally, is harmless.
> > > [42949373.420000] Kernel panic - not syncing: Attempted to kill init!
> >
> > > Looks like it mounted the root file system but has a problem opening
> > > a console. Maybe I'm missing some console related option in the kerne=
l
> > > config?
> > It's possible. I would first check also if init=3D/bin/sh makes it boot=
,
> > to
> > distinguish between fs problems and console problems. Also, remember to
> > "mv /lib/tls /lib/tls.away" in the guest fs.
> >
> > Due to a bug in kconfig, which wasn't fixed because the fix wasn't nice=
,
> > if
> > you do "make *config ARCH=3Dum" on an empty tree it may pick as default
> > values
> > from /boot/config-`uname -r`. To avoid this, you need to move away
> > your .config and do:
> >
> > make defconfig ARCH=3Dum
> > and only afterwards, depending on your taste for configuration tool,
> > make {menu,x,g}config ARCH=3Dum
> > i.e. either make menuconfig ARCH=3Dum or the other similar ones.
> > --
> > Inform me of my mistakes, so I can keep imitating Homer Simpson's
> > "Doh!".
> > Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ
> > 215621894)
> > http://www.user-mode-linux.org/~blaisorblade<http://www.user-mode-linux=
.org/%7Eblaisorblade>
> >
> >
> >
> >
> >
> > ___________________________________
> > Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB
> > http://mail.yahoo.it
> >
> >
>
>
> --
> ------------------------------------------------------
> Etay Meiri
> etay.meiri@gmail.com
>



--
------------------------------------------------------
Etay Meiri
etay.meiri@gmail.com

------=_Part_7465_4325701.1128086905385
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Seems like the root fs I was using was not UML ready and needed<br>
quite a lot of work. I followed the instructions in:<br>
<a href=3D"http://uml.harlowhill.com/index.php/UML_Fedora_Core_4">http://um=
l.harlowhill.com/index.php/UML_Fedora_Core_4</a><br>
and was able to get it up and running.<br>
<br>
Thanks for you help, Blaisorblade.<br>
<br>
-Etay<br><br><div><span class=3D"gmail_quote">On 9/30/05, <b class=3D"gmail=
_sendername">Etay Meiri</b> &lt;<a href=3D"mailto:etay.meiri@gmail.com">eta=
y.meiri@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" st=
yle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex=
; padding-left: 1ex;">
I tries the following without success:<br>
<br>
1. 'con=3Dpts' instead of 'con=3Dpty'.<br>
2. 'con=3Dxterm' instead of 'con=3Dpty'.<br>
3. added 'init=3D/bin/sh' to both of the above.<br>
4. compiled the guest kernel again with 'make defconfig'.<br>
5. moved away /lib/tls in the guest fs.<br>
<br>
I'm still getting the same warning about the console. When I try<br>
with xterm it just opens and immediately closes the xterm and<br>
I don't have a chance to see what's there.<br><span class=3D"sg">
<br>
-Etay<br><br></span><div><span class=3D"q"><span class=3D"gmail_quote">On 9=
/30/05, <b class=3D"gmail_sendername">Blaisorblade</b> &lt;<a href=3D"mailt=
o:blaisorblade@yahoo.it" target=3D"_blank" onclick=3D"return top.js.OpenExt=
Link(window,event,this)">
blaisorblade@yahoo.it</a>&gt; wrote:</span></span><div><span class=3D"e" id=
=3D"q_106a6e0e2552d2f8_4"><blockquote class=3D"gmail_quote" style=3D"border=
-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-lef=
t: 1ex;">

On Friday 30 September 2005 13:12, Etay Meiri wrote:<br>&gt; Thanks for you=
r response.<br>&gt;<br>&gt; I tried running it with a simple: ./vmlinux ubd=
0=3Droot_fs.2005062201<br>&gt; and now it says:<br>Well, the only option wh=
ich *must* be dropped is root=3D/dev/ubd/0. The rest is
<br>harmless, and may help.<br><br>Note that if you use con=3Dpty rather th=
an con=3Dxterm, you'll need to connect to<br>the consoles manually and look=
 for them. Plus /dev/pty* are deprecated, and<br>some host kernel don't sup=
port them any more.
<br><br>At least, using con=3Dpts is more modern (it's supported on any rec=
ent kernel).<br>&gt; [42949373.420000] Console initialized on /dev/tty0<br>=
&gt; [42949373.420000] ubda: unknown partition table<br>&gt; [42949373.4200=
00

] kjournald starting. Commit interval 5 seconds<br>&gt; [42949373.420000] E=
XT3-fs: mounted filesystem with ordered data mode.<br>&gt; [42949373.420000=
] VFS: Mounted root (ext3 filesystem) readonly.<br>&gt; [42949373.420000

] Warning: unable to open an initial console.<br>This warning, normally, is=
 harmless.<br>&gt; [42949373.420000] Kernel panic - not syncing: Attempted =
to kill init!<br><br>&gt; Looks like it mounted the root file system but ha=
s a problem opening
<br>&gt; a console. Maybe I'm missing some console related option in the ke=
rnel<br>&gt; config?<br>It's possible. I would first check also if init=3D/=
bin/sh makes it boot, to<br>distinguish between fs problems and console pro=
blems. Also, remember to
<br>&quot;mv /lib/tls /lib/tls.away&quot; in the guest fs.<br><br>Due to a =
bug in kconfig, which wasn't fixed because the fix wasn't nice, if<br>you d=
o &quot;make *config ARCH=3Dum&quot; on an empty tree it may pick as defaul=
t values
<br>from /boot/config-`uname -r`. To avoid this, you need to move away<br>y=
our .config and do:<br><br>make defconfig ARCH=3Dum<br>and only afterwards,=
 depending on your taste for configuration tool,<br>make {menu,x,g}config A=
RCH=3Dum
<br>i.e. either make menuconfig ARCH=3Dum or the other similar ones.<br>--<=
br>Inform me of my mistakes, so I can keep imitating Homer Simpson's &quot;=
Doh!&quot;.<br>Paolo Giarrusso, aka Blaisorblade (Skype ID &quot;PaoloGiarr=
usso&quot;, ICQ 215621894)
<br><a href=3D"http://www.user-mode-linux.org/%7Eblaisorblade" target=3D"_b=
lank" onclick=3D"return top.js.OpenExtLink(window,event,this)">http://www.u=
ser-mode-linux.org/~blaisorblade</a><br><br><br><br><br><br>_______________=
____________________
<br>Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB
<br><a href=3D"http://mail.yahoo.it" target=3D"_blank" onclick=3D"return to=
p.js.OpenExtLink(window,event,this)">http://mail.yahoo.it</a><br><br></bloc=
kquote></span></div></div><br><br clear=3D"all"><br>-- <br>----------------=
--------------------------------------
<div><span class=3D"e" id=3D"q_106a6e0e2552d2f8_6"><br>Etay Meiri<br><a hre=
f=3D"mailto:etay.meiri@gmail.com" target=3D"_blank" onclick=3D"return top.j=
s.OpenExtLink(window,event,this)">
etay.meiri@gmail.com</a>

</span></div></blockquote></div><br><br clear=3D"all"><br>-- <br>----------=
--------------------------------------------<br>Etay Meiri<br><a href=3D"ma=
ilto:etay.meiri@gmail.com">etay.meiri@gmail.com</a>

------=_Part_7465_4325701.1128086905385--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

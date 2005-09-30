Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ELIop-0000c8-Gg	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2005 04:12:47 -0700
Received: from wproxy.gmail.com ([64.233.184.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ELIom-0004Gm-P7
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2005 04:12:47 -0700
Received: by wproxy.gmail.com with SMTP id i3so4704wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 30 Sep 2005 04:12:39 -0700 (PDT)
Message-ID: <229e70f2050930041251654370@mail.gmail.com>
From: Etay Meiri <etay.meiri@gmail.com>
Reply-To: Etay Meiri <etay.meiri@gmail.com>
Subject: Re: [uml-devel] Error running UML
In-Reply-To: <200509301306.08001.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_6977_14300483.1128078758920"
References: <229e70f205093003511a49c171@mail.gmail.com>
	 <200509301306.08001.blaisorblade@yahoo.it>
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
Date: Fri, 30 Sep 2005 14:12:38 +0300
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

------=_Part_6977_14300483.1128078758920
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks for your response.

I tried running it with a simple: ./vmlinux ubd0=3Droot_fs.2005062201
and now it says:

[42949373.420000] Console initialized on /dev/tty0
[42949373.420000] ubda: unknown partition table
[42949373.420000] kjournald starting. Commit interval 5 seconds
[42949373.420000] EXT3-fs: mounted filesystem with ordered data mode.
[42949373.420000] VFS: Mounted root (ext3 filesystem) readonly.
[42949373.420000] Warning: unable to open an initial console.
[42949373.420000] Kernel panic - not syncing: Attempted to kill init!

Looks like it mounted the root file system but has a problem opening
a console. Maybe I'm missing some console related option in the kernel
config?

Thanks,

-Etay

On 9/30/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
>
> On Friday 30 September 2005 12:51, Etay Meiri wrote:
> > Hi,
> >
> > I downloaded a root file system from:
> > http://www.stearns.org/uml-root/root_fs.fc-4-base.pristine.20050622.bz2
> > and followed the instructions in
> > http://www.stearns.org/uml-root/root_fs.fc-4-base.pristine.20050622.not=
e
> > in order to extract it. I am able to mount it as a loop device without
> > problems.
> > I applied the patch from
> >
> http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.13-bs2=
/u
> >ml-2.6.13-bs2.patch.bz2 to the 2.6.13 vanilla kernel and built a uml
> kernel
> > with ext3 support not as a module.
> > Now when I run it I get the following error:
>
> > [cl@amber uml]$ ./vmlinux mem=3D160M ubd0=3Droot_fs.2005062201 ubd1=3Ds=
wap
> > root=3D/dev/ubd/0 con=3Dpty con0=3Dfd:0,fd:1
> root=3D/dev/ubd/0 is wrong for two reasons:
> *) you don't need to specify root=3D, UML automatically sets it to point =
to
> ubd0
>
> *) /dev/ubd/0 is the DevFS syntax, and since 2.6.13 DevFS is no more
> supported.
>
> *) I'm not even sure if root=3D/dev/ubd0 would work - Uml, to be sure, us=
es
> major and minor (root=3D98:0).
>
> Thanks for attaching the logs, but look below:
> > [42949373.560000] VFS: Cannot open root device "ubd/0" or
> > unknown-block(0,0) [42949373.560000] Please append a correct "root=3D"
> boot
> > option
> > [42949373.560000] Kernel panic - not syncing: VFS: Unable to mount root
> fs
> > on unknown-block(0,0)
> > [42949373.560000]
>
> The trace below is always output in case of panic, but in this case it's
> not a
> kernel bug, so don't get confused by it.
> > [42949373.560000] EIP: 0073:[<a0382721>] CPU: 0 Not tainted ESP:
> > 007b:b7f7df9c EFLAGS: 00200246
> > [42949373.560000] Not tainted
> > [42949373.560000] EAX: 00000000 EBX: 00000a1f ECX: 00000013 EDX:
> 00000a1f
> > [42949373.560000] ESI: 00000a1e EDI: 00000011 EBP: b7f7dfb8 DS: 007b ES=
:
> > 007b
> > [42949373.560000] aae97ac0: [<a006304d>] show_regs+0x309/0x378
> > [42949373.560000] aae97af0: [<a002d1c3>] panic_exit+0x43/0x8c
> > [42949373.560000] aae97b20: [<a0097206>] notifier_call_chain+0x2e/0x88
> > [42949373.560000] aae97b50: [<a006d7df>] panic+0x9f/0x1f8
> > [42949373.560000] aae97b80: [<a000231a>] mount_block_root+0x116/0x1cc
> > [42949373.560000] aae97bd0: [<a00025ee>] mount_root+0x7e/0x94
> > [42949373.560000] aae97bf0: [<a000266d>] prepare_namespace+0x69/0x224
> > [42949373.560000] aae97c00: [<a001c3c7>] init+0x1d7/0x220
> > [42949373.560000] aae97c20: [<a00227c5>] run_kernel_thread+0x59/0x74
> > [42949373.560000] aae97ce0: [<a003538e>] new_thread_handler+0xd2/0x138
> > [42949373.560000] aae97d20: [<b7f7f420>] 0xb7f7f420
> > [42949373.560000]
> > [42949373.560000]
>
> --
> Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
> Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ
> 215621894)
> http://www.user-mode-linux.org/~blaisorblade
>
>
>
>
>
> ___________________________________
> Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB
> http://mail.yahoo.it
>
>


--
------------------------------------------------------
Etay Meiri
etay.meiri@gmail.com

------=_Part_6977_14300483.1128078758920
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks for your response.<br>
<br>
I tried running it with a simple: ./vmlinux ubd0=3Droot_fs.2005062201 <br>
and now it says:<br>
<br>
[42949373.420000] Console initialized on /dev/tty0<br>
[42949373.420000]&nbsp; ubda: unknown partition table<br>
[42949373.420000] kjournald starting.&nbsp; Commit interval 5 seconds<br>
[42949373.420000] EXT3-fs: mounted filesystem with ordered data mode.<br>
[42949373.420000] VFS: Mounted root (ext3 filesystem) readonly.<br>
[42949373.420000] Warning: unable to open an initial console.<br>
[42949373.420000] Kernel panic - not syncing: Attempted to kill init!<br>
<br>
Looks like it mounted the root file system but has a problem opening<br>
a console. Maybe I'm missing some console related option in the kernel<br>
config?<br>
<br>
Thanks,<br>
<br>
-Etay<br><br><div><span class=3D"gmail_quote">On 9/30/05, <b class=3D"gmail=
_sendername">Blaisorblade</b> &lt;<a href=3D"mailto:blaisorblade@yahoo.it">=
blaisorblade@yahoo.it</a>&gt; wrote:</span><blockquote class=3D"gmail_quote=
" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0=
.8ex; padding-left: 1ex;">
On Friday 30 September 2005 12:51, Etay Meiri wrote:<br>&gt; Hi,<br>&gt;<br=
>&gt; I downloaded a root file system from:<br>&gt; <a href=3D"http://www.s=
tearns.org/uml-root/root_fs.fc-4-base.pristine.20050622.bz2">http://www.ste=
arns.org/uml-root/root_fs.fc-4-base.pristine.20050622.bz2
</a><br>&gt; and followed the instructions in<br>&gt; <a href=3D"http://www=
.stearns.org/uml-root/root_fs.fc-4-base.pristine.20050622.note">http://www.=
stearns.org/uml-root/root_fs.fc-4-base.pristine.20050622.note</a><br>&gt; i=
n order to extract it. I am able to mount it as a loop device without
<br>&gt; problems.<br>&gt; I applied the patch from<br>&gt; <a href=3D"http=
://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.13-bs2/u">ht=
tp://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.13-bs2/u
</a><br>&gt;ml-2.6.13-bs2.patch.bz2 to the 2.6.13 vanilla kernel and built =
a uml kernel<br>&gt; with ext3 support not as a module.<br>&gt; Now when I =
run it I get the following error:<br><br>&gt; [cl@amber uml]$ ./vmlinux mem=
=3D160M ubd0=3Droot_fs.2005062201 ubd1=3Dswap
<br>&gt; root=3D/dev/ubd/0 con=3Dpty con0=3Dfd:0,fd:1<br>root=3D/dev/ubd/0 =
is wrong for two reasons:<br>*) you don't need to specify root=3D, UML auto=
matically sets it to point to ubd0<br><br>*) /dev/ubd/0 is the DevFS syntax=
, and since=20
2.6.13 DevFS is no more<br>supported.<br><br>*) I'm not even sure if root=
=3D/dev/ubd0 would work - Uml, to be sure, uses<br>major and minor (root=3D=
98:0).<br><br>Thanks for attaching the logs, but look below:<br>&gt; [42949=
373.560000
] VFS: Cannot open root device &quot;ubd/0&quot; or<br>&gt; unknown-block(0=
,0) [42949373.560000] Please append a correct &quot;root=3D&quot; boot<br>&=
gt; option<br>&gt; [42949373.560000] Kernel panic - not syncing: VFS: Unabl=
e to mount root fs
<br>&gt; on unknown-block(0,0)<br>&gt; [42949373.560000]<br><br>The trace b=
elow is always output in case of panic, but in this case it's not a<br>kern=
el bug, so don't get confused by it.<br>&gt; [42949373.560000] EIP: 0073:[&=
lt;a0382721&gt;] CPU: 0 Not tainted ESP:
<br>&gt; 007b:b7f7df9c EFLAGS: 00200246<br>&gt; [42949373.560000] Not taint=
ed<br>&gt; [42949373.560000] EAX: 00000000 EBX: 00000a1f ECX: 00000013 EDX:=
 00000a1f<br>&gt; [42949373.560000] ESI: 00000a1e EDI: 00000011 EBP: b7f7df=
b8 DS: 007b ES:
<br>&gt; 007b<br>&gt; [42949373.560000] aae97ac0: [&lt;a006304d&gt;] show_r=
egs+0x309/0x378<br>&gt; [42949373.560000] aae97af0: [&lt;a002d1c3&gt;] pani=
c_exit+0x43/0x8c<br>&gt; [42949373.560000] aae97b20: [&lt;a0097206&gt;] not=
ifier_call_chain+0x2e/0x88
<br>&gt; [42949373.560000] aae97b50: [&lt;a006d7df&gt;] panic+0x9f/0x1f8<br=
>&gt; [42949373.560000] aae97b80: [&lt;a000231a&gt;] mount_block_root+0x116=
/0x1cc<br>&gt; [42949373.560000] aae97bd0: [&lt;a00025ee&gt;] mount_root+0x=
7e/0x94
<br>&gt; [42949373.560000] aae97bf0: [&lt;a000266d&gt;] prepare_namespace+0=
x69/0x224<br>&gt; [42949373.560000] aae97c00: [&lt;a001c3c7&gt;] init+0x1d7=
/0x220<br>&gt; [42949373.560000] aae97c20: [&lt;a00227c5&gt;] run_kernel_th=
read+0x59/0x74
<br>&gt; [42949373.560000] aae97ce0: [&lt;a003538e&gt;] new_thread_handler+=
0xd2/0x138<br>&gt; [42949373.560000] aae97d20: [&lt;b7f7f420&gt;] 0xb7f7f42=
0<br>&gt; [42949373.560000]<br>&gt; [42949373.560000]<br><br>--<br>Inform m=
e of my mistakes, so I can keep imitating Homer Simpson's &quot;Doh!&quot;.
<br>Paolo Giarrusso, aka Blaisorblade (Skype ID &quot;PaoloGiarrusso&quot;,=
 ICQ 215621894)<br><a href=3D"http://www.user-mode-linux.org/~blaisorblade"=
>http://www.user-mode-linux.org/~blaisorblade</a><br><br><br><br><br><br>
___________________________________<br>Yahoo! Mail: gratis 1GB per i messag=
gi e allegati da 10MB<br><a href=3D"http://mail.yahoo.it">http://mail.yahoo=
.it</a><br><br></blockquote></div><br><br clear=3D"all"><br>-- <br>--------=
----------------------------------------------
<br>Etay Meiri<br><a href=3D"mailto:etay.meiri@gmail.com">etay.meiri@gmail.=
com</a>

------=_Part_6977_14300483.1128078758920--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

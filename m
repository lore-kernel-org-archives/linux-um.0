Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1a0Phb-0003VS-91
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Nov 2015 08:08:51 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a0PhZ-0003lM-Kd
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Nov 2015 08:08:51 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=smaug.kot-begemot.co.uk) by ivanoab4.miniserver.com with esmtps
	(TLS1.2:RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1a0PhS-0000sd-Kg
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Nov 2015 08:08:42 +0000
Received: from wyvern.kot-begemot.co.uk ([192.168.3.72])
	by smaug.kot-begemot.co.uk with esmtps
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.84)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1a0PhS-00007P-EO
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Nov 2015 08:08:42 +0000
Message-ID: <5651780A.3010302@kot-begemot.co.uk>
Date: Sun, 22 Nov 2015 08:08:42 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <56426AED.8030005@nod.at>
	<CAOMGZ=Hz_jBY0rNUDsNUyJBMM1PVFsv2M4O=h-FJNE4GiNMvdA@mail.gmail.com>
In-Reply-To: <CAOMGZ=Hz_jBY0rNUDsNUyJBMM1PVFsv2M4O=h-FJNE4GiNMvdA@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5394897027442926570=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [GIT PULL] UML updates for 4.4-rc1
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============5394897027442926570==
Content-Type: multipart/alternative;
	boundary="------------060105040807070204060608"

This is a multi-part message in MIME format.
--------------060105040807070204060608
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

set_timer needs -lrt which the patch adds to the link arguments. For
some reason on your config it is not in the correct location in the
command line.

This is being discussed on the list, lorenzo@google.com was working on a
patch.

In any case, can you send the actual gcc line leading to it so we see
why -lrt is not in the right place.

A.

On 21/11/15 19:09, Vegard Nossum wrote:
> On 10 November 2015 at 23:08, Richard Weinberger <richard@nod.at
> <mailto:richard@nod.at>> wrote:
>
>     Linus,
>
>     the following changes since commit
>     6a13feb9c82803e2b815eca72fa7a9f5561d7861:
>
>       Linux 4.3 (2015-11-01 16:05:25 -0800)
>
>     are available in the git repository at:
>
>       git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
>     <http://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git>
>     for-linus-4.4-rc1
>
>     for you to fetch changes up to
>     2eb5f31bc4ea24bb293e82934cfa1cce9573304b:
>
>       um: Switch clocksource to hrtimers (2015-11-06 22:54:49 +0100)
>
>     ----------------------------------------------------------------
>     This pull request includes the following UML changes:
>     * A new hrtimer based clocksource by Anton Ivanov
>     * ptrace() enhancments by Richard Weinberger
>     * random cleanups and bug fixes all over the place
>
>     ----------------------------------------------------------------
>     Anton Ivanov (1):
>           um: Switch clocksource to hrtimers
>
>
> This commit (2eb5f31bc4) seems to have broken the UML defconfig build
> in latest Linus master for me:
>
> [...]
>  LINK    vmlinux
>  LD      vmlinux.o
>  MODPOST vmlinux.o
>  GEN     .version
>  CHK     include/generated/compile.h
>  UPD     include/generated/compile.h
>  CC      init/version.o
>  LD      init/built-in.o
> arch/um/os-Linux/built-in.o: In function `os_timer_create':
> /home/vegard/linux/arch/um/os-Linux/time.c:51: undefined reference to
> `timer_create'
> arch/um/os-Linux/built-in.o: In function `os_timer_set_interval':
> /home/vegard/linux/arch/um/os-Linux/time.c:84: undefined reference to
> `timer_settime'
> arch/um/os-Linux/built-in.o: In function `os_timer_remain':
> /home/vegard/linux/arch/um/os-Linux/time.c:109: undefined reference to
> `timer_gettime'
> arch/um/os-Linux/built-in.o: In function `os_timer_one_shot':
> /home/vegard/linux/arch/um/os-Linux/time.c:132: undefined reference to
> `timer_settime'
> arch/um/os-Linux/built-in.o: In function `os_timer_disable':
> /home/vegard/linux/arch/um/os-Linux/time.c:145: undefined reference to
> `timer_settime'
> collect2: error: ld returned 1 exit status
> make: *** [vmlinux] Error 1
>
>
> Vegard
>
>
> ------------------------------------------------------------------------------
>
>
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


--------------060105040807070204060608
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">set_timer needs -lrt which the patch
      adds to the link arguments. For some reason on your config it is
      not in the correct location in the command line.<br>
      <br>
      This is being discussed on the list, <a class=3D"moz-txt-link-abbrevi=
ated" href=3D"mailto:lorenzo@google.com">lorenzo@google.com</a> was
      working on a patch.<br>
      <br>
      In any case, can you send the actual gcc line leading to it so we
      see why -lrt is not in the right place.<br>
      <br>
      A.<br>
      <br>
      On 21/11/15 19:09, Vegard Nossum wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CAOMGZ=3DHz_jBY0rNUDsNUyJBMM1PVFsv2M4O=3Dh-FJNE4GiNMvdA@mail.gm=
ail.com"
      type=3D"cite">
      <div dir=3D"ltr">On 10 November 2015 at 23:08, Richard Weinberger <sp=
an
          dir=3D"ltr">&lt;<a moz-do-not-send=3D"true"
            href=3D"mailto:richard@nod.at" target=3D"_blank">richard@nod.at=
</a>&gt;</span>
        wrote:<br>
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">Linus,<br>
              <br>
              the following changes since commit
              6a13feb9c82803e2b815eca72fa7a9f5561d7861:<br>
              <br>
              =EF=BF=BD Linux 4.3 (2015-11-01 16:05:25 -0800)<br>
              <br>
              are available in the git repository at:<br>
              <br>
              =EF=BF=BD git://<a moz-do-not-send=3D"true"
                href=3D"http://git.kernel.org/pub/scm/linux/kernel/git/rw/u=
ml.git"
                rel=3D"noreferrer" target=3D"_blank">git.kernel.org/pub/scm=
/linux/kernel/git/rw/uml.git</a>
              for-linus-4.4-rc1<br>
              <br>
              for you to fetch changes up to
              2eb5f31bc4ea24bb293e82934cfa1cce9573304b:<br>
              <br>
              =EF=BF=BD um: Switch clocksource to hrtimers (2015-11-06 22:5=
4:49
              +0100)<br>
              <br>
----------------------------------------------------------------<br>
              This pull request includes the following UML changes:<br>
              * A new hrtimer based clocksource by Anton Ivanov<br>
              * ptrace() enhancments by Richard Weinberger<br>
              * random cleanups and bug fixes all over the place<br>
              <br>
----------------------------------------------------------------<br>
              Anton Ivanov (1):<br>
              =EF=BF=BD =EF=BF=BD =EF=BF=BD um: Switch clocksource to hrtim=
ers<br>
            </blockquote>
            <div><br>
            </div>
            <div>This commit (2eb5f31bc4) seems to have broken the UML
              defconfig build in latest Linus master for me:<br>
              <br>
              [...]<br>
              =EF=BF=BDLINK =EF=BF=BD =EF=BF=BDvmlinux<br>
              =EF=BF=BDLD =EF=BF=BD =EF=BF=BD =EF=BF=BDvmlinux.o<br>
              =EF=BF=BDMODPOST vmlinux.o<br>
              =EF=BF=BDGEN =EF=BF=BD =EF=BF=BD .version<br>
              =EF=BF=BDCHK =EF=BF=BD =EF=BF=BD include/generated/compile.h<=
br>
              =EF=BF=BDUPD =EF=BF=BD =EF=BF=BD include/generated/compile.h<=
br>
              =EF=BF=BDCC =EF=BF=BD =EF=BF=BD =EF=BF=BDinit/version.o<br>
              =EF=BF=BDLD =EF=BF=BD =EF=BF=BD =EF=BF=BDinit/built-in.o<br>
              arch/um/os-Linux/built-in.o: In function
              `os_timer_create':<br>
              /home/vegard/linux/arch/um/os-Linux/time.c:51: undefined
              reference to `timer_create'<br>
              arch/um/os-Linux/built-in.o: In function
              `os_timer_set_interval':<br>
              /home/vegard/linux/arch/um/os-Linux/time.c:84: undefined
              reference to `timer_settime'<br>
              arch/um/os-Linux/built-in.o: In function
              `os_timer_remain':<br>
              /home/vegard/linux/arch/um/os-Linux/time.c:109: undefined
              reference to `timer_gettime'<br>
              arch/um/os-Linux/built-in.o: In function
              `os_timer_one_shot':<br>
              /home/vegard/linux/arch/um/os-Linux/time.c:132: undefined
              reference to `timer_settime'<br>
              arch/um/os-Linux/built-in.o: In function
              `os_timer_disable':<br>
              /home/vegard/linux/arch/um/os-Linux/time.c:145: undefined
              reference to `timer_settime'<br>
              collect2: error: ld returned 1 exit status<br>
              make: *** [vmlinux] Error 1<br>
              <br>
              <br>
            </div>
            <div>Vegard<br>
            </div>
          </div>
        </div>
      </div>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">------------------------------------------------------=
------------------------
</pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
User-mode-linux-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:User-mode-linux-devel@=
lists.sourceforge.net">User-mode-linux-devel@lists.sourceforge.net</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/li=
sts/listinfo/user-mode-linux-devel">https://lists.sourceforge.net/lists/lis=
tinfo/user-mode-linux-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------060105040807070204060608--


--===============5394897027442926570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============5394897027442926570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5394897027442926570==--



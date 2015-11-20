Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZzomU-0001H6-JD
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 16:43:26 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZzomS-00051F-KX
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 16:43:26 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=smaug.kot-begemot.co.uk) by ivanoab4.miniserver.com with esmtps
	(TLS1.2:RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZzomL-0008Ry-MZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 16:43:17 +0000
Received: from monstrousnightmare.kot-begemot.co.uk ([192.168.3.80])
	by smaug.kot-begemot.co.uk with esmtp (Exim 4.84)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZzomL-0001xg-GX
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 16:43:17 +0000
Message-ID: <564F4DA5.3090203@kot-begemot.co.uk>
Date: Fri, 20 Nov 2015 16:43:17 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <895313f7-cd23-4139-b991-95a1f858b70f@email.android.com>
	<564F48B6.1080403@kot-begemot.co.uk>
In-Reply-To: <564F48B6.1080403@kot-begemot.co.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7230250856384230337=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] IRQ handler reentrancy
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============7230250856384230337==
Content-Type: multipart/alternative;
	boundary="------------060106050609030903090109"

This is a multi-part message in MIME format.
--------------060106050609030903090109
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

[snip]

>> I hope the change in arch/um/kernel/skas/MMU.c isn't the cause of all this trouble!
> No it is not, but it is one that needs refinement. Fix coming up in 10
> minutes or so, I was just cleaning up the patches for submission.
>
> The issue is reentrancy of the core interrupt logic which the code in
> unblock_signals is supposed to prevent, but it fails (for some reason)
> to do so.

Some of it looks like a heisenbug from debugging by the way.

If you look in softirq.c you see:

#ifdef CONFIG_TRACE_IRQFLAGS
local_irq_enable <http://lxr.free-electrons.com/ident?i=local_irq_enable>()
#endif

That in UML translates to unblock_signals(). That in turn will 
re-execute hardware interrupts out of a software IRQ bottom half context.

There is still an inherent reentrancy issue, but I suspect that it is 
less with the debugging off.

Patchset coming up in next email. It throws bh warnings if you have 
CONFIG_TRACE_IRQFLAGS, but that is not something I can fix in first pass.

A.

--------------060106050609030903090109
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    [snip]<br>
    <br>
    <blockquote cite=3D"mid:564F48B6.1080403@kot-begemot.co.uk"
      type=3D"cite">
      <blockquote type=3D"cite">
        <pre wrap=3D"">I hope the change in arch/um/kernel/skas/MMU.c isn't=
 the cause of all this trouble!
</pre>
      </blockquote>
      <pre wrap=3D"">
No it is not, but it is one that needs refinement. Fix coming up in 10=20
minutes or so, I was just cleaning up the patches for submission.

The issue is reentrancy of the core interrupt logic which the code in=20
unblock_signals is supposed to prevent, but it fails (for some reason)=20
to do so.</pre>
    </blockquote>
    <br>
    Some of it looks like a heisenbug from debugging by the way.<br>
    <br>
    If you look in softirq.c you see:<br>
    <br>
    #ifdef CONFIG_TRACE_IRQFLAGS<br>
    =EF=BF=BD=EF=BF=BD=EF=BF=BD <a
      href=3D"http://lxr.free-electrons.com/ident?i=3Dlocal_irq_enable">loc=
al_irq_enable</a>()<br>
    #endif<br>
    <br>
    That in UML translates to unblock_signals(). That in turn will
    re-execute hardware interrupts out of a software IRQ bottom half
    context.<br>
    <br>
    There is still an inherent reentrancy issue, but I suspect that it
    is less with the debugging off.<br>
    <br>
    Patchset coming up in next email. It throws bh warnings if you have
    CONFIG_TRACE_IRQFLAGS, but that is not something I can fix in first
    pass.<br>
    <br>
    A.
  </body>
</html>

--------------060106050609030903090109--


--===============7230250856384230337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============7230250856384230337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============7230250856384230337==--



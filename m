Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IjsCs-0000C3-N9 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 01:00:14 -0700
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IjsCq-000489-57
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 01:00:14 -0700
Date: Mon, 22 Oct 2007 03:58:04 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
In-Reply-To: <20071022074823.GJ2998@hacking>
Message-ID: <Pine.LNX.4.64.0710220356470.5772@localhost.localdomain>
References: <20071021114854.GF2455@hacking>
	<20071021130848.GA4621@c2.user-mode-linux.org>
	<20071021132031.GI2455@hacking>
	<20071021154346.GW8181@ftp.linux.org.uk>
	<20071022043746.GF2998@hacking>
	<20071022052214.GY8181@ftp.linux.org.uk>
	<20071022061245.GG2998@hacking> <87d4v7fy5i.fsf@hades.wkstn.nix>
	<20071022065202.GI2998@hacking>
	<20071022065943.GC10864@uranus.ravnborg.org>
	<20071022074823.GJ2998@hacking>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-379407579-1193039884=:5772"
Subject: Re: [uml-devel] User Mode Linux still doesn't build in 2.6.23-final.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>, Al Viro <viro@ftp.linux.org.uk>, Sam Ravnborg <sam@ravnborg.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-379407579-1193039884=:5772
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 22 Oct 2007, WANG Cong wrote:

> On Mon, Oct 22, 2007 at 08:59:43AM +0200, Sam Ravnborg wrote:
> >On Mon, Oct 22, 2007 at 02:52:02PM +0800, WANG Cong wrote:
> >> On Mon, Oct 22, 2007 at 07:42:33AM +0100, Nix wrote:
> >> >On 22 Oct 2007, WANG Cong uttered the following:
> >> >> I build UML for non-SMP x86. But I don't know about UML_NET_VDE. ;(
> >> >>
> >> >> Errors threw out by gcc (too many) are put here:
> >> >> =09http://wangcong.org/down/errors.txt
> >> >
> >> >It's hard to tell without LOCALE=3DC, but those are the sorts of resu=
lts
> >> >I'd expect if you had run make {old,menu,x}config without specifying
> >> >ARCH=3Dum, so you've configured for one architecture and are now tryi=
ng
> >> >to build another.
> >> >
> >> >Where is the include/asm symlink pointing to in your build tree?
> >>
> >> $ ls -l include/asm
> >> lrwxrwxrwx 1 wangcong wangcong 6 2007-10-22 12:34 include/asm -> asm-u=
m
> >>
> >> OK. Let me do the following:
> >>
> >> =09$ make mrproper
> >
> >Please try
> >make ARCH=3Dum mrproper
> >
> >this will clean up the additional uml symlinks.
> >
>
> Hi, Sam, Al and others.
>
> I just followed what Sam told me, errors are much fewer this time,
> but still exist. Error messages are:
>
>   CC      arch/um/kernel/syscall.o
>   CC      arch/um/kernel/sysrq.o
> arch/um/kernel/sysrq.c: In function =FF=FFshow_stack=FF=FF:
> arch/um/kernel/sysrq.c:63: error: =FF=FFUESP=FF=FF undeclared (first use =
in this function)
> arch/um/kernel/sysrq.c:63: error: (Each undeclared identifier is reported=
 only once
> arch/um/kernel/sysrq.c:63: error: for each function it appears in.)
> make[1]: *** [arch/um/kernel/sysrq.o] Error 1
> make: *** [arch/um/kernel] Error 2
>
> Or I missed something again?
>
> And I use `make defconfig ARCH=3Dum' to generate .config, my tree
> is 2.6.23-git16 (Al, is this OK?).

that looks like a cut-and-paste error since the file
include/asm-um/arch/ptrace-abi.h opens with:

=3D=3D=3D=3D=3D
#ifndef _ASM_X86_PTRACE_ABI_H
#define _ASM_X86_PTRACE_ABI_H

#ifdef __i386__

#define EBX 0
#define ECX 1
#define EDX 2
#define ESI 3
#define EDI 4
#define EBP 5
#define EAX 6
#define DS 7
#define ES 8
#define FS 9
#define GS 10
#define ORIG_EAX 11
#define EIP 12
#define CS  13
#define EFL 14
#define UESP 15
=2E....
=3D=3D=3D=3D=3D

  somehow, that doesn't look right.

rday
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://crashcourse.ca
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--8323328-379407579-1193039884=:5772
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--8323328-379407579-1193039884=:5772
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--8323328-379407579-1193039884=:5772--


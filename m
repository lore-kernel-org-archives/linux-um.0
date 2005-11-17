Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ecs6U-0005Tb-Gf for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 14:19:38 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ecs6T-0007zA-Ps
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 14:19:38 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
References: <200511161100.31053.rob@landley.net>
	<200511170958.17364.rob@landley.net>
	<20051117174017.GA7062@ccure.user-mode-linux.org>
In-Reply-To: <20051117174017.GA7062@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511171619.23427.rob@landley.net>
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
Date: Thu, 17 Nov 2005 16:19:23 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thursday 17 November 2005 11:40, Jeff Dike wrote:
> On Thu, Nov 17, 2005 at 09:58:17AM -0600, Rob Landley wrote:
> > That means you didn't get the uml-miniconf I attached to my message
> > copied into allno.config in the source directory.  (Did I typo my
> > script?)
>
> Figured it out.  When you do a O= build, the allno.config has to be in the
> object directory.

Strange, when I tried it here the allno.config had to be in the source 
directory.  (Which I considered a bug.)  Today I've been specifying the 
environment variable explicitly, to by pass the whole issue.

> Anyhoo, stock -rc1 builds and runs fine here with that config.

Here it boots up to a prompt, and I can type stuff at that prompt even, but if 
I try to do anything like whoami or ls, it dies.  I could try to narrow down 
which syscall it's dying on, if you like.

Here's the dissassembly you asked for (of plain 2.6.15-rc1 on my x86 laptop):

0811c0b0 <stub_segv_handler>:
 811c0b0:       8b 44 24 5c             mov    0x5c(%esp),%eax
 811c0b4:       8d 54 24 08             lea    0x8(%esp),%edx
 811c0b8:       a3 04 f0 ff bf          mov    %eax,0xbffff004
 811c0bd:       8b 44 24 3c             mov    0x3c(%esp),%eax
 811c0c1:       a3 00 f0 ff bf          mov    %eax,0xbffff000
 811c0c6:       8b 44 24 38             mov    0x38(%esp),%eax
 811c0ca:       a3 08 f0 ff bf          mov    %eax,0xbffff008
 811c0cf:       b8 14 00 00 00          mov    $0x14,%eax
 811c0d4:       cd 80                   int    $0x80
 811c0d6:       89 c3                   mov    %eax,%ebx
 811c0d8:       b8 25 00 00 00          mov    $0x25,%eax
 811c0dd:       b9 0a 00 00 00          mov    $0xa,%ecx
 811c0e2:       cd 80                   int    $0x80
 811c0e4:       89 d0                   mov    %edx,%eax
 811c0e6:       89 c4                   mov    %eax,%esp
 811c0e8:       b8 77 00 00 00          mov    $0x77,%eax
 811c0ed:       cd 80                   int    $0x80
 811c0ef:       c3                      ret

0811c000 <stub_clone_handler>:
 811c000:       83 ec 14                sub    $0x14,%esp
 811c003:       ba 78 00 00 00          mov    $0x78,%edx
 811c008:       b9 fc f7 ff bf          mov    $0xbffff7fc,%ecx
 811c00d:       89 5c 24 04             mov    %ebx,0x4(%esp)
 811c011:       89 d0                   mov    %edx,%eax
 811c013:       bb 11 84 00 00          mov    $0x8411,%ebx
 811c018:       89 6c 24 10             mov    %ebp,0x10(%esp)
 811c01c:       bd 00 f0 ff bf          mov    $0xbffff000,%ebp
 811c021:       89 74 24 08             mov    %esi,0x8(%esp)
 811c025:       89 7c 24 0c             mov    %edi,0xc(%esp)
 811c029:       cd 80                   int    $0x80
 811c02b:       85 c0                   test   %eax,%eax
 811c02d:       89 c7                   mov    %eax,%edi
 811c02f:       75 5c                   jne    811c08d 
<stub_clone_handler+0x8d>
 811c031:       b8 1a 00 00 00          mov    $0x1a,%eax
 811c036:       89 fb                   mov    %edi,%ebx
 811c038:       89 f9                   mov    %edi,%ecx
 811c03a:       89 fa                   mov    %edi,%edx
 811c03c:       89 fe                   mov    %edi,%esi
 811c03e:       cd 80                   int    $0x80
 811c040:       85 c0                   test   %eax,%eax
 811c042:       89 c7                   mov    %eax,%edi
 811c044:       75 47                   jne    811c08d 
<stub_clone_handler+0x8d>
 811c046:       be 68 00 00 00          mov    $0x68,%esi
 811c04b:       bb 01 00 00 00          mov    $0x1,%ebx
 811c050:       b9 08 f0 ff bf          mov    $0xbffff008,%ecx
 811c055:       89 f0                   mov    %esi,%eax
 811c057:       89 fa                   mov    %edi,%edx
 811c059:       cd 80                   int    $0x80
 811c05b:       85 c0                   test   %eax,%eax
 811c05d:       89 c7                   mov    %eax,%edi
 811c05f:       75 2c                   jne    811c08d 
<stub_clone_handler+0x8d>
 811c061:       8b 1d 00 f0 ff bf       mov    0xbffff000,%ebx
 811c067:       b9 00 10 00 00          mov    $0x1000,%ecx
 811c06c:       ba 03 00 00 00          mov    $0x3,%edx
 811c071:       be 11 00 00 00          mov    $0x11,%esi
 811c076:       8b 3d 04 f0 ff bf       mov    0xbffff004,%edi
 811c07c:       89 d8                   mov    %ebx,%eax
 811c07e:       89 eb                   mov    %ebp,%ebx
 811c080:       55                      push   %ebp
 811c081:       89 c5                   mov    %eax,%ebp
 811c083:       b8 c0 00 00 00          mov    $0xc0,%eax
 811c088:       cd 80                   int    $0x80
 811c08a:       5d                      pop    %ebp
 811c08b:       89 c7                   mov    %eax,%edi
 811c08d:       89 7d 18                mov    %edi,0x18(%ebp)
 811c090:       cc                      int3
 811c091:       8b 5c 24 04             mov    0x4(%esp),%ebx
 811c095:       8b 74 24 08             mov    0x8(%esp),%esi
 811c099:       8b 7c 24 0c             mov    0xc(%esp),%edi
 811c09d:       8b 6c 24 10             mov    0x10(%esp),%ebp
 811c0a1:       83 c4 14                add    $0x14,%esp
 811c0a4:       c3                      ret
 811c0a5:       90                      nop
 811c0a6:       90                      nop
 811c0a7:       90                      nop
 811c0a8:       90                      nop
 811c0a9:       90                      nop
 811c0aa:       90                      nop
 811c0ab:       90                      nop
 811c0ac:       90                      nop
 811c0ad:       90                      nop
 811c0ae:       90                      nop
 811c0af:       90                      nop


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

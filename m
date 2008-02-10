Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JOIRK-0007BI-Tr for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Feb 2008 12:06:14 -0800
Received: from fg-out-1718.google.com ([72.14.220.154])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JOIRJ-0005YN-1t
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Feb 2008 12:06:14 -0800
Received: by fg-out-1718.google.com with SMTP id d23so3597797fga.32
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 10 Feb 2008 12:06:11 -0800 (PST)
Message-ID: <47AF5930.5080907@gmail.com>
Date: Sun, 10 Feb 2008 21:06:08 +0100
From: Jiri Olsa <olsajiri@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] compile problem
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Hi,

I have problem with last Linus' git tree:

scripts/kconfig/conf -s arch/um/Kconfig
  SYMLINK arch/um/include/kern_constants.h
  SYMLINK arch/um/include/sysdep
  CHK     arch/um/include/uml-config.h
  UPD     arch/um/include/uml-config.h
  CC      arch/um/sys-i386/user-offsets.s
In file included from /usr/include/asm/ptrace.h:5,
                 from arch/um/sys-i386/user-offsets.c:7:
/usr/include/asm/ptrace-abi.h:92: error: expected specifier-qualifier-list before 'u32'
arch/um/sys-i386/user-offsets.c: In function 'foo':
arch/um/sys-i386/user-offsets.c:20: error: 'struct sigcontext' has no member named 'eip'
arch/um/sys-i386/user-offsets.c:21: error: 'struct sigcontext' has no member named 'esp'
arch/um/sys-i386/user-offsets.c:28: error: 'struct sigcontext' has no member named 'eflags'
arch/um/sys-i386/user-offsets.c:29: error: 'struct sigcontext' has no member named 'eax'
arch/um/sys-i386/user-offsets.c:30: error: 'struct sigcontext' has no member named 'ebx'
arch/um/sys-i386/user-offsets.c:31: error: 'struct sigcontext' has no member named 'ecx'
arch/um/sys-i386/user-offsets.c:32: error: 'struct sigcontext' has no member named 'edx'
arch/um/sys-i386/user-offsets.c:33: error: 'struct sigcontext' has no member named 'edi'
arch/um/sys-i386/user-offsets.c:34: error: 'struct sigcontext' has no member named 'esi'
arch/um/sys-i386/user-offsets.c:35: error: 'struct sigcontext' has no member named 'ebp'
make[1]: *** [arch/um/sys-i386/user-offsets.s] Error 1
make: *** [arch/um/sys-i386/user-offsets.s] Error 2


v2.6.24 is working for me...

thanks,
Jiri Olsa

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

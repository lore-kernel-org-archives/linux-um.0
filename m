Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fkc02-0008Bp-KJ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 May 2006 00:17:14 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fkc02-0004VD-A3
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 May 2006 00:17:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.scgiservices.com (Postfix) with ESMTP id 8E2FF3C5C6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 May 2006 00:17:12 -0700 (PDT)
Received: from mail.scgiservices.com ([127.0.0.1])
	by localhost (mail [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 17002-04 for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 May 2006 00:17:11 -0700 (PDT)
Received: from SCG2 (c-67-160-154-69.hsd1.or.comcast.net [67.160.154.69])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id 732BE3C5AF
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 May 2006 00:17:11 -0700 (PDT)
From: "Anthony Brock" <brocka@sterlingcgi.com>
Subject: RE: [uml-devel] Warnings compiling linux-2.6.17-rc5
Message-ID: <LEEIJGBJEEABAGOFFGAHMEHEDGAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20060529032647.GA4907@ccure.user-mode-linux.org>
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
Date: Mon, 29 May 2006 00:17:11 -0700
To: UML Developer's List <user-mode-linux-devel@lists.sourceforge.net>

> On Sun, May 28, 2006 at 04:50:33PM -0700, Anthony Brock wrote:
> > I just tried to compile a new guest kernel using the
> linux-2.6.17-rc5 kernel
> > source and encountered the following warnings.
> > WARNING: vmlinux - Section mismatch: reference to
> .init.setup:__setup_nosmp
> > from .bss between 'stderr@@GLIBC_2.0' (at offset 0x82607c4) and
> > 'completed.4463'
>
> These I have no clue about.  I've seen them with a native build, so
> they appear not to be UML-specific.  Looks like a broken linker.  The
> resulting UML works fine, so this is nasty-looking, but non-fatal.

Good. I'll ignore them.

> > WARNING: /mnt/lib/modules/2.6.17-rc5/kernel/net/ipv6/ipv6.ko
> needs unknown
> > symbol strcpy
>
> This is fixed in my current tree.

I actually looked through these patches before asking:

http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.17-rc4/patches.t
ar

I didn't see anything that appeared to address this. However, I'll try
applying these and test from there.

Thanks!

Tony

BTW, this compile was run on Debian Testing (Etch):


# gcc -v
Using built-in specs.
Target: i486-linux-gnu
Configured with:
../src/configure -v --enable-languages=c,c++,java,f95,objc,ada,treelang --pr
efix=/usr --enable-shared --with-system-zlib --libexecdir=/usr/lib --without
-included-gettext --enable-threads=posix --enable-nls --program-suffix=-4.0 
--enable-__cxa_atexit --enable-clocale=gnu --enable-libstdcxx-debug --enable
-java-awt=gtk-default --enable-gtk-cairo --with-java-home=/usr/lib/jvm/java-
1.4.2-gcj-4.0-1.4.2.0/jre --enable-mpfr --disable-werror --with-tune=i686 --
enable-checking=release i486-linux-gnu
Thread model: posix
gcc version 4.0.4 20060507 (prerelease) (Debian 4.0.3-3)
# ld -V
GNU ld version 2.16.91 20060413 Debian GNU/Linux
  Supported emulations:
   elf_i386
   i386linux
   elf_x86_64



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

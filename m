Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DH0AS-0002Eo-HD for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Mar 2005 05:57:04 -0800
Received: from dsl-084-056-239-202.arcor-ip.net ([84.56.239.202]
	helo=qualle.fzk.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DH0AQ-0006xY-BT for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Mar 2005 05:57:03 -0800
Received: from localhost.luise.net (localhost.luise.net [127.0.0.1])
	by qualle.fzk.de (Postfix) with ESMTP id E10D87AF9C
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 31 Mar 2005 15:56:55 +0200 (CEST)
From: Marcus Hardt <marcus.hardt@iwr.fzk.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503311556.54795.marcus.hardt@iwr.fzk.de>
Subject: [uml-devel] 2.6.10 compilation error
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
Date: Thu, 31 Mar 2005 15:56:53 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi Guys!

Whenever I try to compile a 2.6 guest kernel, I get a compilation error:

linux-2.6.9]$ cat ../uml-2.6.9-bs7.patch.bz2 | bzip2 -d | patch -p1
linux-2.6.9]$ make ARCH=um xconfig
linux-2.6.9]$ make ARCH=um
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/um/kernel/built-in.o(.text+0x23c8): In function `mem_init':
: undefined reference to `phys_page'
arch/um/kernel/built-in.o(.init.text+0x203): In function `kmap_init':
: undefined reference to `pte_offset'
collect2: ld returned 1 exit status
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2

What am I doing wrong?
Help greatly appreciated!
-- 
Marcus


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

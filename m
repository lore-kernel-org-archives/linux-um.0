Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRsyJ-00013P-L7 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 06:24:59 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BRsyI-00063v-UZ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 06:24:59 -0700
Message-ID: <07f201c440ca$5686c1e0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
	<02dc01c43c4a$bb7c0490$2000000a@schlepptopp>
	<1084831251.1230.4.camel@chartreuse>
	<03ff01c43c5d$7db6e5e0$2000000a@schlepptopp>
	<20040518175904.GB29114@ccure.user-mode-linux.org>
	<1084987654.2250.4.camel@chartreuse>
	<012201c43dcb$402ca6a0$2000000a@schlepptopp>
	<1084990661.2255.28.camel@chartreuse>
	<018a01c43dd9$0173f270$2000000a@schlepptopp>
	<1084996157.2256.36.camel@chartreuse>
	<05a001c43e12$7affe2a0$2000000a@schlepptopp>
	<1085057350.1197.2.camel@chartreuse>
Subject: Re: [uml-devel] [PATCH] host context switch reduction
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Sun, 23 May 2004 15:31:59 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Laurent Vivier <LaurentVivier@wanadoo.fr>

hi,
i know  - i`m an awful bad programmer - but perhaps someone can help me implementing /proc/sysemu ?
that`s somewhat "cosmetic stuff" for turning sysemu (http://perso.wanadoo.fr/laurent.vivier/UML)
on/off at runtime. (yes - this isn`t really important feature - but i would like to have that feature
and i like hacking it for programming exercise purpose) :)

i added the following to arch/um/kernel/process.c (that`s, where most of the sysemu patch goes into):

#include "linux/proc_fs.h"
#include "linux/file.h"

static struct file_operations proc_sysemu_fops;

static int make_proc_sysemu(void)
{
    struct proc_dir_entry *ent;
    ent = create_proc_entry("sysemu", 0x777, &proc_root);
    if(ent == NULL){
             printk("Failed to register /proc/sysemu\n");
             return(0);
    }
    ent->proc_fops = &proc_mm_fops;

    return(0);
}

compile fails with:

gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=\"i386\" -D
_LARGEFILE64_SOURCE   -Iarch/um/include  -I/tmp/uml/2.6.6/linux-2.6.6/arch/um/kernel/tt/include -I/tmp/uml/2.6.6/linux-2.6.6/arch/um
/kernel/skas/include -D_GNU_SOURCE -Os -g -c -o arch/um/kernel/process.o arch/um/kernel/process.c
In file included from arch/um/kernel/process.c:47:
/usr/include/linux/proc_fs.h:244: error: field `vfs_inode' has incomplete type
/usr/include/linux/proc_fs.h: In function `PROC_I':
/usr/include/linux/proc_fs.h:249: error: parse error before "struct"
In file included from arch/um/kernel/process.c:48:
/usr/include/linux/file.h: At top level:
/usr/include/linux/file.h:33: error: `BITS_PER_LONG' undeclared here (not in a function)
arch/um/kernel/process.c: In function `make_proc_sysemu':
arch/um/kernel/process.c:61: error: `proc_mm_fops' undeclared (first use in this function)
arch/um/kernel/process.c:61: error: (Each undeclared identifier is reported only once
arch/um/kernel/process.c:61: error: for each function it appears in.)
arch/um/kernel/process.c: At top level:
arch/um/kernel/process.c:313: warning: initialization from incompatible pointer type
arch/um/kernel/process.c:50: error: storage size of `proc_sysemu_fops' isn't known
arch/um/kernel/process.c:50: warning: `proc_sysemu_fops' defined but not used
arch/um/kernel/process.c:53: warning: `make_proc_sysemu' defined but not used
make[1]: *** [arch/um/kernel/process.o] Error 1
make: *** [arch/um/kernel] Error 2


this looks like the wrong header-files being included.
scratching my head now.....

can someone give me a hint ?

regards
roland

ps:
sorry - maybe this is a dumb error and maybe i shouldn`t start with such complex things -
but i don`t like to program the tutorials written down in a c-programming book :)



----- Original Message ----- 
From: "Laurent Vivier" <LaurentVivier@wanadoo.fr>
To: "roland" <for_spam@gmx.de>
Cc: <user-mode-linux-devel@lists.sourceforge.net>; "Jeff Dike" <jdike@addtoit.com>; <blaisorblade_spam@yahoo.it>
Sent: Thursday, May 20, 2004 2:49 PM
Subject: Re: [uml-devel] [PATCH] host context switch reduction




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

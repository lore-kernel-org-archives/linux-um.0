Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DsRpO-0006sw-N6	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 13:58:06 -0700
Received: from agminet04.oracle.com ([141.146.126.231])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DsRpN-0005Ll-Kp	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 13:58:06 -0700
Received: from agminet04.oracle.com (localhost [127.0.0.1])
	j6CKvxtw009990	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 Jul 2005 15:57:59 -0500
Received: from rgmsgw300.us.oracle.com (rgmsgw300.us.oracle.com
	[138.1.186.49])j6CKvxDA009970
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 Jul 2005 15:57:59 -0500
Received: from rgmsgw300.us.oracle.com (localhost [127.0.0.1])
	j6CKvw6k016752	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 Jul 2005 14:57:58 -0600
Received: from [138.2.230.92] (agraves-lnx.us.oracle.com [138.2.230.92])
	j6CKvw0j016745
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 Jul 2005 14:57:58 -0600
Message-ID: <42D42ED5.4000101@oracle.com>
From: Allan Graves <allan.graves@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000805080307050305080500"
Subject: [uml-devel] Clarification of UML and AIO?
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
Date: Tue, 12 Jul 2005 16:57:57 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000805080307050305080500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi guys...  Trying to do some AIO stuff here, and got a question.  
Perhaps I'm not understanding how AIO works in UML...  Could someone 
perhaps give me an explanation of why we end up in pread, instead of 
aio?  Does UML not support AIO through its block device driver?
Thank you,
Allan

The simple test program:

#include <aio.h>
#include <errno.h>
#include <fcntl.h>

main()
{
       struct aiocb aiocb;
       int fd;
       char buf[1024];

       fd = open("/tmp/outfile", O_RDONLY);
       perror("open");

       bzero(&aiocb, sizeof(aiocb));
       aiocb.aio_fildes = fd;
       aiocb.aio_buf = buf;
       aiocb.aio_nbytes = sizeof(buf);

       aio_read(&aiocb);
       perror("aio_read");

       while (aio_error(&aiocb) == EINPROGRESS);
       printf("buf = %s\n", buf);
}

Tracing the aio_read() through the UML kernel finally gets me here:

#0  sys_pread64 (fd=3, buf=0xbf7c8f20 "", count=1024, pos=0)
   at fs/read_write.c:354
#1  0x08062ff8 in execute_syscall_skas (r=0x12374864)
   at arch/um/kernel/skas/syscall_kern.c:29
#2  0x0806302f in handle_syscall (regs=0x12374864)
   at arch/um/kernel/skas/syscall_user.c:25
#3  0x08062651 in userspace (regs=0x12374864)
   at arch/um/kernel/skas/process.c:91
#4  0x08062d44 in fork_handler (sig=10) at thread_info.h:47
#5  <signal handler called>
#6  0xffffe410 in __kernel_vsyscall ()
#7  0x00000000 in ?? ()
(gdb)


--------------000805080307050305080500
Content-Type: text/x-vcard; charset=utf8;
 name="allan.graves.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="allan.graves.vcf"

begin:vcard
fn:Allan Graves
n:Graves;Allan
email;internet:allan.graves@oracle.com
tel;work:603-8973276
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------000805080307050305080500--


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

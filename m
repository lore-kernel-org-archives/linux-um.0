Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DslUb-0000sI-Gy	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 10:57:57 -0700
Received: from agminet04.oracle.com ([141.146.126.231])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DslUa-0005GY-Ea	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 10:57:57 -0700
Received: from agminet04.oracle.com (localhost [127.0.0.1])
	j6DHvnsY019911	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 13 Jul 2005 12:57:49 -0500
Received: from rgmsgw300.us.oracle.com (rgmsgw300.us.oracle.com
	[138.1.186.49])j6DHvnwK019892
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 13 Jul 2005 12:57:49 -0500
Received: from rgmsgw300.us.oracle.com (localhost [127.0.0.1])
	j6DHvmkB014675	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 13 Jul 2005 11:57:48 -0600
Received: from [138.2.230.92] (agraves-lnx.us.oracle.com [138.2.230.92])
	j6DHvl5h014668
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 13 Jul 2005 11:57:48 -0600
Message-ID: <42D5561B.8010004@oracle.com>
From: Allan Graves <allan.graves@oracle.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Clarification of UML and AIO?
References: <42D42ED5.4000101@oracle.com>
	<20050712220327.GB4469@ccure.user-mode-linux.org>
In-Reply-To: <20050712220327.GB4469@ccure.user-mode-linux.org>
Content-Type: multipart/mixed;
 boundary="------------030209040505050103040905"
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
Date: Wed, 13 Jul 2005 13:57:47 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030209040505050103040905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff, Blaisor, you're exactly right.  Linux aio uses io_submit, not 
aio_read, it seems.  aio_read calls clone to make a new thread to do its 
"aio".  Thank you all for your help.
Allan

Jeff Dike wrote:

>>Tracing the aio_read() through the UML kernel finally gets me here:
>>
>>#0  sys_pread64 (fd=3, buf=0xbf7c8f20 "", count=1024, pos=0)
>>  at fs/read_write.c:354
>>#1  0x08062ff8 in execute_syscall_skas (r=0x12374864)
>>  at arch/um/kernel/skas/syscall_kern.c:29
>>    
>>
>
>Finally?  That's the very beginning of the system call (or the very end).
>
>The UML block device doesn't know about AIO.  All it does is get blocks from
>a disk.
>
>Are you sure you're getting kernel AIO and not the libc emulation of it?
>
>				Jeff
>  
>

--------------030209040505050103040905
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


--------------030209040505050103040905--


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

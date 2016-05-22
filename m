Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@gmail.com>) id 1b4VU3-0006sC-Qj
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 May 2016 15:40:03 +0000
Received: from mail-vk0-f65.google.com ([209.85.213.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b4VU2-0003JQ-Jr
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 May 2016 15:40:03 +0000
Received: by mail-vk0-f65.google.com with SMTP id e126so23229273vkb.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 22 May 2016 08:40:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6AAB4FAC-99C2-4B3C-88CA-C210193E74EF@m3y3r.de>
References: <CAOMGZ=GpWk1=9HeTxz6NBVh-Y8TZS8ZBHaaqDdxOqvRHD+f_TQ@mail.gmail.com>
	<6AAB4FAC-99C2-4B3C-88CA-C210193E74EF@m3y3r.de>
Date: Sun, 22 May 2016 17:39:57 +0200
Message-ID: <CAOMGZ=H-fi-Wqmc36ts5LULSe=QD9Q-ys7GKryFWRZw_iO-J=A@mail.gmail.com>
From: Vegard Nossum <vegard.nossum@gmail.com>
Subject: Re: [uml-devel] current_thread_info() returns invalid pointer in
 early UML boot code
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

On 21 May 2016 at 20:18, Thomas Meyer <thomas@m3y3r.de> wrote:
> Am 21.05.2016 um 15:51 schrieb Vegard Nossum <vegard.nossum@gmail.com>:
>> I'm having some trouble with using current_thread_info() during UML
>> early boot. Sometimes it works just fine, but often I get segfaults
>> because current_thread_info() is returning an invalid pointer. It
>> looks random: 0x202118, 0x1003e0003, 0xd33b90b3, 0x6db043, etc.
>
> Mhh. Strange. Do you have a stack trace to call to current thread info which ends up with a wrong value. I wonder from were it originates.

One such trace would be:

#2  0x000000006026652c in snprintf (buf=<optimized out>,
size=<optimized out>, fmt=<optimized out>) at lib/vsprintf.c:2181
#3  0x00000000600046f8 in setup_env_path () at arch/um/os-Linux/main.c:109
#4  main (argc=3, argv=0x7ffc3d8c23e8, envp=<optimized out>) at
arch/um/os-Linux/main.c:125

I wonder why setup_env_path() ends up calling the kernel's snprintf(),
I thought that it would be using the glibc snprintf() at this point?


Vegard

------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


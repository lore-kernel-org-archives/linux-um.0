Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8iiS-0004ru-Tp for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 10:09:40 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1C8iiR-0005Ai-Lp for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 10:09:40 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] weird hanging when uml starts up
References: <Pine.GSO.4.58.0409151257150.24774@tokyo.cc.gatech.edu>
In-Reply-To: <Pine.GSO.4.58.0409151257150.24774@tokyo.cc.gatech.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409181213.22295.blaisorblade_spam@yahoo.it>
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
Date: Sat, 18 Sep 2004 12:13:22 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Younggyun Koh <young@cc.gatech.edu>

On Wednesday 15 September 2004 19:02, Younggyun Koh wrote:
> Hi,
>
> i inserted some code in uml network stack, but after that, i can't boot
> uml in skas mode. (it's okay with tt mode, tho)

I understand this, too, but the code is wrong even with TT mode. There are 
some internal difference between TT and SKAS mode that make the crash certain 
in SKAS mode and just possible in TT mode. See below.

> the code i inserted is...

> asmlinkage long sys_sendto(int fd, void * buff, size_t len, unsigned
> flags,
> 			   struct sockaddr *addr, int addr_len)
> {
> 	struct socket *sock;
> 	char address[MAX_SOCK_ADDR];
> 	int err;
> 	struct msghdr msg;
> 	struct iovec iov;

> #ifdef MY_CODE
> 	{
> 	if (len > 16 && ((char *)buff)[0] == '$' && ((char *)buff)[1] ==
> '$')
> 	{
> 		unsigned long ts1 = my_rdtscl();
> 		sprintf(buff+2, "%u\0", ts1);
Please, the correct line is:

sprintf(buff+2, "%ul", ts1);

both because for an unsigned long you use "%ul", while "%u" is for an unsigned 
int, and because sprintf NULL-terminates the string by itself - and this is 
more or less in the third lesson of "C for dummies". Are you sure you are 
able to try kernel hacking?

Also, could you use a better name for "ts1"?
> 	}
> 	}
> #endif
> ....

> and uml hands on "Configuring kernel paramaters"
You mean "hangs"?

> anyone has any idea what's wrong with it?

Well, I understand perfectly what is wrong with that.
Have you got an idea of why copy_from_user exists? Well, in this case, 
remember that you may not access "buff" without first calling 
copy_from_user(). For more info, see:
http://www.xml.com/ldd/chapter/book/ch03.html#t8

However, if you never heard about that, this is the explaination. You are 
never allowed to say *buff if "buff" is a pointer to user-space memory (such 
pointers, in 2.6, are marked with __user). The pointed memory could have been 
swapped out, or a malicious program could want to make the kernel fault and 
pass an invalid address, or whatever. copy_from_user does what's needed. And 
copy_to_user writes safely to user-space memory. However, you can see that 
the code seem to behave well because it sometimes succeed.

But, in SKAS mode, or with the 4G/4G patch from Ingo Molnar (which is NOT for 
UML, but for normal kernels), dereferencing a pointer without copy_from_user 
can never succeed. This because different page tables are loaded for 
user-space and kernel-space, so a certain address points to different 
locations for kernel and user space.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

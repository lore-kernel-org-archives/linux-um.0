Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKHhL-00013t-Kr	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Sep 2005 08:48:51 -0700
Received: from qproxy.gmail.com ([72.14.204.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EKHgz-0001WQ-Lm
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Sep 2005 08:48:51 -0700
Received: by qproxy.gmail.com with SMTP id f10so532534qba
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 27 Sep 2005 08:48:19 -0700 (PDT)
Message-ID: <3524bf1f050927070645b999bd@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Subject: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
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
Date: Tue, 27 Sep 2005 10:06:53 -0400
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

i have a question about copy_from/to_user() implementation in skas mode.

as my understanding,
when copy_from/to_user() is  invoked, before the address translation
happens, UML kernel calls sigsetjmp() to come back when there is a
segmentation fault. and if there is, it seems that the system call an
application triggered eventually returns EFAULT. then, it seems to me
that sigsetjmp() is to catch the error when the application gave the
invalid user space address.

my question is, if so, shouldn't the error be caught when UML kernel
translates the user space address to the kernel space address? i mean,
UML kernel must know the valid memory regions and if the address is
out of the valid regions, then it knows the address is invalid before
UML tries to access the address. why should it use sigsetjmp() and let
a segfault occur?

Thank you in advance,

-Young


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

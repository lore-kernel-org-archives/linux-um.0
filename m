Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z3ND-0008B2-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 17:07:15 -0700
Received: from hongkong.cs.nmsu.edu ([128.123.64.160] ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19z3NC-0000t0-KM
	for User-mode-linux-devel@lists.sourceforge.net; Mon, 15 Sep 2003 17:07:14 -0700
From: Ross Combs <rocombs@cs.nmsu.edu>
Message-Id: <200309160007.h8G076ST030849@hongkong.cs.nmsu.edu>
Subject: Re: [uml-devel] Re: 2.4.22-4um race condition
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 15 Sep 2003 18:07:06 -0600
To: rocombs@cs.nmsu.edu, steve_schmidtke@hotmail.com
Cc: User-mode-linux-devel@lists.sourceforge.net

"Steve Schmidtke" <steve_schmidtke@hotmail.com> wrote:

> rocombs@cs.nmsu.edu wrote:
> >The "correct" fix seems to have completely removed the errors.
> >I just moved these two lines:
> >
> >        kernel_fd = fds[0];
> >        *fd_out = fds[1];
> >
> >to before the clone() in ubd_user.c.  Is this correct?
>
> There's a few things I noticed with start_io_thread, though mostly to do 
> with failing cleanly.  Try the attached patch for 2.4.22-4um.

Thanks, that worked just fine.  I made a merged patch which also moves
the continue out of the inner if of io_thread().  There's no reason to
compound an error by using uninitialized memory.  I also added the
extra information to the printk()s.

I also moved the assignment for the other end of the pipe up and set
it to -1 on error.  It shouldn't matter since the caller won't use the
fd if the function fails, but this way fd_out is guaranteed to be
invalid on error and the pipe fd assignments are always kept together.

-Ross



--- orig/arch/um/drivers/ubd_user.c	2003-09-15 12:13:47.000000000 -0600
+++ merged/arch/um/drivers/ubd_user.c	2003-09-15 12:14:30.000000000 -0600
@@ -317,21 +317,17 @@
 	while(1){
 		n = os_read_file(kernel_fd, &req, sizeof(req));
 		if(n != sizeof(req)){
-			if(n < 0) {
-				printk("io_thread - read failed, err = %d\n", 
-				       -n);
-			} 
-			else {
-				printk("io_thread - short read : length = %d\n",
-				       n);
-				continue;
-			}
+			if(n < 0)
+				printk("io_thread - read failed, fd = %d, err = %d\n", kernel_fd, -n);
+			else
+				printk("io_thread - short read, fd = %d, length = %d\n", kernel_fd, n);
+			continue;
 		}
 		io_count++;
 		do_io(&req);
 		n = os_write_file(kernel_fd, &req, sizeof(req));
 		if(n != sizeof(req))
-			printk("io_thread - write failed, err = %d\n", -n);
+			printk("io_thread - write failed, fd = %d, err = %d\n", kernel_fd, -n);
 	}
 }
 
@@ -342,24 +338,29 @@
 	err = os_pipe(fds, 1, 1);
 	if(err < 0){
 		printk("start_io_thread - os_pipe failed, err = %d\n", -err);
-		return(err);
+		goto err_out;
 	}
 
+	kernel_fd = fds[0];
+	*fd_out = fds[1];
+
 	pid = clone(io_thread, (void *) sp, CLONE_FILES | CLONE_VM | SIGCHLD,
 		    NULL);
 	if(pid < 0){
 		printk("start_io_thread - clone failed : errno = %d\n", errno);
-		goto err;
+		err = -errno;
+		goto close_out;
 	}
 
-	kernel_fd = fds[0];
-	*fd_out = fds[1];
-
 	return(pid);
- err:
+
+ close_out:
+	kernel_fd = -1;
+	*fd_out = -1;
 	os_close_file(fds[0]);
 	os_close_file(fds[1]);
-	return(-errno);
+ err_out:
+	return(err);
 }
 
 /*


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7WCl-0003Z6-9W for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Mar 2004 01:03:43 -0800
Received: from ns.theshore.net ([216.156.129.65] helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B7WCk-0004Wx-DG for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Mar 2004 01:03:42 -0800
Received: from hawk (pcp08670149pcs.500ash01.tn.comcast.net [69.137.84.52])
	by www.theshore.net (8.12.9/8.9.1) with SMTP id i2S96hMi003583
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 28 Mar 2004 04:06:43 -0500
Message-ID: <004901c414a3$f4d28a80$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0046_01C41471.A6386430"
Subject: [uml-devel] [PATCH] I/O-Request Token Bucket Limiter
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
Date: Sun, 28 Mar 2004 03:06:22 -0600
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>


This is a multi-part message in MIME format.

------=_NextPart_000_0046_01C41471.A6386430
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Patch is also available here:
http://www.theshore.net/~caker/patches/

Apply to a tree already patched with 2.4-um or 2.6-um.

-Chris

---token-limiter-v1.README---

This patch implements a simple token bucket filter/limiter on requests
processed through the async io_thread.  It will work with or without COW,
but not on ubd devices in sync mode.

* Two new command line arguments for setting at boot-time:

token_max=60000
    This sets the maximum tokens in the token-bucket I/O request limiter.
    Each io_thread request subtracts one token from the bucket.  The bucket
    is supplied with <token_refill> tokens every second.  When the bucket
    becomes empty, I/O requests are throttled to the <token_refill> rate.

token_refill=2000
    This sets the bucket's refill rate, adding <token_refill> tokens to the
    bucket every second. This becomes the I/O request rate when the bucket
    becomes empty.

* Three new mconsole commands to get status information and change the two 
variables above:

(mconsole) help
    io_status - Return current I/O status and settings
    io_token_max <num> - sets the bucket size
    io_token_refill <num> - number of tokens to add each second

* Example io_status output while:

idle:
io_count=1845202 io_rate=0 io_tokens=50000 token_refill=1024 \
token_max=50000

bursting:
io_count=1861594 io_rate=6806 io_tokens=35754 token_refill=1024 \
token_max=50000

throttled:
io_count=1994811 io_rate=1087 io_tokens=-153 token_refill=1024 \
token_max=50000 
io_count=2052289 io_rate=1057 io_tokens=-286 token_refill=1024 \
token_max=50000
io_count=2067794 io_rate=1015 io_tokens=-132 token_refill=1024 \
token_max=50000

Our sample shows io_tokens being negative, but - while waiting for the bucket 
to be re-supplied, requests will still dribble through no faster than 
token_refill req/second. Or, perhaps this is due to inaccuracies of nanosleep
or a bug in my logic.

* TODO
Stop using an alarm in the io_thread, and instead use gettimeofday to 
calculate the token credits due and io_rate.



------=_NextPart_000_0046_01C41471.A6386430
Content-Type: application/octet-stream;
	name="token-limiter-v1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="token-limiter-v1.patch"

diff -aur -X diff-exclude linode23/arch/um/drivers/mconsole_kern.c =
linode23-limiter/arch/um/drivers/mconsole_kern.c=0A=
--- linode23/arch/um/drivers/mconsole_kern.c	2004-02-18 =
20:04:28.000000000 -0500=0A=
+++ linode23-limiter/arch/um/drivers/mconsole_kern.c	2004-03-28 =
00:04:44.546996347 -0500=0A=
@@ -30,6 +30,7 @@=0A=
 #include "os.h"=0A=
 #include "umid.h"=0A=
 #include "irq_kern.h"=0A=
+#include "ubd_user.h"=0A=
 =0A=
 static int do_unlink_socket(struct notifier_block *notifier, =0A=
 			    unsigned long what, void *data)=0A=
@@ -219,6 +220,9 @@=0A=
     go - continue the UML after a 'stop' \n\=0A=
     log <string> - make UML enter <string> into the kernel log\n\=0A=
     proc <file> - returns the contents of the UML's /proc/<file>\n\=0A=
+    io_status - Return current I/O status and settings\n\=0A=
+    io_token_max <num> - sets the bucket size\n\=0A=
+    io_token_refill <num> - number of tokens to add each second\n\=0A=
 "=0A=
 =0A=
 void mconsole_help(struct mc_request *req)=0A=
@@ -548,6 +552,51 @@=0A=
 =0A=
 EXPORT_SYMBOL(mconsole_notify_socket);=0A=
 =0A=
+void mconsole_io_status(struct mc_request *req)=0A=
+{=0A=
+	char str[256];=0A=
+=0A=
+	sprintf(str, "io_count=3D%d io_rate=3D%d io_tokens=3D%d =
token_refill=3D%d token_max=3D%d",=0A=
+		get_io_count(),=0A=
+		get_io_rate(),=0A=
+		get_io_tokens(),=0A=
+		get_token_refill(),=0A=
+		get_token_max()=0A=
+	);=0A=
+=0A=
+	mconsole_reply(req, str, 0, 0);=0A=
+}=0A=
+=0A=
+void mconsole_io_token_refill(struct mc_request *req)=0A=
+{=0A=
+	char *end;=0A=
+	int n;	=0A=
+=0A=
+	char *ptr =3D req->request.data;=0A=
+	ptr +=3D strlen("io_token_refill ");=0A=
+	n =3D simple_strtoul(ptr, &end, 0);=0A=
+=0A=
+	if (n>0) =0A=
+		set_token_refill(n);=0A=
+=0A=
+	mconsole_io_status(req);=0A=
+}=0A=
+=0A=
+void mconsole_io_token_max(struct mc_request *req)=0A=
+{=0A=
+	char *end;=0A=
+	int n;=0A=
+=0A=
+	char *ptr =3D req->request.data;=0A=
+	ptr +=3D strlen("io_token_max ");=0A=
+	n =3D simple_strtoul(ptr, &end, 0);=0A=
+=0A=
+	if (n>0) =0A=
+		set_token_max(n);=0A=
+=0A=
+	mconsole_io_status(req);=0A=
+}=0A=
+=0A=
 /*=0A=
  * Overrides for Emacs so that we follow Linus's tabbing style.=0A=
  * Emacs will notice this stuff at the end of the file and automatically=0A=
diff -aur -X diff-exclude linode23/arch/um/drivers/mconsole_user.c =
linode23-limiter/arch/um/drivers/mconsole_user.c=0A=
--- linode23/arch/um/drivers/mconsole_user.c	2004-02-18 =
20:04:28.000000000 -0500=0A=
+++ linode23-limiter/arch/um/drivers/mconsole_user.c	2004-03-26 =
20:32:12.129731275 -0500=0A=
@@ -30,6 +30,9 @@=0A=
 	{ "go", mconsole_go, MCONSOLE_INTR },=0A=
 	{ "log", mconsole_log, MCONSOLE_INTR },=0A=
 	{ "proc", mconsole_proc, MCONSOLE_PROC },=0A=
+	{ "io_status", mconsole_io_status, MCONSOLE_INTR },=0A=
+	{ "io_token_refill", mconsole_io_token_refill, MCONSOLE_INTR },=0A=
+	{ "io_token_max", mconsole_io_token_max, MCONSOLE_INTR },=0A=
 };=0A=
 =0A=
 /* Initialized in mconsole_init, which is an initcall */=0A=
diff -aur -X diff-exclude linode23/arch/um/drivers/ubd_user.c =
linode23-limiter/arch/um/drivers/ubd_user.c=0A=
--- linode23/arch/um/drivers/ubd_user.c	2004-02-18 20:04:28.000000000 =
-0500=0A=
+++ linode23-limiter/arch/um/drivers/ubd_user.c	2004-03-28 =
01:03:07.265680876 -0500=0A=
@@ -26,6 +26,10 @@=0A=
 #include <endian.h>=0A=
 #include <byteswap.h>=0A=
 =0A=
+#include <stdlib.h>=0A=
+#include <time.h>=0A=
+#include "init.h"=0A=
+=0A=
 static int same_backing_files(char *from_cmdline, char *from_cow, char =
*cow)=0A=
 {=0A=
 	struct uml_stat buf1, buf2;=0A=
@@ -307,12 +311,23 @@=0A=
 /* Only changed by the io thread */=0A=
 int io_count =3D 0;=0A=
 =0A=
+/* Are set by the kernel and read from the io_thread or vice-versa */=0A=
+int token_refill =3D 2000;// add this many tokens to the bucket every =
second=0A=
+int token_delay =3D 1000000000 / 2000;=0A=
+int token_max =3D 60000;  // max tokens in bucket=0A=
+int io_tokens =3D 60000;  // token bucket=0A=
+int io_count_last =3D 0;  // snapshot of io_count last time in =
io_alarm()=0A=
+int io_rate =3D 0;        // calculated io ops per second=0A=
+=0A=
 int io_thread(void *arg)=0A=
 {=0A=
 	struct io_thread_req req;=0A=
 	int n;=0A=
 =0A=
 	signal(SIGWINCH, SIG_IGN);=0A=
+	signal(SIGALRM, io_alarm);=0A=
+	io_alarm(14);=0A=
+=0A=
 	while(1){=0A=
 		n =3D os_read_file(kernel_fd, &req, sizeof(req));=0A=
 		if(n !=3D sizeof(req)){=0A=
@@ -327,6 +342,7 @@=0A=
 		}=0A=
 		io_count++;=0A=
 		do_io(&req);=0A=
+		io_delay();=0A=
 		n =3D os_write_file(kernel_fd, &req, sizeof(req));=0A=
 		if(n !=3D sizeof(req))=0A=
 			printk("io_thread - write failed, fd =3D %d, err =3D %d\n",=0A=
@@ -365,6 +381,103 @@=0A=
 	return(err);=0A=
 }=0A=
 =0A=
+void io_alarm(int sig)=0A=
+{=0A=
+	io_rate =3D io_count - io_count_last;=0A=
+	io_count_last =3D io_count;=0A=
+=0A=
+	io_tokens +=3D token_refill;=0A=
+	if (io_tokens > token_max){=0A=
+		io_tokens =3D token_max;=0A=
+	}=0A=
+=0A=
+	/* printk("io_alarm - current speed: %d, io_tokens : %d \n", =0A=
+		io_rate, io_tokens); */=0A=
+=0A=
+	alarm(1);=0A=
+}=0A=
+=0A=
+void io_delay()=0A=
+{=0A=
+	io_tokens--;=0A=
+	if (io_tokens <=3D 0) {=0A=
+		struct timespec ts;=0A=
+		ts.tv_sec =3D 0;=0A=
+		ts.tv_nsec =3D token_delay;=0A=
+		nanosleep(&ts, NULL);=0A=
+	}=0A=
+}=0A=
+=0A=
+int set_token_refill(int tokens)=0A=
+{=0A=
+	token_refill =3D tokens;=0A=
+=0A=
+	token_delay =3D 1000;=0A=
+	if (token_refill)=0A=
+		token_delay =3D 1000000000 / token_refill;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+int get_token_refill()=0A=
+{=0A=
+	return token_refill;=0A=
+}=0A=
+=0A=
+int get_io_count()=0A=
+{=0A=
+	return io_count;=0A=
+}=0A=
+=0A=
+int set_token_max(int tokens)=0A=
+{=0A=
+	token_max =3D tokens;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+int get_token_max()=0A=
+{=0A=
+	return token_max;=0A=
+}=0A=
+=0A=
+int get_io_rate()=0A=
+{=0A=
+	return io_rate;=0A=
+}=0A=
+=0A=
+int get_io_tokens()=0A=
+{=0A=
+	return io_tokens;=0A=
+}=0A=
+=0A=
+static int cmdline_token_max(char *name, int *add)=0A=
+{=0A=
+	set_token_max(atoi(name));=0A=
+	return(0);=0A=
+}=0A=
+=0A=
+__uml_setup("token_max=3D", cmdline_token_max,=0A=
+"token_max=3D60000\n" \=0A=
+"    This sets the maximum tokens in the token-bucket I/O request =
limiter.\n"   \=0A=
+"    Each io_thread request subtracts one token from the bucket.  The =
bucket\n" \=0A=
+"    is supplied with <token_refill> tokens every second.  When the =
bucket\n"   \=0A=
+"    becomes empty, I/O requests are throttled to the <token_refill> =
rate.\n\n"=0A=
+);=0A=
+=0A=
+=0A=
+static int cmdline_token_refill(char *name, int *add)=0A=
+{=0A=
+	set_token_refill(atoi(name));=0A=
+	return(0);=0A=
+}=0A=
+=0A=
+__uml_setup("token_refill=3D", cmdline_token_refill,=0A=
+"token_refill=3D2000\n" \=0A=
+"    This sets the bucket's refill rate, adding <token_refill> tokens =
to the\n" \=0A=
+"    bucket every second. This becomes the I/O request rate when the =
bucket\n"  \=0A=
+"    becomes empty.\n\n"=0A=
+);=0A=
+=0A=
 /*=0A=
  * Overrides for Emacs so that we follow Linus's tabbing style.=0A=
  * Emacs will notice this stuff at the end of the file and automatically=0A=
diff -aur -X diff-exclude linode23/arch/um/include/mconsole.h =
linode23-limiter/arch/um/include/mconsole.h=0A=
--- linode23/arch/um/include/mconsole.h	2004-02-18 20:04:28.000000000 =
-0500=0A=
+++ linode23-limiter/arch/um/include/mconsole.h	2004-03-26 =
20:31:32.333430818 -0500=0A=
@@ -81,6 +81,9 @@=0A=
 extern void mconsole_go(struct mc_request *req);=0A=
 extern void mconsole_log(struct mc_request *req);=0A=
 extern void mconsole_proc(struct mc_request *req);=0A=
+extern void mconsole_io_status(struct mc_request *req);=0A=
+extern void mconsole_io_token_refill(struct mc_request *req);=0A=
+extern void mconsole_io_token_max(struct mc_request *req);=0A=
 =0A=
 extern int mconsole_get_request(int fd, struct mc_request *req);=0A=
 extern int mconsole_notify(char *sock_name, int type, const void *data, =0A=
diff -aur -X diff-exclude linode23/arch/um/include/ubd_user.h =
linode23-limiter/arch/um/include/ubd_user.h=0A=
--- linode23/arch/um/include/ubd_user.h	2004-02-18 20:04:28.000000000 =
-0500=0A=
+++ linode23-limiter/arch/um/include/ubd_user.h	2004-03-27 =
22:23:18.413800952 -0500=0A=
@@ -42,6 +42,18 @@=0A=
 extern int start_io_thread(unsigned long sp, int *fds_out);=0A=
 extern void do_io(struct io_thread_req *req);=0A=
 =0A=
+static int cmdline_token_max(char *name, int *add);=0A=
+static int cmdline_token_refill(char *name, int *add);=0A=
+extern void io_delay(void);=0A=
+extern void io_alarm(int sig);=0A=
+extern int set_token_refill(int tokens);=0A=
+extern int get_token_refill(void);=0A=
+extern int set_token_max(int tokens);=0A=
+extern int get_token_max(void);=0A=
+extern int get_io_count(void);=0A=
+extern int get_io_tokens(void);=0A=
+extern int get_io_rate(void);=0A=
+=0A=
 static inline int ubd_test_bit(__u64 bit, unsigned char *data)=0A=
 {=0A=
 	__u64 n;=0A=

------=_NextPart_000_0046_01C41471.A6386430--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

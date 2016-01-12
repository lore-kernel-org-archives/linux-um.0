Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <james_mcmechan@hotmail.com>) id 1aJ6RQ-0006md-KR
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jan 2016 21:25:24 +0000
Received: from col004-omc3s6.hotmail.com ([65.55.34.144])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aJ6RO-0002xg-QK
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jan 2016 21:25:24 +0000
Message-ID: <COL125-W47EB609169B3E9DEC76EAAE2CA0@phx.gbl>
From: James McMechan <james_mcmechan@hotmail.com>
Date: Tue, 12 Jan 2016 13:25:16 -0800
In-Reply-To: <1450724041-708451-2-git-send-email-aivanov@brocade.com>
References: <1450724041-708451-1-git-send-email-aivanov@brocade.com>,
	<1450724041-708451-2-git-send-email-aivanov@brocade.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 2/2] Bulk IO Transaction support part 1
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Anton Ivanov <aivanov@brocade.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: "richard@nod.at" <richard@nod.at>

I am a bit late getting back to you=A0 on this but I do have a few comments
The safe_read seems out of tune currently.
Or maybe I am just totally confused :)

> This patch adds support for merging notifications on the ubd
> notification file descriptor. Multiple transactions are processed
> at a time resulting in 10-15% virtual disk speed improvement.
>
> The mechanics are rather primitive - no ring buffers, primitive
> guaranteed flush and guaranteed to-record-size read.
>
> Signed-off-by: Anton Ivanov <aivanov@brocade.com>
> ---
> arch/um/drivers/ubd.h | 2 +
> arch/um/drivers/ubd_kern.c | 156 ++++++++++++++++++++++++++++++++++++----=
----
> arch/um/drivers/ubd_user.c | 19 +++++-
> arch/um/include/shared/os.h | 1 +
> arch/um/os-Linux/file.c | 12 ++++
> 5 files changed, 161 insertions(+), 29 deletions(-)
>
> diff --git a/arch/um/drivers/ubd.h b/arch/um/drivers/ubd.h
> index 3b48cd2..2c5e6fd 100644
> --- a/arch/um/drivers/ubd.h
> +++ b/arch/um/drivers/ubd.h
> @@ -10,6 +10,8 @@
> extern int start_io_thread(unsigned long sp, int *fds_out);
> extern int io_thread(void *arg);
> extern int kernel_fd;
> +extern void setup_ubd_pollfd(void * fds, int fd);
> +extern int size_of_pollfd(void);
>
> #endif
>
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 39ba207..9f30c50 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -58,6 +58,12 @@ struct io_thread_req {
> int error;
> };
>
> +static void * kernel_pfd =3D NULL;

These are pointer to pointers?
so this will be an array of 64 pointers kmalloced?
> +struct io_thread_req **kernel_reqs;
> +
> +struct io_thread_req **helper_reqs;
> +
> static inline int ubd_test_bit(__u64 bit, unsigned char *data)
> {
> __u64 n;
> @@ -442,6 +448,32 @@ static void do_ubd_request(struct request_queue * q);
> static int thread_fd =3D -1;
> static LIST_HEAD(restart);
>

This would be clearer if it was struct io_thread_req **buffer
Ok this is reading MAX_SG pointers rather than the previous single pointer
> +static int do_safe_read(int fd, void * buffer, int max_size, int record_=
size){
> + unsigned char * buf;
> + int n, size;
> +
> + size =3D 0;
> + buf =3D (unsigned char *) buffer;
> +
> + return os_read_file(fd, buf + size, max_size - size);

Your function ends here every thing else is dead code?

> +
> + do {
> + n =3D os_read_file(fd, buf, max_size - size);

Do you want to return on only no data or a set of complete pointers?
e.g. size % sizeof(void *) =3D=3D 0 maybe? then return size since we may ha=
ve several already.
// if we have not read anything yet we can return safely
> + if ((size =3D=3D 0) && (n =3D=3D -EAGAIN))
> + return n;

// update how much we have read so far
> + if (n> 0)
> + size =3D size + n;

A bit of shuffeling here might make it clearer and =

// discard whatever we have read in so far if we were not /going to block/ =
but errored
> + if ((n < 0) && (n !=3D -EAGAIN))
> + return n;

max_size should be a multiple of record size so the loop would exit anyway?
It might be better to fold it into the while clause below.
// when we have read the amount requested stop
> + if (size =3D=3D max_size)
> + break;

// stopping if we hit exactly record_size? so N full pointers have been rea=
d.
> + } while ((size % record_size) !=3D 0);

// return how much we actually read
> + return size;
> +}
> +
> +
> /* XXX - move this inside ubd_intr. */
> /* Called without dev->lock held, and only in interrupt context. */
> static void ubd_handler(void)
> @@ -450,21 +482,37 @@ static void ubd_handler(void)
> struct ubd *ubd;
> struct list_head *list, *next_ele;
> unsigned long flags;
> - int n;
> + int n, rcount, i;
>
> while(1){
> - n =3D os_read_file(thread_fd, &req,
> - sizeof(struct io_thread_req *));
> - if(n !=3D sizeof(req)){
> - if(n =3D=3D -EAGAIN)
> - break;
> - printk(KERN_ERR "spurious interrupt in ubd_handler, "
> - "err =3D %d\n", -n);
> - return;
> + n =3D do_safe_read(thread_fd, helper_reqs,
> + sizeof(struct io_thread_req *) * MAX_SG,
> + sizeof(struct io_thread_req *)
> + );


// no data pending so drop out of the loop
> + if(n =3D=3D -EAGAIN){
> + break;
> + }
> + if(n < 0){
> + printk("io_thread - read failed, fd =3D %d, "
> + "err =3D %d\n", thread_fd, -n);
> + }

// if we have a partial pointer complain
> + if(n % sizeof(struct io_thread_req *) !=3D 0){
> + printk("kernel_ubd_io - invalid read, fd =3D %d, "
> + "read =3D %d\n", thread_fd, n);
> + continue;
> }
>
> - blk_end_request(req->req, 0, req->length);
> - kfree(req);
> + rcount =3D n / sizeof(struct io_thread_req *);

// step through each io_thread_req * in order
> + for (i =3D 0; i < rcount; i++) {

Perhaps *helper_reqs[i] might be clearer dereferencing pointers to pointers
is often hard to understand.
> + req =3D * (helper_reqs + i);
> + blk_end_request(req->req, 0, req->length);
> + kfree(req);
> +
> + }
> }
> reactivate_fd(thread_fd, UBD_IRQ);
>
> @@ -1080,6 +1128,26 @@ late_initcall(ubd_init);
> static int __init ubd_driver_init(void){
> unsigned long stack;
> int err;
> +
> + kernel_reqs =3D kmalloc(MAX_SG * sizeof(struct io_thread_req *), GFP_KE=
RNEL);
> + if (kernel_reqs =3D=3D NULL) {
> + printk("Failed to allocate memory for req buffer\n");
> + return 0;
> + }
> +
> +
> + kernel_pfd =3D kmalloc(size_of_pollfd(), GFP_KERNEL);
> + if (kernel_pfd =3D=3D NULL) {
> + printk("Failed to allocate memory for pollfd\n");
> + return 0;
> + }
> +
> + helper_reqs =3D kmalloc(MAX_SG * sizeof(struct io_thread_req *), GFP_KE=
RNEL);
> + if (helper_reqs =3D=3D NULL) {

Failed to allocate memory for array of pointers to req buffers
> + printk("Failed to allocate memory for req buffer\n");
> + return 0;
> + }
> +
>
> /* Set by CONFIG_BLK_DEV_UBD_SYNC or ubd=3Dsync.*/
> if(global_openflags.s){
> @@ -1458,30 +1526,62 @@ static int io_count =3D 0;
> int io_thread(void *arg)
> {
> struct io_thread_req *req;
> - int n;
> + unsigned char * buffer;
> + int n, rcount, i;
>
> os_fix_helper_signals();
>
> + printk("Starting UBD helper thread\n");
> +
> while(1){
> - n =3D os_read_file(kernel_fd, &req,
> - sizeof(struct io_thread_req *));
> - if(n !=3D sizeof(struct io_thread_req *)){
> - if(n < 0)

The old code was missing the test for EAGAIN
it was not too likely to fail a 4 byte read or 8 byte on 64bit
but still it should have had it just in case.
> - printk("io_thread - read failed, fd =3D %d, "
> - "err =3D %d\n", kernel_fd, -n);
> - else {
> - printk("io_thread - short read, fd =3D %d, "
> - "length =3D %d\n", kernel_fd, n);
> - }

Ok, but why do we want to sit in poll here rather than read?
we are nonblocking on purpose right? why build a blocking non-blocking read?
> + setup_ubd_pollfd(kernel_pfd, kernel_fd);
> + os_poll(kernel_pfd, 1, -1);
> + n =3D do_safe_read(kernel_fd, kernel_reqs,
> + sizeof(struct io_thread_req *) * MAX_SG,
> + sizeof(struct io_thread_req *) * MAX_SG
> + );
> + if(n =3D=3D -EAGAIN){

it is annoying when diff spilts things so oddly
this closes the if n !=3D sizeof in the old code?
I guess it was supposed to read the rest of the =

req but if would read it at the beginning of the buffer?
> continue;
> }
> - io_count++;
> - do_io(req);
> - n =3D os_write_file(kernel_fd, &req,
> - sizeof(struct io_thread_req *));
> - if(n !=3D sizeof(struct io_thread_req *))
> + if(n < 0){
> + printk("io_thread - read failed, fd =3D %d, "
> + "err =3D %d\n", kernel_fd, -n);
> + }

Do you get a gain here? to try to read more than one pointer at a time
also you are testing for multiple of the size of the pointer?
> + if(n % sizeof(struct io_thread_req *) !=3D 0){
> + printk("io_thread - invalid read, fd =3D %d, "
> + "read =3D %d\n", kernel_fd, n);
> + continue;
> + }
> +
> + rcount =3D n / sizeof(struct io_thread_req *);
> +
> + for (i =3D 0; i < rcount; i++) {
> +
> + io_count++;
> +
> + req =3D * (kernel_reqs + i);
> +
> + do_io(req);
> +
> + }
> +
> + buffer =3D (unsigned char *) kernel_reqs;
> +
> + while (n> 0) {
> + i =3D os_write_file(kernel_fd, buffer, n);
> + if(i>=3D 0){
> + buffer =3D buffer + i;
> + n =3D n - i;
> + } else {

// We would block try again later
> + if(i !=3D -EAGAIN)
> + break;
> + }
> + }
> +
> + if(n> 0)
> printk("io_thread - write failed, fd =3D %d, err =3D %d\n",
> - kernel_fd, -n);
> + kernel_fd, -i);
> }
>
> return 0;
> diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
> index e376f9b..3abec4f 100644
> --- a/arch/um/drivers/ubd_user.c
> +++ b/arch/um/drivers/ubd_user.c
> @@ -17,10 +17,22 @@
> #include <sys/param.h>
> #include <endian.h>
> #include <byteswap.h>
> +#include <poll.h>
>
> #include "ubd.h"
> #include <os.h>
>
> +void setup_ubd_pollfd(void * fds, int fd) {
> + struct pollfd * pfds =3D (struct pollfd *) fds;
> + pfds->fd =3D fd;
> + pfds->events =3D POLLIN | POLLPRI;
> + pfds->revents =3D 0;
> +}
> +
> +int size_of_pollfd(void) {
> + return sizeof(struct pollfd);
> +}
> +
> int start_io_thread(unsigned long sp, int *fd_out)
> {
> int pid, fds[2], err;
> @@ -36,10 +48,15 @@ int start_io_thread(unsigned long sp, int *fd_out)
>
> err =3D os_set_fd_block(*fd_out, 0);
> if (err) {
> - printk("start_io_thread - failed to set nonblocking I/O.\n");
> + printk("start_io_thread - failed to set nonblocking I/O - kernel_fd.\n"=
);
> goto out_close;
> }
>
> + err =3D os_set_fd_block(kernel_fd, 0);
> + if (err) {
> + printk("start_io_thread - failed to set nonblocking I/O - user_fd.\n");
> + goto out_close;
> + }
> pid =3D clone(io_thread, (void *) sp, CLONE_FILES | CLONE_VM, NULL);
> if(pid < 0){
> err =3D -errno;
> diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
> index 7a04ddd..0b75efa 100644
> --- a/arch/um/include/shared/os.h
> +++ b/arch/um/include/shared/os.h
> @@ -149,6 +149,7 @@ extern int os_file_size(const char *file, unsigned lo=
ng long *size_out);
> extern int os_pread_file(int fd, void *buf, int len, unsigned long long o=
ffset);
> extern int os_pwrite_file(int fd, const void *buf, int count, unsigned lo=
ng long offset);
> extern int os_file_modtime(const char *file, unsigned long *modtime);
> +extern int os_poll(void *fds, unsigned int nfds, int timeout);
> extern int os_pipe(int *fd, int stream, int close_on_exec);
> extern int os_set_fd_async(int fd);
> extern int os_clear_fd_async(int fd);
> diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
> index 2db18cb..726b1e1 100644
> --- a/arch/um/os-Linux/file.c
> +++ b/arch/um/os-Linux/file.c
> @@ -14,6 +14,7 @@
> #include <sys/stat.h>
> #include <sys/un.h>
> #include <sys/types.h>
> +#include <poll.h>
> #include <os.h>
>
> static void copy_stat(struct uml_stat *dst, const struct stat64 *src)
> @@ -355,6 +356,17 @@ int os_file_modtime(const char *file, unsigned long =
*modtime)
> return 0;
> }
>
> +int os_poll(void *fds, unsigned int nfds, int timeout)
> +{
> + int n;
> +
> + CATCH_EINTR(n =3D poll((struct pollfd *) fds, nfds, timeout));
> + if (n < 0)
> + return -errno;
> +
> + return n;
> +}
> +
> int os_set_exec_close(int fd)
> {
> int err;

 		 	   		  =

---------------------------------------------------------------------------=
---
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=3D267308311&iu=3D/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


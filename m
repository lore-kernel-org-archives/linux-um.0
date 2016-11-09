Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <james_mcmechan@hotmail.com>) id 1c4VQ7-0005UP-8F
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Nov 2016 16:08:15 +0000
Received: from blu004-omc4s17.hotmail.com ([65.55.111.156])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c4VQ4-0006Rv-N9
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Nov 2016 16:08:15 +0000
From: James McMechan <james_mcmechan@hotmail.com>
Date: Wed, 9 Nov 2016 16:08:05 +0000
Message-ID: <CY4PR10MB1960E4B5113ADDFD5739EC1BE2B90@CY4PR10MB1960.namprd10.prod.outlook.com>
References: <1478680606-476779-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <1478680606-476779-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH v3] UBD Improvements Phase 1
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
To: "anton.ivanov@kot-begemot.co.uk" <anton.ivanov@kot-begemot.co.uk>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
Cc: "richard@nod.at" <richard@nod.at>, Anton Ivanov <aivanov@brocade.com>

Hi

I am not clear on the remainder/remainder_size would not a single offset pa=
rameter work? rather than copying it off and back?
also max_recs does not seem to used except to calculate max buffer size so =
would not using a buffer size be easier?
something like bulk_req_read( int fd, struct io_thread_req *buf, size_t len=
, size_t *offset)

+static int bulk_req_safe_read(
+=A0=A0=A0=A0=A0=A0 int fd,
+=A0=A0=A0=A0=A0=A0 struct io_thread_req * (*request_buffer)[],
+=A0=A0=A0=A0=A0=A0 struct io_thread_req **remainder,
+=A0=A0=A0=A0=A0=A0 int *remainder_size,
+=A0=A0=A0=A0=A0=A0 int max_recs
+=A0=A0=A0=A0=A0=A0 )
+{
+=A0=A0=A0=A0=A0=A0 int n =3D 0;
+=A0=A0=A0=A0=A0=A0 int res =3D 0;
+
+=A0=A0=A0=A0=A0=A0 if (*remainder_size > 0) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memmove(
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (char *=
) request_buffer,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (char *=
) remainder, *remainder_size
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 );
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n =3D *remainder_size;
+=A0=A0=A0=A0=A0=A0 }
+
+=A0=A0=A0=A0=A0=A0 res =3D os_read_file(
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fd,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ((char =
*) request_buffer) + *remainder_size,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeof(=
struct io_thread_req *)*max_recs
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 - *remainder_size

then here it would be
res =3D os_read_file(fd, buf+*offset,len-*offset)
Note that if this is ever multithreaded buf and offset or request_buffer/re=
mainder/remainder_size need to be kept separate

+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 );
+=A0=A0=A0=A0=A0=A0 if (res > 0) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n +=3D res;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((n % sizeof(struct io_threa=
d_req *)) > 0) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Read =
somehow returned not a multiple of dword
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * theor=
etically possible, but never observed in the
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * wild,=
 so read routine must be able to handle it
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */

maybe this should have a WARN_ON since it should never occur?

+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *remain=
der_size =3D n % sizeof(struct io_thread_req *);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memmove(
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 remainder,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 ((char *) request_buffer) +
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n/sizeof(struct io_thread_req *),
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 *remainder_size

I am pretty sure the 2nd parameter is off. I think it should be:
((char *) request_buffer) +(n/sizeof(struct io_thread_req *))*sizeof(struct=
 io_thread_req *)
also copying it off to a shared static buffer?

+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 );
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n =3D n=
 - *remainder_size;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
+=A0=A0=A0=A0=A0=A0 } else {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n =3D res;
+=A0=A0=A0=A0=A0=A0 }
+=A0=A0=A0=A0=A0=A0 return n;
+}
+
=A0/* Called without dev->lock held, and only in interrupt context. */
=A0static void ubd_handler(void)
=A0{
-=A0=A0=A0=A0=A0=A0 struct io_thread_req *req;
=A0=A0=A0=A0=A0=A0=A0=A0 struct ubd *ubd;
=A0=A0=A0=A0=A0=A0=A0=A0 struct list_head *list, *next_ele;
=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long flags;
=A0=A0=A0=A0=A0=A0=A0=A0 int n;
+=A0=A0=A0=A0=A0=A0 int count;
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 while(1){
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n =3D os_read_file(thread_fd, &=
req,
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 sizeof(struct io_thread_req *));
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if(n !=3D sizeof(req)){

if it is being rewritten n could just be the number of complete buffers for=
 the for loop below

+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n =3D bulk_req_safe_read(
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 thread_=
fd,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 irq_req=
_buffer,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &irq_re=
mainder,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &irq_re=
mainder_size,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 UBD_REQ=
_BUFFER_SIZE
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 );
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (n < 0) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if=
(n =3D=3D -EAGAIN)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 break;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr=
intk(KERN_ERR "spurious interrupt in ubd_handler, "
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 "err =3D %d\n", -n);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 re=
turn;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
-
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 blk_end_request(req->req, 0, re=
q->length);
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(req);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (count =3D 0; count < n/siz=
eof(struct io_thread_req *); count++) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 blk_end=
_request(
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 (*irq_req_buffer)[count]->req,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 (*irq_req_buffer)[count]->length
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 );
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree((=
*irq_req_buffer)[count]);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 reactivate_fd(thread_fd, UBD_IRQ);
=A0
@@ -1064,6 +1137,28 @@ static int __init ubd_init(void)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (register_blkdev(fake_m=
ajor, "ubd"))
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 re=
turn -1;
=A0=A0=A0=A0=A0=A0=A0=A0 }
+
+=A0=A0=A0=A0=A0=A0 irq_req_buffer =3D kmalloc(
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeof(=
struct io_thread_req *) * UBD_REQ_BUFFER_SIZE,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 GFP_KER=
NEL
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 );
+=A0=A0=A0=A0=A0=A0 irq_remainder =3D 0;
+
+=A0=A0=A0=A0=A0=A0 if (irq_req_buffer =3D=3D NULL) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk(KERN_ERR "Failed to init=
ialize ubd buffering\n");
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -1;
+=A0=A0=A0=A0=A0=A0 }

Ok, I am really not tracking this, the same buffer allocated twice?

+=A0=A0=A0=A0=A0=A0 io_req_buffer =3D kmalloc(
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeof(=
struct io_thread_req *) * UBD_REQ_BUFFER_SIZE,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 GFP_KER=
NEL
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 );
+
+=A0=A0=A0=A0=A0=A0 io_remainder =3D 0;
+
+=A0=A0=A0=A0=A0=A0 if (io_req_buffer =3D=3D NULL) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk(KERN_ERR "Failed to init=
ialize ubd buffering\n");
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -1;
+=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 platform_driver_register(&ubd_driver);
=A0=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&ubd_lock);
=A0=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < MAX_DEV; i++){



Sorry of the poor email I am using a web interface and it keeps dropping ch=
ars...

Jim
---------------------------------------------------------------------------=
---
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iLO4X-00028d-Tb
 for linux-um@lists.infradead.org; Fri, 18 Oct 2019 08:57:23 +0000
Message-ID: <7a2c14d38873a5c19f395cc7861fd9811589ca79.camel@sipsolutions.net>
Subject: Re: uml segfault during I/O
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 18 Oct 2019 10:57:15 +0200
In-Reply-To: <b742bf38-9cf5-e62f-55df-915929fd526f@cambridgegreys.com>
References: <a1307b17bd3f51d84d9195760492d1ef284b6382.camel@researchut.com>
 <1ccf27d8-6b6a-7d08-acef-93077f07511b@cambridgegreys.com>
 <5dc5e0694d2fcf2f8bb083e3861fd1b39c768b8c.camel@researchut.com>
 <cf1294b2-e1cc-961c-e8e1-d070fe0ea94d@cambridgegreys.com>
 <c7135e15-d2e4-3bce-9584-9032ddca72fe@cambridgegreys.com>
 <4892b3ca-6b26-0b96-d21f-ac8b31fb2270@cambridgegreys.com>
 <b742bf38-9cf5-e62f-55df-915929fd526f@cambridgegreys.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, rrs@researchut.com, linux-um@lists.infradead.org

On Fri, 2019-10-18 at 08:35 +0100, Anton Ivanov wrote:
> 
> Still happening with 5.2.21, albeit a bit more difficult to reproduce.

Just randomly reviewing the code, isn't there a bug in io_thread()?

--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1602,7 +1602,8 @@ int io_thread(void *arg)
                written = 0;
 
                do {
-                       res = os_write_file(kernel_fd, ((char *) io_req_buffer) + written, n);
+                       res = os_write_file(kernel_fd, ((char *) io_req_buffer) + written,
+                                           n - written);
                        if (res >= 0) {
                                written += res;
                        }

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4l6L-0003Bz-GW for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 11:53:57 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C4l6J-00066e-IU for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 11:53:57 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 1/3] uml-ubd-no-empty-queue
References: <20040906174447.238788D1E@zion.localdomain>
	<20040907093559.GL6323@suse.de>
In-Reply-To: <20040907093559.GL6323@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409072050.25814.blaisorblade_spam@yahoo.it>
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
Date: Tue, 7 Sep 2004 20:50:25 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jens Axboe <axboe@suse.de>, akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Tuesday 07 September 2004 11:35, Jens Axboe wrote:
> On Mon, Sep 06 2004, blaisorblade_spam@yahoo.it wrote:

> Patch is correct.
Ok, thanks. Do you see anything else that needs fixing? The code the patch 
below removes has hidden this bug, so there could be other serious bugs (and 
by serious I mean Oopses or data loss).

Known issues:
- need to port to BIOs (a bit hard because I need first to understand the 
request mangling - see cowify_req. The code idea is to redirect each sector 
independently either to the UBD backing file or to the COW file. COW stand 
for Copy On Write: it allows to have the UBD read only and a COW file 
containing just the changes).

- Uml SMP support does not compile from sometimes so spinlocking is broken in 
ubd_finish (only in some cases - when called by do_ubd_request and thread_fd 
== -1). To see this, add ubd=sync on command line and turn spinlock debugging 
on.

--- uml-linux-2.6.8.1/arch/um/drivers/ubd_kern.c~uml-ubd-any-elevator   
2004-08-29 14:40:53.731043416 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c  2004-08-29 
14:40:53.733043112 +0200
@@ -749,8 +749,6 @@ int ubd_init(void)
                return -1;
        }
                
-       elevator_init(ubd_queue, &elevator_noop);
-
        if (fake_major != MAJOR_NR) {
                char name[sizeof("ubd_nnn\0")];
 
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

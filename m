Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C56vW-0005Dj-43 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 11:12:14 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C56vV-0002z1-6z for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 11:12:13 -0700
From: Chris Wright <chrisw@osdl.org>
Message-ID: <20040908111204.I1973@build.pdx.osdl.net>
References: <20040908172503.384144933@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908172503.384144933@zion.localdomain>;
	from blaisorblade_spam@yahoo.it on Wed, Sep 08, 2004 at
	07:25:02PM +0200
Subject: [uml-devel] Re: [patch 1/1] uml:fix ubd deadlock on SMP
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
Date: Wed, 8 Sep 2004 11:12:04 -0700
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

* blaisorblade_spam@yahoo.it (blaisorblade_spam@yahoo.it) wrote:
> 
> Trivial: don't lock the queue spinlock when called from the request function.
> Since the faulty function must use spinlock in another case, double-case it.
> And since we will never use both functions together, let no object code be
> shared between them.

Why not add a helper which locks around the core function.  Then either
call helper or core function directly depending on locking needs?

Smth. along the lines of below.

===== arch/um/drivers/ubd_kern.c 1.36 vs edited =====
--- 1.36/arch/um/drivers/ubd_kern.c	2004-08-24 02:08:18 -07:00
+++ edited/arch/um/drivers/ubd_kern.c	2004-09-08 11:06:54 -07:00
@@ -396,14 +396,20 @@
  */
 int intr_count = 0;
 
-static void ubd_finish(struct request *req, int error)
+static inline void ubd_finish(struct request *req, int error)
+{
+ 	spin_lock(&ubd_io_lock);
+	__ubd_finish(req, error);
+	spin_unlock(&ubd_io_lock);
+}
+
+/* call ubd_finish if you need to serialize */
+static void __ubd_finish(struct request *req, int error)
 {
 	int nsect;
 
 	if(error){
- 		spin_lock(&ubd_io_lock);
 		end_request(req, 0);
- 		spin_unlock(&ubd_io_lock);
 		return;
 	}
 	nsect = req->current_nr_sectors;
@@ -412,9 +418,7 @@
 	req->errors = 0;
 	req->nr_sectors -= nsect;
 	req->current_nr_sectors = 0;
-	spin_lock(&ubd_io_lock);
 	end_request(req, 1);
-	spin_unlock(&ubd_io_lock);
 }
 
 static void ubd_handler(void)
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

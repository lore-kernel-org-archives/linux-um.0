Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BL6uX-0003XS-VH for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 May 2004 13:53:05 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BL6uX-0006UT-HB
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 May 2004 13:53:05 -0700
Message-Id: <200405042136.i44La3kI004256@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [patch] 2.4 hostfs no longer mounts specified
	directory 
In-Reply-To: Your message of "Sat, 24 Apr 2004 13:21:22 +0200."
	<Pine.LNX.4.44.0404241303430.3819-200000@filer.marasystems.com> 
References: <Pine.LNX.4.44.0404241303430.3819-200000@filer.marasystems.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 04 May 2004 17:36:03 -0400
To: Henrik Nordstrom <uml@henrik.marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Thanks, applied.

Except for this bit:

@@ -243,7 +245,7 @@ 
static int stat_fs(long *bsize_out, long
 		   void *fsid_out, int fsid_size, long *namelen_out, 
 		   long *spare_out, void *mount)
 {
-	const char *path[] = { jail_dir, mount, NULL };
+	const char *path[] = { jail_dir, mount, mount, NULL };
 
 	return(host_statfs(path, bsize_out, blocks_out, bfree_out, bavail_out, 
 			   files_out, ffree_out, fsid_out, fsid_size, 

What's up with that, anyway?

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

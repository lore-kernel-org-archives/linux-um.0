Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BtN6W-0003ii-Pc for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Aug 2004 02:03:04 -0700
Received: from mail.tpgi.com.au ([203.12.160.113])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BtN6W-0006Ud-4g
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Aug 2004 02:03:04 -0700
Received: from mail.dimtech.com.au (203-213-62-14-syd-ts10-2600.tpgi.com.au
	[203.213.62.14])
	by mail.tpgi.com.au (8.12.10/8.12.10) with ESMTP id i77930Dc012693
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 7 Aug 2004 19:03:01 +1000
From: Peter Hartshorn <peter@dimtech.com.au>
Reply-To: peter@dimtech.com.au
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408071859.12858.peter@dimtech.com.au>
Subject: [uml-devel] Bug in hostfs
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
Date: Sat, 7 Aug 2004 18:59:12 +1000
To: user-mode-linux-devel@lists.sourceforge.net

I just started hacking in uml. First thing I did was to re-enable reporting of 
real uid and gid for hostfs files (I needed it). Then I noticed that I could 
only write to a file if it had the execute bit set (ie 0744). I narrowed this 
down to the following:

file: arch/um/fs/hostfs/host_fs.c
line: 60

original:
static int access_file(char *file, int uid, int gid, int r, int w, int x,

modified:
static in access_file(char *file, int r, int w, int x, int uid, int gid,

So, as you can see, the parameters for the function were in the wrong order.
The order was also changed in the hostfs.h file.

PS. sorry about the lack of a patch (I didn't think it was a big enough patch)



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

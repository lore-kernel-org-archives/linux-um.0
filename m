Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CoxFW-0000jQ-C8 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 21:10:22 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CoxFU-00071u-CF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 21:10:22 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501130612.34417.blaisorblade@yahoo.it>
Subject: [uml-devel] About "jiffies" patch
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
Date: Thu, 13 Jan 2005 06:12:34 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Well, effectively your reasoning holds, apart for one point: the code should 
not hang because of that large INITIAL_JIFFIES. What we care about are only 
the value of jiffies relative to INITIAL_JIFFIES, indeed.

In fact, that code works on 64-bit arch's. But INITIAL_JIFFIES is not 0 to 
make sure it wraps 5 minutes after the boot, to make sure the wrapping 
mechanism is debugged. And this, currently, does not happen likely.

While on 32-bit  archs that construct is like "(unsigned int) (-300*HZ)", on 
64-bit archs to get a negative number we'd need something like:

(unsigned long)(long)(-300*HZ)

or

(unsigned long)(-300L*HZ)

so that the number is first sign-extended and then casted to unsigned.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
